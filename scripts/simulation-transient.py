import pandas as pd
import matplotlib.pyplot as plt

from pathlib import Path

import sys

file = sys.argv[1]

path = Path(file)
filename_no_ext = path.stem

# Load LTspice CSV
df = pd.read_csv(file, sep="\t")

plt.figure(figsize=(16, 9))

# Plot
plt.plot(df["time"], df["V_out"], label="V_out")
plt.plot(df["time"], df["V_in"], label="V_in")

plt.xlabel(r"$t[s]$")
plt.ylabel(r"$V[V]$")
plt.grid(True, which="both", linestyle="--", linewidth=0.5)

plt.legend()
plt.savefig(f"dest/{filename_no_ext}.png", dpi=300, bbox_inches="tight")

plt.show()
