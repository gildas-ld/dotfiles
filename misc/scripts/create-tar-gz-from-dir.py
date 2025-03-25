#!/usr/bin/env python3

import os
import subprocess
import sys
import tarfile
from datetime import datetime
from pathlib import Path


def main():
    # Définit le chemin du dossier courant
    current_dir = Path.cwd()

    # Récupère le nom du dossier courant
    dir_name = current_dir.name

    # Crée un timestamp au format YYYYMMDD_HHMMSS
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    # Construit le nom de l'archive selon le format demandé
    archive_name = f"src_{dir_name}_{timestamp}.tar.gz"

    # Utilise git pour obtenir la liste des fichiers à inclure (en excluant ceux du .gitignore)
    result = subprocess.run(
        ["git", "ls-files", "--cached", "--others", "--exclude-standard"],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        cwd=current_dir,
    )

    # Vérifie s’il y a eu une erreur lors de l'exécution de la commande git
    if result.returncode != 0:
        print("Erreur lors de l'exécution de git ls-files :", result.stderr)
        sys.exit(1)

    # Récupère la liste des fichiers à inclure dans l'archive
    files_to_include = [line for line in result.stdout.strip().split("\n") if line]

    # Crée l'archive tar.gz en y ajoutant uniquement les fichiers souhaités
    with tarfile.open(archive_name, "w:gz") as tar:
        for file_path in files_to_include:
            file_full_path = current_dir / file_path
            # Ajoute le fichier à l'archive avec un chemin relatif
            tar.add(file_full_path, arcname=file_path)


if __name__ == "__main__":
    main()
