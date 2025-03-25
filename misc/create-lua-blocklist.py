import re
from collections import Counter

# Charge les domaines depuis un fichier .lua
def charger_trackers_depuis_fichier(nom_fichier):
    with open(nom_fichier, 'r', encoding='utf-8') as f:
        contenu = f.read()
    
    # Trouve les chaînes entre guillemets simples ou doubles dans la table Lua
    domaines = re.findall(r"['\"]([^'\"]+\.[a-z]+)['\"]", contenu)
    return domaines

# Extrait le domaine de second niveau depuis un domaine complet
def domaine_second_niveau(domaine):
    morceaux = domaine.split('.')
    if len(morceaux) >= 2:
        return '.'.join(morceaux[-2:])  # Prend l’avant-dernier et le dernier
    return domaine

# --- MAIN ---

# Mets ici le chemin vers ton fichier Lua
nom_fichier = 'monfichier.lua'

# Charge les domaines
domaines = charger_trackers_depuis_fichier(nom_fichier)

# Extrait les domaines de second niveau
domaines_second_niveau = [domaine_second_niveau(d) for d in domaines]

# Compte les occurrences
compteur = Counter(domaines_second_niveau)

# Affiche les plus fréquents
for domaine, nb in compteur.most_common():
    print(f'{domaine} : {nb}')

