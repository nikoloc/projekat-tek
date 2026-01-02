import numpy as np
import matplotlib.pyplot as plt

points = [
    (1, 1.0),
    (2, 2.2),
    (5, 2.8),
    (10, 3.9),
    (20, 5.1),
    (50, 4.8),
    (200, 11),
]

# split into x and y
x = np.array([p[0] for p in points])
y = np.array([p[1] for p in points])

# polynomial fit
degree = 3
coeffs = np.polyfit(x, y, degree)
poly = np.poly1d(coeffs)

# mmooth x for plotting curve
x_fit = np.linspace(x.min(), x.max(), 300)
y_fit = poly(x_fit)

plt.xscale("log")

plt.scatter(x, y)
plt.plot(x_fit, y_fit, label=f"polynomial fit (deg {degree})")

plt.xlabel("w [Hz]")
plt.ylabel("V_out [V]")
plt.legend()
plt.grid(True)
plt.show()
