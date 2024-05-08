---
layout: post
title:  " Generating certificate files"
date:   2024-02-17 15:06:28 +0100
categories: ssl certificate
---

# How to generate ssl certificate

Generate certificate files:

```bash
# https://serverfault.com/questions/224122/what-is-crt-and-key-files-and-how-to-generate-them
openssl genrsa 2048 > host.key
openssl req -new -x509 -nodes -sha256 -days 365 -key server.key -out server.cert
```

`https://letsencrypt.org/getting-started/`
