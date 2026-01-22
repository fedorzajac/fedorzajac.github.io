---
layout: post
title:  "🧭 Fun with Raspberry pi and GPS module"
date:   2026-01-06 10:05:14 +0100
categories:
---

### Fun with Raspberry pi and GPS module

Orginal idea was to plot lake bottom depth. So I started with GPS. Later, I will add the ultrasonic distance sensor.

- GPS module micro USB NEO-6M NEO-7M NEO-8M satellite positioning 51 single-chip

There’s something oddly satisfying about connecting a tiny Raspberry Pi to the real world. Sensors, wires, serial ports — suddenly this little board isn’t just running Python scripts, it’s listening to satellites orbiting thousands of kilometers above us.

Recently I put together a small script to read GPS NMEA sentences directly from /dev/serial0 on a Raspberry Pi. It’s a minimal project, but it felt like opening a window into the invisible infrastructure that guides ships, planes, and pretty much every smartphone on Earth.

I wanted a lightweight way to grab live latitude and longitude from a GPS module without any heavy libraries or frameworks. Just raw serial data, a bit of parsing, and a clean printout of coordinates.

It’s the kind of project that reminds me why I enjoy tinkering with hardware — you write a few lines of Python, and suddenly you’re holding real‑time geolocation data in your hands.

### Code Explanation

The script opens a serial connection to the GPS module, listens for NMEA GPGLL messages, and converts the coordinates from the GPS‑specific degrees‑minutes format into standard decimal degrees.

Here’s the core idea:

- Open /dev/serial0 at 9600 baud
- Read incoming NMEA lines
- Look for $GPGLL sentences (latitude/longitude)
- Convert the GPS format (DDMM.MMMM) into decimal degrees
- Print the coordinates when the GPS reports a valid fix

```python
import serial

ser = serial.Serial("/dev/serial0", 9600, timeout=1)

def dm_to_deg(dm, hemi):
    if not dm:
        return None
    d = int(float(dm) / 100)
    m = float(dm) - d * 100
    deg = d + m / 60
    return -deg if hemi in ("S", "W") else deg

while True:
    line = ser.readline().decode("ascii", errors="ignore").strip()

    if not line.startswith("$"):
        continue

    parts = line.split(",")

    # --- GLL: position ---
    if parts[0] == "$GPGLL":
        status = parts[6]
        if status == "A":   # A = valid
            lat = dm_to_deg(parts[1], parts[2])
            lon = dm_to_deg(parts[3], parts[4])
            time_utc = parts[5]
            print(f"GLL FIX: {lat:.6f}, {lon:.6f} @ {time_utc}")
        else:
            print("GLL: no fix")

    # --- GSA: fix mode & DOP ---
    elif parts[0] == "$GPGSA":
        fix = parts[2]   # 1=no fix, 2=2D, 3=3D
        pdop, hdop, vdop = parts[-3:]
        print(f"GSA: fix={fix}, PDOP={pdop}, HDOP={hdop}")

    # --- GSV: satellites ---
    elif parts[0] == "$GPGSV":
        sats_in_view = parts[3]
        print(f"GSV: satellites in view = {sats_in_view}")

```
