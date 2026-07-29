"""CLI entry point for dj-scaffold.

Orchestrates the Django project scaffolding by running the bundled bash
scripts in sequence, mirroring the original install.sh flow.
"""

import os
import subprocess
import sys
import tempfile
from pathlib import Path


def _bundle_dir() -> Path:
    """Return the directory where bundled scripts live inside the package."""
    return Path(__file__).resolve().parent / "scripts"


def _find_scripts(bundle: Path) -> list[Path]:
    """Return the scaffolding scripts in execution order."""
    ordered = [
        "01_intro.sh",
        "02_django-installation.sh",
        "03_project-setup.sh",
        "04_settings.sh",
        "05_frontend.sh",
    ]
    scripts = [bundle / name for name in ordered]
    for s in scripts:
        if not s.is_file():
            print(f"Error: required script not found: {s}", file=sys.stderr)
            sys.exit(1)
    return scripts


def main() -> None:
    # If the scripts are bundled alongside the package, run them in-place.
    bundle = _bundle_dir()
    if bundle.is_dir():
        scripts = _find_scripts(bundle)
    else:
        # Fallback: running from the repository root during development.
        repo_root = Path(__file__).resolve().parent.parent.parent
        scripts = _find_scripts(repo_root)

    print("dj-scaffold — Django project scaffolding")
    print("=" * 50)

    for script in scripts:
        print(f"\n--- Running {script.name} ---")
        result = subprocess.run(
            ["bash", str(script)],
            cwd=os.getcwd(),
        )
        if result.returncode != 0:
            print(f"Script {script.name} failed (exit code {result.returncode}).", file=sys.stderr)
            sys.exit(result.returncode)

    print("\nDone. Your Django project is ready!")


if __name__ == "__main__":
    main()
