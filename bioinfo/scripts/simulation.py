import matplotlib.pyplot as plt
from numpy import mean, random

x = [0, 0, 1, 1, 1, 0, 1, 0, 0, 1]

mean(x)
sum(x) / len(x)

n = 100
p = 0.5
k = 1000

m = []
for i in range(k):
    m.append(mean(random.binomial(1, p, n)))

plt.hist(m, bins="auto")
plt.show()

n = 30
p = 0.5

y = random.choice([0, 1], n, replace=True)
m = []
for i in range(k):
    m.append(mean(random.choice(y, n, replace=True)))

plt.hist(m, bins="auto")
plt.show()
