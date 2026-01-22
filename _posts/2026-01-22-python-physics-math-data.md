---
layout: post
title:  "⏱️ Measuring Muon Decay Time"
date:   2026-01-22 10:02:40 +0100
categories: python physics math data
---

### Measuring Muon Decay Time

I recently put together a small Kaggle notebook exploring muon decay time. It’s a simple project, but one I really enjoyed. Muons are short‑lived cosmic particles, and watching an exponential decay curve emerge from real timing data feels almost magical.

The notebook isn’t meant to be groundbreaking—just a personal experiment where I load the data, clean it, plot the decay, and estimate the muon lifetime. Still, it reminded me why I love physics: even tiny particles can reveal big truths about how the universe works.

#### Results:
- Tau = 2.1693 ± 0.1932 µs
- Estimated tau uncertainty ≈ 0.0356 µs (tau/√N)

### Code Description

The code loads raw muon timing data from a CSV file and searches each waveform for negative pulses (values below –0.05), which indicate particle detection events. For every waveform, it groups consecutive pulse indices into blocks. If exactly two pulse blocks are found, it interprets them as two muon‑related signals and computes the time difference between them using the sampling rate (8 ns per sample). These time differences are converted to microseconds and collected.

Next, the code builds a histogram of all measured decay times and estimates the background noise by looking at long times (> 8 μs), where real muon decays are rare. It subtracts this background from the histogram and removes empty bins.

To extract the muon lifetime, it takes the logarithm of the corrected counts and performs a linear fit. The slope of this line gives the decay constant, from which the muon lifetime τ and its uncertainty are calculated. Finally, it prints both the fitted τ and a simple statistical estimate of its uncertainty.

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
rows = []
with open("/kaggle/input/muon-timing/muon_timing_data.csv") as f:
    for line in f:
        line = line.strip()
        if not line:
            continue
        info, index, *waveform = line.strip().split(",")
        # print(data)
        waveform = [float(v) for v in waveform if v.strip() != ""]
        pulses = [i for i, v in enumerate(waveform) if v < -0.05]
        rows.append(pulses)
df = pd.DataFrame(rows)
dt_samples = []

for index, pulses in df.iterrows():
    pulse_indices = [int(x) for x in pulses.dropna()]

    if not pulse_indices: # when you have [] empty data, just skip it
        continue

    blocks = []
    current = [pulse_indices[0]]
    for i in range(1, len(pulse_indices)):
        if pulse_indices[i] == pulse_indices[i-1] + 1:
            current.append(pulse_indices[i])
        else:
            blocks.append(current)
            current = [pulse_indices[i]]
    blocks.append(current)
    if len(blocks) == 2:
        delta_time = (blocks[1][0] - blocks[0][0]) * 8 # 125MS/s -> 8ns sampling rate
        # print("delta_time = ", delta_time)
        dt_samples.append(delta_time)
        dt_us = [x * 0.001 for x in dt_samples] # to get microseconds

plt.hist(dt_us, bins=100)
# plt.errorbar(bin_centers, counts, yerr=sigma_counts, fmt='o', markersize=3, capsize=3, color='red', label="√N errors")
plt.xlabel("dt (us)")
plt.ylabel("Counts")
plt.show()
```

![description](/assets/img/muon.png)


```python
# 2) Histogram (reasonable number of bins)
bins = 40
counts, bin_edges = np.histogram(dt_us, bins=bins)
bin_centers = 0.5 * (bin_edges[:-1] + bin_edges[1:])

# 3) Poisson errors
sigma_counts = np.sqrt(counts)

# 4 cleaning
# Selecting a time window where muons practically no longer exist
# e.g. > 8 microseconds
background_region = bin_centers > 8.0

# Average number of events in this region = background noise
background_level = np.mean(counts[background_region])
print("Background level =", background_level)

# get rid of bg noise
counts_corr = counts - background_level
# Replace negative values with zero
counts_corr[counts_corr < 0] = 0

# 5) Prepare data for fitting (remove bins with N=0)
mask = counts_corr > 0
t_fit = bin_centers[mask]
N_fit = counts_corr[mask]
y = np.log(N_fit)

# 6) Linear fit of the logarithm
p, cov = np.polyfit(t_fit, y, 1, cov=True)
m = p[0]     # slope
a = p[1]     # intercept
sigma_m = np.sqrt(cov[0, 0])

# 7) Compute tau and its uncertainty
tau = -1.0 / m
sigma_tau = sigma_m / (m**2)

print(f"Tau = {tau:.4f} ± {sigma_tau:.4f} µs")

# 8) Simple estimate of tau uncertainty ~ tau/sqrt(N)
N_events = len(dt_us)
sigma_tau_est = tau / np.sqrt(N_events)
print(f"Estimated tau uncertainty ≈ {sigma_tau_est:.4f} µs (tau/√N)")
```

- [Code on Kaggle][def2]
- [Original Data Source][def]


[def]: https://ciiec.buap.mx/Muon-Decay-Real-Data/
[def2]: https://www.kaggle.com/code/fedorzajac/muon-decay
