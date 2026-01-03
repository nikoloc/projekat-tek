import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("data/measure-transient.csv")

plt.figure(figsize=(16, 9))

plt.plot(df["Time(S)"], df["CH2(V)"], label="V_out")
plt.plot(df["Time(S)"], df["CH1(V)"], label="V_in")

plt.xlabel(r"$t[s]$")
plt.ylabel(r"$V[V]$")
plt.grid(True, which="both", linestyle="--", linewidth=0.5)

plt.legend()
plt.savefig(f"dest/measure-transient.png", dpi=300, bbox_inches="tight")

plt.show()
