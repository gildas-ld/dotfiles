augroup bash_shebang
    autocmd!
    autocmd BufNewFile *.sh 0put =\"#!/bin/bash\" | exe "normal G"
augroup END
autocmd BufWritePost *.sh !chmod +x %

function! AddVimAfterFence(i)
    if a:i % 2 == 1
        execute "normal! A vim"
    endif
    let i += 1
endfunction


function! AddVimEverySecondFencePerFile()
    let i = 0  " Réinitialiser le compteur pour chaque fichier
    let lastline = line('$')  " Récupère le nombre total de lignes du fichier

    for lnum in range(1, lastline)
        if getline(lnum) == '```'
            if i % 2 != 1
                call setline(lnum, '```vim')
            endif
            let i += 1
        endif
    endfor
endfunction

function! CreateFileOrDir()
    " Vérifie si le fichier sous le curseur existe
    if !filereadable(expand('<cfile>'))
        " Demande à l'utilisateur s'il souhaite créer le fichier
        let l:choice = input("Le fichier n'existe pas. Créer le fichier ou le dossier ? (f pour fichier, d pour dossier, n pour annuler) : ")
        if l:choice == 'f'
            " Crée le fichier vide
            execute "silent !touch " . expand('<cfile>')
            echo "Fichier créé : " . expand('<cfile>')
        elseif l:choice == 'd'
            " Crée le dossier
            execute "silent !mkdir -p " . expand('<cfile>')
            echo "Dossier créé : " . expand('<cfile>')
        else
            echo "Action annulée"
            return
        endif
    endif
    " Ouvre le fichier ou le dossier avec la commande gf
    normal! gf
endfunction

" Remap gf pour utiliser la nouvelle fonction
nnoremap <silent> gf :call CreateFileOrDir()<CR>

" Active l'enregistrement et la restauration de la dernière position
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction

nnoremap <leader>e :call FzyCommand("find . -type f", ":e")<cr>
nnoremap <leader>v :call FzyCommand("find . -type f", ":vs")<cr>
nnoremap <leader>s :call FzyCommand("find . -type f", ":sp")<cr>
