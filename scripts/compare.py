import re
import sys
import matplotlib.pyplot as plt
from pathlib import Path

freq = []
mag_db = []
phase_deg = []

# Regex for LTspice AC format
# Example:
# 1.000000e+00 (2.601979e+01dB,1.799708e+02°)
pattern = re.compile(r"([0-9.eE+-]+)\s+\(\s*([0-9.eE+-]+)dB,\s*([0-9.eE+-]+)°\s*\)")

with open("data/simulation-ac-analysis.txt", "r", encoding="cp1252") as f:
    header = next(f)  # skip header line (e.g. "f    G")

    for line in f:
        line = line.strip()
        if not line:
            continue

        match = pattern.match(line)
        if not match:
            continue

        freq.append(float(match.group(1)))
        mag_db.append(float(match.group(2)))
        phase_deg.append(float(match.group(3)))

plt.figure(figsize=(16, 9))
plt.semilogx(freq, mag_db, label="Simulation")
plt.xlabel(r"$f[Hz]$")
plt.ylabel(r"$G[dB]$")

import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("data/measure-ac-analysis.csv")

# plt.xscale("log")

plt.plot(df["Frequency(Hz)"], df["Magnitude(dB)"], label="Measured")

# plt.xlabel(r"$f[Hz]$")
# plt.ylabel(r"$G[dB]$")
plt.grid(True, which="both", linestyle="--", linewidth=0.5)

import numpy as np
import math

R1 = 1_000
R2 = 20_000
C = 4e-9

fr = np.logspace(0, 6, 1000)  # from 10^0 to 10^6

H = 20 * np.log10((R2 / R1) / np.sqrt(1 + (2 * 3.14159 * fr * R2 * C) ** 2))

plt.plot(fr, H, label="Theoretical")

# plt.xscale("log")
# plt.title(r"Prenosna funkcija $H(\omega)$")

plt.legend()
plt.savefig(f"dest/compare.png", dpi=300, bbox_inches="tight")

plt.show()
