---
layout: post
title:  "🎲 Run Rails7 app with ssl certificate"
date:   2024-02-18 20:01:43 +0100
categories: rails7 ssl certificate
---

# How to run rails7 application with ssl certificate

Generate certificate files:

```bash
# https://serverfault.com/questions/224122/what-is-crt-and-key-files-and-how-to-generate-them
openssl genrsa 2048 > host.key
openssl req -new -x509 -nodes -sha256 -days 365 -key server.key -out server.cert
```

```bash
# https://stackoverflow.com/questions/34991868/how-can-i-set-up-a-local-ssl-certificate-and-a-rails-application
rails s -b 'ssl://0.0.0.0:3000?key=server.key&cert=server.crt'
```

`https://letsencrypt.org/getting-started/`
