---
layout: post
title:  "🔑 generating keys for github"
date:   2025-04-15 14:00:37 +0100
categories:
---

### Generating Keys for Github

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

```bash
cat ~/.ssh/id_ed25519.pub
```

### Add your key to GitHub

 - Go to `GitHub → Settings > SSH and GPG keys`
 - Click `New SSH key` (Green Button)
 - Paste your public key
 - Give it a title like "whatever"
