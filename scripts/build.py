#!/usr/bin/env python3
"""Prepare unpacked Chromium/Firefox extensions and unsigned Firefox ZIP.
Run: python scripts/build.py
No third-party dependencies; no signing or private keys involved.
"""
from pathlib import Path
import json
import shutil
import zipfile

ROOT = Path(__file__).resolve().parent.parent
DIST = ROOT / "dist"
SHARED = ("background.js", "popup.html", "popup.js")


def main():
    manifests = {}
    for target in ("chromium", "firefox"):
        path = ROOT / target / "manifest.json"
        manifest = json.loads(path.read_text(encoding="utf-8"))
        manifests[target] = manifest
        if manifest.get("manifest_version") != 3:
            raise ValueError(f"{target}: expected manifest v3")
    versions = {m["version"] for m in manifests.values()}
    if len(versions) != 1:
        raise ValueError("Chromium and Firefox versions must match")
    version = versions.pop()
    if DIST.exists():
        shutil.rmtree(DIST)
    DIST.mkdir()
    for target in ("chromium", "firefox"):
        dest = DIST / target
        dest.mkdir()
        shutil.copy2(ROOT / target / "manifest.json", dest / "manifest.json")
        for filename in SHARED:
            shutil.copy2(ROOT / "common" / filename, dest / filename)
        print(f"Prepared: {dest}")
    archive = DIST / f"mypeugeot-oauth-code-extractor-firefox-v{version}-unsigned.zip"
    with zipfile.ZipFile(archive, "w", zipfile.ZIP_DEFLATED) as z:
        for filename in ("manifest.json", *SHARED):
            z.write(DIST / "firefox" / filename, arcname=filename)
    print(f"Firefox unsigned ZIP: {archive}")
    print("Chromium CRX: pack dist/chromium using Edge and your existing private key (.pem).")
    print("Firefox XPI: upload unsigned ZIP as a new version to Mozilla for signing.")


if __name__ == "__main__":
    main()
