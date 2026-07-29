# dj-scaffold

> **New name!** Formerly `django-setup-automation` — renamed to **dj-scaffold** (short for "Django Scaffold").

Automated Django project scaffolding using bash scripts. Create a complete Django project with a custom app, settings, and frontend in minutes.

> **Note:** This repository is a **template/learning tool**.  
> It works best when you run it **outside** any existing project directory — it will create a new Django project in the current folder.

---

## Installation & Usage

### Option 1 — Install as a Python package (recommended)

```bash
pip install dj-scaffold
dj-scaffold
```

This runs the interactive scaffolding wizard in your terminal.

### Option 2 — Run directly from the clone

#### Windows Users
[Running Bash Script Files](https://softwarekeep.com/help-center/how-to-run-shell-script-file-in-windows)

#### Linux & macOS Users

1. `git clone https://github.com/Morvin-Ian/django-setup-automation/`
2. `cd django-setup-automation`
3. `chmod +x install.sh`
4. `./install.sh`

The script will automatically create and use a Python virtual environment (`venv/`) for you.

### Option 3 — Install in editable mode (for development)

```bash
git clone https://github.com/Morvin-Ian/django-setup-automation/
cd django-setup-automation
pip install -e .
dj-scaffold
```

---

## What it does

| Step | Script | Action |
|------|--------|--------|
| 1 | `01_intro.sh` | Prints a welcome banner |
| 2 | `02_django-installation.sh` | Checks Python/pip, installs Django in a venv |
| 3 | `03_project-setup.sh` | Prompts for project name & app name, runs `django-admin startproject` & `startapp` |
| 4 | `04_settings.sh` | Registers the app, updates templates/static/media settings |
| 5 | `05_frontend.sh` | Creates HTML template, static dirs, and offers cleanup |

## Successful Setup screenshot

![Screenshot from 2023-07-12 16-55-27](https://github.com/Morvin-Ian/django-setup-automation/assets/78966128/25825a36-59bd-4e98-901e-dcc5e0e56c94)
