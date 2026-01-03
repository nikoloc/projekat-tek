import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("data/measure-ac-analysis.csv")

plt.figure(figsize=(16, 9))

plt.xscale("log")

plt.plot(df["Frequency(Hz)"], df["Magnitude(dB)"], label="G")

plt.xlabel(r"$f[Hz]$")
plt.ylabel(r"$G[dB]$")
plt.grid(True, which="both", linestyle="--", linewidth=0.5)

plt.savefig(f"dest/measure-ac-analysis.png", dpi=300, bbox_inches="tight")

plt.show()
