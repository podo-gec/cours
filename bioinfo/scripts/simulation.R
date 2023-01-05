## Script illustratif de simulation de données binaires

## Exemple avec une séquence de 0/1 arbitraire
x <- c(0, 0, 1, 1, 1, 0, 1, 0, 0, 1)

mean(x)
sum(x) / length(x)

## Exemple de simulations répétées du calcul de la fréquence empirique des
## événements "1" dans k séquences aléatoires et indépendantes de taille n
## tirées dans une loi binomiale de paramètre p=0.5.
n <- 100
p <- 0.5
k <- 1000

m <- numeric(k)
for (i in 1:k) m[i] <- mean(rbinom(n, 1, p))

hist(m)

## Approche par bootstrap : au lieu de générer les séquences à partir d'une loi
## binomiale, on utilise un échantillon fixe pour générer de nouveaux
## échantillons (tirage avec remise).
n <- 30
p <- 0.5

y <- sample(c(0, 1), n, replace = TRUE)

m <- numeric(k)
for (i in 1:k) m[i] <- mean(sample(y, replace = TRUE))

hist(m)
