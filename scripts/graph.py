import numpy as np
import matplotlib.pyplot as plt

R1 = 1_000
R2 = 20_000
C = 4e-9

f = np.logspace(0, 6, 1000)  # from 10^0 to 10^6

H = (R2 / R1) / np.sqrt(1 + (2 * 3.14159 * f * R2 * C) ** 2)

plt.figure(figsize=(16, 9))
plt.plot(f, H)

plt.xscale("log")
plt.xlabel(r"$\omega$")
plt.ylabel(r"$H(\omega)$")
# plt.title(r"Prenosna funkcija $H(\omega)$")

plt.grid(True, which="both", linestyle="--", linewidth=0.5)

plt.savefig("dest/calculated.png", dpi=300, bbox_inches="tight")

plt.show()
