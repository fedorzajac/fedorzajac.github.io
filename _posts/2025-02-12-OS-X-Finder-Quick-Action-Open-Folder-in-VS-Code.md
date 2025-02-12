---
layout: post
title:  "OS X Finder Quick Action Open Folder in VS Code"
date:   2025-02-12 21:25:49 +0100
categories:
---

# Create a Finder Quick Action to Open Folders in VS Code on macOS

You can create a Finder Quick Action to open a selected folder in VS Code on macOS using Automator. Here's how:

## Steps to Create the Quick Action:

1. **Open Automator**
   - Press `Cmd + Space`, type **Automator**, and open it.

2. **Create a New Quick Action**
   - Click **New Document** → Select **Quick Action** → Click **Choose**.

3. **Configure the Quick Action**
   - At the top, set **"Workflow receives current"** to **"files or folders"**.
   - Set **"in"** to **"Finder"**.

4. **Add a "Run Shell Script" Action**
   - In the left search bar, type **"Run Shell Script"** and double-click it to add it to the workflow.
   - In the **Shell** dropdown, select **"/bin/zsh"** (or `/bin/bash` if preferred).
   - Set **"Pass input"** to **"as arguments"**.

5. **Enter the Shell Script**
   ```zsh
   for f in "$@"
   do
       open -a "Visual Studio Code" "$f"
   done

6. **Save the Quick Action**

    Press `Cmd + S`, name it **"Open in VS Code"**, and click Save.

7. **Using the Quick Action in Finder**

    Right-click a folder in Finder.
    Select Quick Actions → Open in VS Code.

