#!/usr/bin/bash

# Make zsh know about hosts already accessed by SSH
# alias find="find -print 2>/dev/null "
alias "?"="apropos"
alias 'gc!'='git commit -v --amend'
alias 'gca!'='git commit -v -a --amend'
alias 'gcan!'='git commit -v -a --no-edit --amend'
alias 'gcans!'='git commit -v -a -s --no-edit --amend'
alias 'gcn!'='git commit -v --no-edit --amend'
alias 'gpf!'='git push --force'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias RM='rm -rfv'
alias _='sudo '
alias alg="alias | grep"
alias an="awk_netstat.sh"
alias bc='bc -l'
alias c="clear"
alias cajo='/usr/bin/caja --no-desktop "${1:-.}"'
alias calc='perl -pe "print eval(\$_) . chr(10);"'
alias cd-top='cd $(git rev-parse --show-toplevel)'
alias cd...='cd ../..'
alias cd..='cd ..'
alias chmod="chmod -c -v"
alias clr='clear; echo Currently logged in on $TTY, as $USERNAME in directory $PWD.'
alias connect-lan="sudo nmcli device disconnect wlp0s20f3 ; sudo nmcli device connect enp0s20f0u2c4i2"
alias count="_count() { find "${1:-.}" -type f | wc -l }; _count"
alias cp="cp -iv"
alias cp="cp -iva"
alias cp="rsync -ah --stats --info=progress2"
alias cpdvd="touch /media/ramdisk/1.iso && dd if=/dev/sr0 of=/media/ramdisk/1.iso status=progress"
alias ct='echo $(git rev-parse --show-toplevel)'
alias dc="docker-compose"
alias dcd="docker-compose down"
alias dcres="docker-compose down && docker-compose up -d"
alias dcu="docker-compose up -d"
alias deenv="_desenv() { source ./venv/bin/deactivate && echo $VIRTUAL_ENV }; _desenv"
alias denv="_desenv() { source ./venv/bin/deactivate && echo $VIRTUAL_ENV }; _desenv"
alias desenv="_desenv() { source ./venv/bin/deactivate && echo $VIRTUAL_ENV }; _desenv"
alias df="df -Tha --total"
alias dl="aria2c"
alias du="du -h"
alias dud='du -d 1 -h'
alias duf="/usr/bin/duf"
alias duf='du -sh *'
alias dumpTrash='find ~/.local/share/Trash -type f -exec rm {} \;'
alias e="vim"
alias ebash="vim ~/.bashrc"
alias ee="exit"
alias egit="vim ~/.gitconfig"
alias es="vim ~/.config/sway/config"
alias esw="vim ~/.config/sway/config"
alias ev="ev() { echo \$VIRTUAL_ENV }; ev"
alias evim="vim ~/.vimrc"
alias exp="/usr/bin/explain.sh"
alias explain="exp=/usr/bin/explain.sh"
alias fastping='ping -c 100 -s.2'
alias fcl="fc -l"
alias fd='find . -type d -iname'
alias ff='find "${1:-.}" -type f -iname'
alias filesmissing='find . -maxdepth 2 -xtype l'
alias filesunder='find . \( -name .git -type d \) -prune -o -type f -printf "%P\0 "'
alias firewall="iptlist"
alias format-xml="npx prettier --parser=html --write '{,!(node_modules)/**/}*.svg*'"
alias free="free -h"
alias free="free -mt"
alias fstab_print="sed 's/#.*//' /etc/fstab | column --table --table-columns SOURCE,TARGET,TYPE --table-hide -"
alias fz=_fz
alias g='git'
alias ga='git add --verbose "${1:-.}" '
alias ga='git add'
alias gaa='git add --all'
alias gada="git add --all ; git commit -m $(date +"(%A %d %B %Y) - %Hh %Mm %Ss")"
alias gada='git add --all ; git commit -m (vendredi 16 septembre 2022) - 10h 51m 19s'
alias gadap="git add --all ; git commit -m $(date +"(%A %d %B %Y) - %Hh %Mm %Ss") ; git push"
alias gadap='git add --all ; git commit -m (vendredi 16 septembre 2022) - 10h 51m 19s ; git push'
alias gam='git am'
alias gama='git am --abort'
alias gamc='git am --continue'
alias gams='git am --skip'
alias gamscp='git am --show-current-patch'
alias gap='git apply'
alias gapa='git add --patch'
alias gapt='git apply --3way'
alias gau='git add --update'
alias gav='git add --verbose "${1:-.}" '
alias gb='git branch'
alias gbD='git branch -D'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbda='git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch -d 2>/dev/null'
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gc!='git commit -v --amend'
alias gc='git commit -v'
alias gca!='git commit -v -a --amend'
alias gca='git commit -v -a'
alias gcam='git commit -a -m'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcas='git commit -a -s'
alias gcasm='git commit -a -s -m'
alias gcb='git checkout -b'
alias gcd='git checkout $(git config gitflow.branch.develop)'
alias gcd='git checkout $(git_develop_branch)'
alias gcf='git config --list'
alias gch='git checkout $(git config gitflow.prefix.hotfix)'
alias gcl='git clone --recurse-submodules'
alias gclean='git clean -id'
alias gcm='git checkout $(git_main_branch)'
alias gcmsg='git commit -m'
alias gcn!='git commit -v --no-edit --amend'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcr='git checkout $(git config gitflow.prefix.release)'
alias gcs='git commit -S'
alias gcsm='git commit -s -m'
alias gcss='git commit -S -s'
alias gcssm='git commit -S -s -m'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdup='git diff @{upstream}'
alias gdw='git diff --word-diff'
alias genpu="LC_ALL=C genp | sha512sum | fold -w 42 | head -n 1 |  tr '[:lower:]' '[:upper:]'"
alias gf='git fetch'
alias gfa='git fetch --all --prune --jobs=10'
alias gfg='git ls-files | grep'
alias gfi="git flow init -d"
alias gfl="git flow"
alias gfl='git flow'
alias gflf='git flow feature'
alias gflff='git flow feature finish'
alias gflffc='git flow feature finish ${$(git_current_branch)#feature/}'
alias gflfp='git flow feature publish'
alias gflfpc='git flow feature publish ${$(git_current_branch)#feature/}'
alias gflfpll='git flow feature pull'
alias gflfs='git flow feature start'
alias gflh='git flow hotfix'
alias gflhf='git flow hotfix finish'
alias gflhfc='git flow hotfix finish ${$(git_current_branch)#hotfix/}'
alias gflhp='git flow hotfix publish'
alias gflhpc='git flow hotfix publish ${$(git_current_branch)#hotfix/}'
alias gflhs='git flow hotfix start'
alias gfli='git flow init'
alias gflr='git flow release'
alias gflrf='git flow release finish'
alias gflrfc='git flow release finish ${$(git_current_branch)#release/}'
alias gflrp='git flow release publish'
alias gflrpc='git flow release publish ${$(git_current_branch)#release/}'
alias gflrs='git flow release start'
alias gfo='git fetch origin'
alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ggca='_ggca(){ google-closure-compiler -O ADVANCED --js "$1" --js_output_file ggca.min.js }; _ggca'
alias ggco='_ggco(){ google-closure-compiler --js "$1" --js_output_file ggco.min.js }; _ggco'
alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpur='ggu'
alias ggpush='git push origin "$(git_current_branch)"'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias ghh='git help'
alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias git-svn-dcommit-push='git svn dcommit && git push github $(git_main_branch):svntrunk'
alias git-top='cd $(git rev-parse --show-toplevel)'
alias gitkraken='/home/gildas/Téléchargements/gitkraken-amd64/gitkraken/gitkraken > /dev/null 2>&1 &'
alias gitroot='cd $(git rev-parse --show-toplevel)'
alias gk='\gitk --all --branches &!'
alias gke='\gitk --all $(git log -g --pretty=%h) &!'
alias gl='git pull'
alias glg='git log --stat'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glgp='git log --stat -p'
alias glo='git log --oneline --decorate'
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glod='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glods='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'' --date=short'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glol='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias glola='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --all'
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
alias glols='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --stat'
alias glp="_git_log_prettily"
alias glp=_git_log_prettily
alias gluc='git pull upstream $(git_current_branch)'
alias glum='git pull upstream $(git_main_branch)'
alias gm='git merge'
alias gma='git merge --abort'
alias gmom='git merge origin/$(git_main_branch)'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/$(git_main_branch)'
alias go-top='cd $(git rev-parse --show-toplevel)'
alias gp='git pull'
alias gp='git push'
alias gpd='git push --dry-run'
alias gpf!='git push --force'
alias gpf='git push --force-with-lease'
alias gpoat='git push origin --all && git push origin --tags'
alias gpr='git pull --rebase'
alias gpra="git pull --rebase --autostash"
alias gpristine='git reset --hard && git clean -dffx'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpu='git push upstream'
alias gpush='git push'
alias gpv='git push -v'
alias gr='cd $(git rev-parse --show-toplevel)'
alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase $(git_develop_branch)'
alias grbi='git rebase -i'
alias grbm='git rebase $(git_main_branch)'
alias grbo='git rebase --onto'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbs='git rebase --skip'
alias grep='grep --color=tty -d skip -i '
alias grep='grep -i --color=auto'
alias grev='git revert'
alias grh='git reset'
alias grhh='git reset --hard'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias grst='git restore --staged'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'
alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gst='git status'
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstall='git stash --all'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gstu='gsta --include-untracked'
alias gsu='git submodule update'
alias gsw='git switch'
alias gswc='git switch -c'
alias gswd='git switch $(git_develop_branch)'
alias gswm='git switch $(git_main_branch)'
alias gt='cd $(git rev-parse --show-toplevel)'
alias gtl='gtl(){ git tag --sort=-v:refname -n -l "${1}*" }; noglob gtl'
alias gto='cd $(git rev-parse --show-toplevel)'
alias gtop='cd $(git rev-parse --show-toplevel)'
alias gts='git tag -s'
alias gtv='git tag | sort -V'
alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gup='git pull --rebase'
alias gupa='git pull --rebase --autostash'
alias gupav='git pull --rebase --autostash -v'
alias gupom='git pull --rebase origin $(git_main_branch)'
alias gupomi='git pull --rebase=interactive origin $(git_main_branch)'
alias gupv='git pull --rebase -v'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
alias h="history"
alias h='history'
alias header='curl -I'
alias headerc='curl -I --compress'
alias help='man'
alias hg="history | grep -i "
alias hgrep="fc -El 0 | grep -i --color=auto"
alias hhead="head -30"
alias inke='s=$1 ; _ink(){ inkscape --export-type=png "$1" -o "${s%.*}.png" -d ${2:-300} -w ${3:-1024} }; _ink'
alias inr="grep -inr"
alias ip="ip -color -brief"
alias ip='ip -color -all -human a'
alias jb="web; dg"
alias k9="kill -9 %1"
alias k="kill -9 "
alias kusr="kill -9 -1"
alias l="bash -c 'compgen -c | sort -u | fzf | xargs -r swaymsg -t command exec'"
alias l="ls -lAh -F -G --color=auto --time=atime --time-style=+'%d %b%Y %H:%M'"
alias l='ls -lFh' # size,show type,human readable
alias lS='ls -1FSsh'
alias la='ls -lAFh' #long list,show almost all,show type,human readable
alias lart='ls -1Fcart'
alias launch="bash -c 'compgen -c | sort -u | fzf | xargs -r swaymsg -t command exec'"
alias ldot='ls -ld "${1:-.}"*'
alias lfz="ls -lAhrt | fzf "
alias ll='ls -l'
alias ll='ls -l' #long list
alias lm="ls -lAh -F -G --color=auto --time=atime --time-style=+'%d %b%Y %H:%M'"
alias lr='ls -tRFh' #sorted by date,recursive,show type,human readable
alias lrt='ls -1Fcrt'
alias ls="ls -lAh -F -G --color=auto --time=mtime --time-style=+'%d %b%Y %H:%M'"
alias ls="ls -lAhltr -F -G --color=auto --time=atime --time-style=+'%d %b%Y %H:%M'"
alias lsArth="ls -lArth"
alias lsa="ls -lArth -F -G --color=auto --time-style=+'%d %b%Y %H:%M'"
alias lsarth="ls -larth"
alias lsf='ls -lArth -F -G --color=auto --time-style=+'\''%d %b%Y %H:%M'\'' | fzf'
alias lsn='ls -1'   #A column contains name of files and directories
alias lt='ls -ltFh' #long list,sorted by date,show type,human readable
alias m="mariadb --user=$USER"
alias meminfo='free -m -l -t'
alias mkdir="mkdir -pv"
alias mkenv="_mkenv() { python3 -m venv venv && source ./venv/bin/activate && echo $VIRTUAL_ENV }; _mkenv"
alias mksri='s=$1 ; _mksri(){ cat "$1" | openssl dgst -sha${2:-512} -binary | openssl enc -base64 -A | strings }; _mksri'
alias mkvenv="_mkenv() { python3 -m venv venv && source ./venv/bin/activate && echo $VIRTUAL_ENV }; _mkenv"
alias mnt="mount | grep -E '^/dev' | column -t"
alias mv='mv -iv'
alias n='nnn'
alias naf="npm audit fix"
alias nb='npm run build'
alias nd='npm run dev'
alias nf="_nf(){ npx prettier --write --ignore-unknown --insert-pragma  ${1:-$PWD} }; _nf"
alias ni='npm install'
alias nid='npm install --dev'
alias nn='nnn'
alias nomnom='killall'
alias nr="grep -nri"
alias nri="grep -nri"
alias ns='npm start'
alias ntpd="ntpd -u ntp:ntp"
alias numfiles='find "${1:-.}" -type f | wc -l'
alias o='xdg-open'
alias oct2dec='f(){ echo "obase=10; ibase=8; $1" | bc; unset -f f; }; f'
alias p="ps aux | grep -i --color=auto"
alias p='ps aux | grep -i --color=auto'
alias path='echo -e ${PATH//:/\\n}'
alias path='print -l $path'
alias pbc="php bin/console"
alias pc="pwd -P | xclip -selection clipboard"
alias pdate="date +"%Y-%m-%d__%s""
# Detect the OS and define the appropriate alias
# perm: Show permission of target in number
if [[ "$(uname)" == "Darwin" ]]; then
	# macOS (Darwin)
	alias perm='stat -f "%Lp %N" *'
else
	# Linux (assumes GNU coreutils)
	alias perm='stat --printf="%a %n\n" *'
fi
alias phpcbf="~/.config/composer/vendor/bin/phpcbf"
alias phpcs="~/.config/composer/vendor/bin/phpcs"
alias phps='php -S localhost:8000'
alias pk="pgrep $1 | xargs kill -9"
alias pk="val=$1; _pk(){ pgrep $val | xargs kill -9 }; _pk"
alias plz='pwd'
alias pm="python3 manage.py"
alias ports="netstat -tulanp"
alias pp="pwd"
alias psCPU='ps aux --sort -%cpu'
alias psCPUusage='ps aux | sort -nk 3'
alias psMEMusage='ps aux | sort -nk 4'
alias psMem='ps aux --sort -%mem'
alias psby_cpu='ps -eo pcpu,pmem,stat,user,pid,ppid,args | sort -k 1  | cut -c -90'
alias psby_cpuusage='ps aux | sort -n -k 3'
alias psby_mem='ps -eo pmem,pcpu,stat,user,pid,ppid,args | sort -k 1  | cut -c -90'
alias psby_memusage='ps aux | sort -n -k 4'
alias psby_pid='ps aux | sort -nk 2'
alias psby_user='ps aux | sort -k 1'
alias pwd="pwd -P"
alias pym="python3 manage.py"
alias raf='rm -rf '
alias reboot="systemctl reboot -i"
alias redshift='gammastep'
alias resign="!re() { git rebase --exec 'git commit --amend --no-edit -n -S' -i (; }; re"
alias rm!='\rm -rf'
alias rm='rm -iv'
alias rsync-copy='rsync -av'
alias rsync-move='rsync -av --info=progress2 --remove-source-files'
alias rsync-move='rsync -av --remove-source-files'
alias rsync-synchronize='rsync -avzu --delete'
alias rsync-update='rsync -avu'
alias rsync-update='rsync -avzu '
alias rsync="rsync -ah --stats --info=progress2"
alias rsyncd='rsync --delete-during -ahz --stats --info=progress2'
alias s="sudo -s"
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias sen="systemctl enable"
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
alias shfmt='shfmt --write --simplify --indent 0 --space-redirects'
alias show-top='echo $(git rev-parse --show-toplevel)'
alias showtop='echo $(git rev-parse --show-toplevel)'
alias shred="shred --iterations=7 --verbose --zero --remove"
alias sht='echo $(git rev-parse --show-toplevel)'
alias sif='s=$1 ; _sif(){ pacman -Qlq "$1" | grep -i --color=auto -v "/$" | xargs -r du -h | sort -h }; _sif'
alias sii="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias siii="pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse"
alias sm='(nohup smerge "${1:-.}" >/dev/null 2>&1 & disown)'
alias sortnr='sort -n -r'
alias srel="systemctl reload"
alias ssg="ss -tulnpa | grep"
alias sss="symfony server:start"
alias sst="symfony server:stop"
alias sstart="systemctl start"
alias sstop="systemctl stop"
alias sudo='sudo -E '
alias sy="symfony"
alias t='tail -f'
alias take-screenshot='grim -g "$(slurp)" screenshot.png'
alias tarc='tar -cvzf'
alias tarx='tar -xvzf'
alias tcn="mv --force -t ~/.local/share/Trash/files"
alias tee="tee -a"
alias top="htop"
alias trash="mv --force -t ~/.local/share/Trash/files"
alias trc="truncate -s 0"
alias tree="tree -FC --charset=ascii"
alias tree='tree -a -I .git --dirsfirst'
alias trnc="truncate -s 0"
alias trunc="truncate -s 0"
alias truncate="truncate -s 0"
alias try="gnome-open"
alias ui="uuidgen |  tr -d \- | tr a-z A-Z"
alias uid="uuidgen |  tr -d \- | tr a-z A-Z"
alias unexport='unset'
alias utc='env TZ=UTC date'
alias v="vim"
alias vim="vim"
alias watchdir="watch -n .5 ls -la"
alias watchsize="watch -n .5 du -h –max-depth=1"
alias watchtail="watch -n .5 tail -n 20"
alias wget="wget -c"
alias wifi_off="nmcli radio wifi off"
alias wifi_on="nmcli radio wifi on"
alias wish="which"
alias wtl="journalctl -f -p 4"
alias wtw="journalctl -f -p 3"
alias x="xplr"
alias zcc='s=$1 ; _zcc(){ gcc -Wall -Wextra -pedantic -fno-common -fno-builtin "$1" -o main }; _zcc'
alias zh="fc -l -d -D"
alias zsh='bash'
alias zz='z -t'

function ip() {
	if [ -t 1 ]; then
		command ip -color -all -human "$@"
	else
		command ip -all -human "$@"
	fi
}

function psgrep() {
	ps aux | grep "${1:-.}" | grep -v grep
}

# Kills any process that matches a regexp
function killit() {
	ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}

# Printing process according to the port number
function port-process() {
	netstat -tulpna | grep "${1}" | awk '{print $7}' | cut -d/ -f1
}

# Delete 0 byte file
function delete-0-bytes-files() {
	find "${1:-.}" -type f -size 0 -exec rm -rf {} \;
}

# gather external ip address
function pubip() {
	possibleResolvers=(
		'https://ifcfg.me/json'
		'https://myexternalip.com/json'
		'https://api.ipify.org?format=json'
		'https://ipinfo.io/json'
		'https://ifcfg.me/json'
	)
	while true; do
		resolver=${possibleResolvers[$((RANDOM % ${#possibleResolvers[@]}))]}
		json=$(curl --silent --insecure $resolver 2>/dev/null)
		if [ -n "$json" ]; then
			ip=$(echo "$json" | awk -F'"' '/"ip":/ {print $4}')
			if [ -n "$ip" ]; then
				echo $json | jq
				break
			fi
		fi
		# echo "Retrying..."
		sleep 0.01
	done
}

function puboip() {
	possibleResolvers=('https://ifcfg.me/json' 'https://myexternalip.com/json' 'https://api.ipify.org?format=json' 'https://ipinfo.io/json' 'https://ifcfg.me/json')
	while true; do
		resolver=${possibleResolvers[$((RANDOM % ${#possibleResolvers[@]}))]}
		json=$(curl --silent --insecure $resolver 2>/dev/null)
		if [ -n "$json" ]; then
			ip=$(echo "$json" | awk -F'"' '/"ip":/ {print $4}')
			wholeFetch="$json"
			if [ -n "$ip" ]; then
				echo $ip
				break
			fi
		fi
		# echo "Retrying..."
		sleep 0.1
	done
}

function update_dynu_ip() {

	public_ip=$(puboip)

	if [ -n "$public_ip" ]; then
		printf "%s\n" "$public_ip"
		curl --request GET --url "https://api.dynu.com/nic/update?hostname=$DYNU_HOSTNAME&myip=$public_ip&password=$DYNU_PWD"
	else
		echo "Impossible de récupérer l'IP publique."
	fi
}

# determine local IP address(es)
function getIP() {
	ifconfig | awk '/inet /{print $2}' | command grep -v 127.0.0.1
}

# Clear zombie processes
function clear-zombies() {
	ps -eal | awk '{ if ($2 == "Z") {print $4}}' | kill -9
}
function lsofpid() {
	lsof -a -p "${1:-'1'}"
}

function lsofnet() {
	lsof -i -n -P
}

function ssemul() {
	lsof -i -n -P
	netstat -an | grep -E 'Proto|LISTEN'
}

function genRandMAC() {
	# (stdbuf -o0 tr -dc A-F0-9 < /dev/urandom | head -c 10 | sed -r 's/(..)/\1:/g;s/:$//;s/^/02:/')  2>/dev/null
	# (tr -dc A-F0-9 < /dev/urandom | head -c 10 | sed -r 's/(..)/\1:/g;s/:$//;s/^/02:/' ) 2>/dev/null
	# hexdump -n6 -e '6/1 ":%02x"' /dev/urandom | awk ' { sub(/^:../, "02"); print } '
	(cat /dev/urandom | tr -dc 'A-F0-9' | head -c 10 | sed -r 's/(..)/\1:/g;s/:$//;s/^/02:/') 2>/dev/null
}

function sysstats() {

	# Définition des couleurs
	NC="\033[0m"
	RED="\033[0;31m"
	MAGENTA="\033[0;35m"
	BOLD="\033[1m"
	export LC_TIME=fr_FR.UTF-8

	# Affiche le nombre d'utilisateurs connectés
	echo -e "${MAGENTA}Utilisateurs :${NC} $(who | wc -l)"

	# Affiche la charge moyenne du système
	echo -e "${MAGENTA}Charge${NC} :$(uptime | awk -F'load average:' '{print $2}')"
	# Informations sur la mémoire
	memoire_disponible=$(/usr/bin/free -m | awk 'NR==2{print $7}')
	memoire_utilisee=$(/usr/bin/free -m | awk 'NR==2{print $3}')
	memoire_total=$(/usr/bin/free -m | awk 'NR==2{print $2}')

	if [[ $memoire_total -ne 0 ]]; then
		pourcentage_memoire_utilisee=$((memoire_utilisee * 100 / memoire_total))
	else
		pourcentage_memoire_utilisee=0
	fi

	# Affiche la mémoire utilisée avec des couleurs
	printf "${MAGENTA}Mémoire utilisée${NC} : %'d Mo sur %'d Mo [${MAGENTA}%'d %%${NC}]\n" "$memoire_utilisee" "$memoire_total" "$pourcentage_memoire_utilisee"

	# Espace disque disponible pour la racine (/) en kilo-octets
	espace_disponible=$(/usr/bin/df --output=avail -k / | tail -n 1 | tr -d ' ')
	espace_disque_utilise=$(/usr/bin/df --output=used -k / | tail -n 1 | tr -d ' ')
	espace_disque_total=$((espace_disponible + espace_disque_utilise))
	espace_disponible_en_mo=$(echo "$espace_disponible" | awk '{print $1/1024}')
	espace_disponible_en_go=$(echo "$espace_disponible" | awk '{print $1/1024/1024}')
	espace_disque_utilise_en_mo=$(echo "$espace_disque_utilise" | awk '{print $1/1024}')
	espace_disque_utilise_en_go=$(echo "$espace_disque_utilise" | awk '{print $1/1024/1024}')

	# Pourcentage d'utilisation du disque
	pourcentage_utilisation_disque=$(/usr/bin/df --output=pcent -k / | tail -n 1 | tr -d ' %')
	pourcentage_utilisation_disque_2=$((espace_disque_utilise * 100 / espace_disque_total))

	# Affiche l'espace disque disponible avec des couleurs
	echo -e "${MAGENTA}Disque utilisé${NC} : $(printf "%.2f" "$espace_disque_utilise_en_go") G (soit $(printf "%'d" "$espace_disponible_en_mo") Mo) [${MAGENTA}${pourcentage_utilisation_disque} %${NC}]"

}

for cmd in chmod chown; do
	alias $cmd="$cmd --changes"
done

for cmd in rm rename; do
	alias $cmd="$cmd -v"
done
alias del-vim-files="find . -type f -name '*.un~' -exec rm -v {} +"

encrypt_file() {
	local USE_PASSWORD=false
	local key_source
	local fichier_a_chiffrer
	local output_file
	local password
	while getopts "pf:k:" opt; do
		case $opt in
		p) USE_PASSWORD=true ;;
		f) fichier_a_chiffrer="$OPTARG" ;;
		k) key_source="$OPTARG" ;;
		\?)
			print_color "$RED" "Option invalide : -$OPTARG" >&2
			return 1
			;;
		esac
	done
	shift $((OPTIND - 1))
	if [[ -z $fichier_a_chiffrer ]]; then
		print_color "$RED" "Erreur : Aucun fichier à chiffrer spécifié. Utilisation : encrypt_file -f <fichier> [-k <clé> | -p]" >&2
		return 1
	fi
	if [[ ! -f $fichier_a_chiffrer ]]; then
		print_color "$RED" "Erreur : Le fichier à chiffrer '$fichier_a_chiffrer' n'existe pas." >&2
		return 1
	fi
	output_file="${1:-$fichier_a_chiffrer.enc}"
	if $USE_PASSWORD; then
		password=$(read_password)
	else
		if [[ -n $key_source ]]; then
			password=$(get_key_from_file "$key_source")
		else
			password=$(get_key_from_file)
		fi
	fi
	if [[ -z $password ]]; then
		print_color "$RED" "Erreur : Aucun mot de passe ou clé valide fourni !" >&2
		return 1
	fi
	openssl enc -e -aes-256-cbc -base64 -A -salt -pbkdf2 -iter 100000 -bufsize 524288 -pass pass:"$password" -in "$fichier_a_chiffrer" -out "$output_file"
	if [[ $? -eq 0 ]]; then
		print_color "$GREEN" "Le fichier a été chiffré avec succès et enregistré dans '$output_file'."
	else
		print_color "$RED" "Erreur lors du chiffrement du fichier."
		return 1
	fi
}
decrypt_file() {
	local USE_PASSWORD=false
	local key_source
	local fichier_a_dechiffrer
	local output_file
	local password
	while getopts "pf:k:" opt; do
		case $opt in
		p) USE_PASSWORD=true ;;
		f) fichier_a_dechiffrer="$OPTARG" ;;
		k) key_source="$OPTARG" ;;
		\?)
			print_color "$RED" "Option invalide : -$OPTARG" >&2
			return 1
			;;
		esac
	done
	shift $((OPTIND - 1))
	if [[ -z $fichier_a_dechiffrer ]]; then
		print_color "$RED" "Erreur : Aucun fichier à déchiffrer spécifié. Utilisation : decrypt_file -f <fichier> [-k <clé> | -p]" >&2
		return 1
	fi
	if [[ ! -f $fichier_a_dechiffrer ]]; then
		print_color "$RED" "Erreur : Le fichier à déchiffrer '$fichier_a_dechiffrer' n'existe pas." >&2
		return 1
	fi
	output_file="${1:-${fichier_a_dechiffrer%.enc}}"
	if [[ -e $output_file ]]; then
		print_color "$YELLOW" "Attention :\nLe fichier '$output_file' existe déjà. Voulez-vous le remplacer ? (o/n)"
		read -r choix
		if [[ $choix != [oO] ]]; then
			print_color "$BLUE" "Déchiffrement annulé."
			return 1
		fi
	fi
	if $USE_PASSWORD; then
		password=$(read_password)
	else
		if [[ -n $key_source ]]; then
			password=$(get_key_from_file "$key_source")
		else
			password=$(get_key_from_file)
		fi
	fi
	if [[ -z $password ]]; then
		print_color "$RED" "Erreur :\nAucun mot de passe ou clé valide fourni !" >&2
		return 1
	fi
	openssl enc -d -aes-256-cbc -base64 -A -salt -pbkdf2 -iter 100000 -bufsize 524288 -pass pass:"$password" -in "$fichier_a_dechiffrer" -out "$output_file"
	if [[ $? -eq 0 ]]; then
		print_color "$GREEN" "Le fichier a été déchiffré avec succès et enregistré dans '$output_file'."
	else
		print_color "$RED" "Erreur lors du déchiffrement du fichier."
		rm -v -f -v "$output_file"
		return 1
	fi
}

# Alias

alias dec-file=decrypt_file
alias decfile=decrypt_file
alias decf=decrypt_file

alias enc-file=encrypt_file
alias encfile=encrypt_file
alias encf=encrypt_file

# LC_ALL=C head -c 42 /dev/urandom | base64 | tee $PWD/key.key
