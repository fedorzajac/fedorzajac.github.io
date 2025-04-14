---
layout: post
title:  "🥤 golang https server"
date:   2025-03-22 20:50:37 +0100
categories: go golang server https ssl web gin
---

### Run golang gin/gonic as https

When deploying a Go application with the Gin framework, securing it with HTTPS is crucial to ensure encrypted communication between clients and the server. In this post, we'll walk through setting up an HTTPS server using Gin Gonic with a self-signed SSL certificate.

#### Generating self-signed certificate

To serve requests over HTTPS, we need an SSL certificate. For local development or internal use, we can generate a self-signed certificate using OpenSSL:

```bash
openssl req -x509 -newkey rsa:4096 -sha256 -days 365 \
  -nodes -keyout server.key -out server.crt -subj "/CN=example.com" \
  -addext "subjectAltName=IP:<your IP or Server IP>>"
```

This command generates:

    - private key (server.key)
    - self-signed certificate (server.crt)
    - validity period of 1 year

If you're deploying to production, consider obtaining a certificate from a trusted Certificate Authority (CA) like [Let's Encrypt instead](https://letsencrypt.org/).

#### implementation

```golang
package main

import (
	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	// Run the HTTPS server on port 81
	r.RunTLS("0.0.0.0:81", "server.crt", "server.key")
}
```

#### Running the server

Start the server with:

```bash
go run main.go
```

Now, you can access your API securely via https://localhost:81. If using a self-signed certificate, your browser may warn about security issues, but you can bypass this for testing.
