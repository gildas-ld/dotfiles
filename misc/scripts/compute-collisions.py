import math

# Nombre de générations
n = 1.5 * 10**9
ln2 = math.log(2)

# Calcul de N (taille de l'espace de valeurs)
N = (n**2) / (2 * ln2)

# Nombre d'octets nécessaires (puisque N = 2^(8*octets))
num_bytes = math.ceil(math.log2(N) / 8)

print(N, num_bytes)
