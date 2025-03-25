import re
from collections import Counter

# Charge les domaines depuis un fichier hosts
def charger_trackers_depuis_hosts(nom_fichier):
    domaines = []
    with open(nom_fichier, 'r', encoding='utf-8') as f:
        for ligne in f:
            ligne = ligne.strip()
            # Ignore les commentaires et les lignes vides
            if not ligne or ligne.startswith('#'):
                continue
            # Essaie de capturer l'hôte après l'IP (supposée être 0.0.0.0 ou 127.0.0.1)
            parties = ligne.split()
            if len(parties) >= 2:
                domaine = parties[1]
                domaines.append(domaine)
    return domaines

# Extrait le domaine de second niveau depuis un domaine complet
def domaine_second_niveau(domaine):
    morceaux = domaine.split('.')
    if len(morceaux) >= 2:
        return '.'.join(morceaux[-2:])  # Prend l’avant-dernier et le dernier
    return domaine

# --- MAIN ---
# Mets ici le chemin vers ton fichier hosts
nom_fichier = 'hosts_.txt'

# Charge les domaines
domaines = charger_trackers_depuis_hosts(nom_fichier)

# Extrait les domaines de second niveau
domaines_second_niveau = [domaine_second_niveau(d) for d in domaines]

# Compte les occurrences
compteur = Counter(domaines_second_niveau)

# Affiche les plus fréquents
for domaine, nb in compteur.most_common():
    print(f'{domaine} : {nb}')

