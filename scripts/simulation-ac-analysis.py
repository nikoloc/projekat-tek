import re
import matplotlib.pyplot as plt

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
plt.semilogx(freq, mag_db)
plt.xlabel(r"$f[Hz]$")
plt.ylabel(r"$G[dB]$")
plt.grid(True)

plt.savefig(f"dest/simulation-ac-analysis.png", dpi=300, bbox_inches="tight")

plt.show()
