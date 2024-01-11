---
layout: post
title:  "🪔 Python 3.11 and torch on fedora 39"
date:   2024-01-09 15:07:01 +0100
categories: fedora linux torch python
---

# Install Python

Instal specific python on fedora. Fedora 39 is shipped with python 3.12, but you need 3.11 for pytorch. so...

```bash
$ python --version
	Python 3.12.0

$ sudo yum install python3.11-3.11.7-1.fc39

$ python3.11 --version
	Python 3.11.7
```

Great! Now, lets try to install fooocus requirements.

```bash
$ python3.11 -m pip install -r requirements.txt
	/usr/bin/python3.11: No module named pip
```

Not working. Maybe this will

```bash
$ python3.11 -m ensurepip
	…
	Successfully installed pip-23.2.1 setuptools-67.7.2
```

Lets's do it again but within virtual environment

```bash
$ python3.11 -m venv fooocus
$ source fooocus/bin/activate

(fooocus) $ ls
	…

(fooocus) $ python3.11 -m pip install -r requirements_versions.txt
	…
	[notice] A new release of pip is available: 23.2.1 -> 23.3.2
	[notice] To update, run: pip install --upgrade pip

(fooocus) $ python3.11 entry_with_update.py --preset anime
	Already up-to-date
	Update succeeded.
	[System ARGV] ['entry_with_update.py', '--preset', 'anime']
	Loaded preset: /home/fedorko/Documents/projects/Fooocus/presets/anime.json
	…
```

Done