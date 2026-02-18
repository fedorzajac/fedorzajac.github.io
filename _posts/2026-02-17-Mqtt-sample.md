---
layout: post
title:  "✉️ Minimal MQTT Demo with Docker and Python"
date:   2026-02-11 10:05:53 +0100
categories: mqtt python automation
---

First things first, let's start with clear terms

| Aspect | MQTT | Kafka |
|------|------|------|
| Full name | Message Queuing Telemetry Transport | Apache Kafka |
| Main purpose | Lightweight messaging | Distributed event streaming |
| Typical use case | IoT, sensors, embedded devices | Data pipelines, analytics, microservices |
| Communication model | Publish / Subscribe | Publish / Subscribe (via topics & partitions) |
| Message size | Very small | Small to large |
| Message persistence | Optional / limited | Core feature (durable storage) |
| Replay messages | No (by default) | Yes |
| Ordering | Best effort | Guaranteed within partition |
| Scalability focus | Large number of devices | High event throughput |
| Resource usage | Very low | High |
| Network conditions | Unreliable, low-bandwidth | Reliable, high-bandwidth |
| Latency | Very low | Low to moderate |
| Typical consumers | Devices, lightweight services | Backend services, stream processors |


I put together a very small MQTT demo project to refresh the basics and make sure I really understand the moving parts (and not just copy-paste snippets).

The setup is intentionally minimal. A Mosquitto broker is started via Docker Compose, so there’s no local installation hassle and the environment is fully reproducible. Once the broker is running, everything else talks to it over `localhost`.

On the client side, there are two simple Python scripts using `paho-mqtt`.

- **`subscribe.py`** acts as a long-running subscriber, listening on a single topic and printing any incoming messages. Nothing fancy, just a callback and an infinite loop — simple enough to clearly see what’s going on.
- **`publish.py`** does the opposite: it connects to the broker, publishes a single value to the same topic, and exits. The message can be passed via CLI, which makes it easy to simulate changing sensor values or quick test events.

The whole point of this mini-project is clarity over complexity. One topic, one publisher, one subscriber, no abstractions, no frameworks. You start the broker, run the subscriber, publish a message, and immediately see the result.

Sometimes it’s useful to strip things down to the bare minimum — just to be sure you actually understand how the pieces fit together.

---

[https://github.com/fedorzajac/mqtt](https://github.com/fedorzajac/mqtt)
