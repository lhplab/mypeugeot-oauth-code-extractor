# MyPeugeot OAuth Code Extractor

**Version 1.1.0 — Multi-platform / Multiplateforme**

[Français](#français) · [English](#english)

## Français

Extension de navigateur permettant de récupérer **localement** le code d'autorisation OAuth retourné lors de l'authentification MyPeugeot, notamment pour faciliter la configuration de l'intégration Stellantis Vehicles dans Home Assistant.

### Navigateurs testés (v1.1.0)

| Navigateur | Système | Résultat |
| --- | --- | --- |
| Microsoft Edge | Windows 11 | Installation et capture OAuth validées |
| Microsoft Edge Canary | Android | Installation CRX et capture OAuth validées |
| Mozilla Firefox | Android | Installation XPI signé et capture OAuth validées |

Le fonctionnement sur d'autres navigateurs Chromium ou Firefox n'a pas été vérifié.

### Télécharger la version 1.1.0

Consultez les [releases GitHub](https://github.com/lhplab/mypeugeot-oauth-code-extractor/releases) et récupérez le fichier correspondant :

- **Edge / Chromium :** `mypeugeot-oauth-code-extractor-chromium-v1.1.0.crx`
- **Firefox Android :** `mypeugeot-oauth-code-extractor-firefox-v1.1.0.xpi` (**signé par Mozilla**)

Ces fichiers sont destinés à être joints à la release `v1.1.0`. La disponibilité effective dépend de la publication de cette release.

### Installation — Edge Windows 11

Pour une installation locale fiable, utilisez les sources :

1. Téléchargez les sources du dépôt.
2. À la racine du projet, exécutez `build.bat` (Windows 11, sans installation de Python).
3. Ouvrez `edge://extensions`, activez le **Mode développeur**.
4. Cliquez sur **Charger l'extension décompressée** et sélectionnez le dossier `dist/chromium`.

Le fichier CRX peut être soumis à des restrictions d'installation sur Edge Windows lorsqu'il n'est pas distribué par une boutique d'extensions. L'installation depuis le dossier décompressé est la méthode testée ici.

### Installation — Edge Canary Android

1. Installez Microsoft Edge Canary sur Android.
2. Activez les options développeur d'Edge Canary, si elles ne sont pas déjà disponibles.
3. Ouvrez **Developer options → Extension install by crx**.
4. Sélectionnez `mypeugeot-oauth-code-extractor-chromium-v1.1.0.crx` et confirmez l'installation.
5. Lancez l'authentification MyPeugeot, puis ouvrez l'extension pour récupérer le code OAuth.

**Attention :** l'installation des extensions CRX sur Edge Canary Android est une fonctionnalité expérimentale qui peut évoluer ou disparaître.

### Installation — Firefox Android

1. Téléchargez `mypeugeot-oauth-code-extractor-firefox-v1.1.0.xpi` depuis la release GitHub.
2. Dans Firefox Android, ouvrez **Paramètres → À propos de Firefox** et activez le menu de débogage en appuyant cinq fois sur le logo Firefox, si nécessaire.
3. Revenez dans les paramètres et choisissez **Installer une extension depuis un fichier**.
4. Sélectionnez le XPI signé et confirmez l'installation.
5. Lancez l'authentification MyPeugeot, puis ouvrez l'extension pour récupérer le code OAuth.

### Utilisation et dépannage

L'extension capture le code d'autorisation lors de la redirection OAuth MyPeugeot et permet de le copier depuis son interface. Le code est temporaire : récupérez-le rapidement et ne le communiquez à personne.

Si l'authentification Peugeot boucle, revient à la page de connexion ou reste bloquée sur un chargement, essayez de supprimer **uniquement les cookies et données des sites Peugeot** dans le navigateur concerné, puis reconnectez-vous. Sur Android, vérifiez aussi le navigateur par défaut si la redirection ne se comporte pas comme prévu. Ces pistes ont aidé lors des tests, sans constituer une solution garantie.

### Arborescence des sources

```text
common/
  background.js
  popup.html
  popup.js
chromium/
  manifest.json
firefox/
  manifest.json
scripts/
  build.ps1
  build.py
build.bat
README.md
.gitignore
```

Les trois fichiers dans `common/` sont partagés. Chaque navigateur dispose de son propre `manifest.json`.

### Construction des extensions

Sous **Windows 11**, double-cliquez sur `build.bat` ; il lance `scripts/build.ps1` avec PowerShell. Aucun Python n'est nécessaire.

Alternative si **Python 3** est installé :

```powershell
python scripts/build.py
```

Les scripts produisent `dist/chromium/`, `dist/firefox/` et `dist/mypeugeot-oauth-code-extractor-firefox-v1.1.0-unsigned.zip`.

**Attention :** `dist/` est recréé à chaque construction. Ne conservez aucun fichier personnel dans ce dossier.

Pour produire le CRX, ouvrez `edge://extensions` sur Windows et utilisez **Compresser l'extension** avec `dist/chromium` comme dossier racine. Si vous mettez à jour un paquet existant, réutilisez **la même clé privée `.pem`** pour conserver son identifiant. Ne publiez jamais cette clé. Le CRX peut ensuite être renommé en `mypeugeot-oauth-code-extractor-chromium-v1.1.0.crx`.

Pour Firefox, soumettez le ZIP **non signé** dans le [Pôle développeurs Mozilla](https://addons.mozilla.org/developers/) comme nouvelle version du module existant. Après signature, récupérez le XPI signé et renommez-le en `mypeugeot-oauth-code-extractor-firefox-v1.1.0.xpi`. **Ne distribuez pas le ZIP non signé comme une extension installable.**

### Confidentialité et sécurité

Le code OAuth est récupéré localement et conservé temporairement dans le stockage de session du navigateur. Il peut être copié manuellement dans le presse-papiers. N'exposez jamais vos identifiants, codes OAuth ou clés privées `.pem` dans un dépôt public, une capture d'écran ou un ticket GitHub.

### Crédits

Le développement, le débogage et la documentation de cette extension ont été réalisés avec l’assistance de ChatGPT (OpenAI). Les modifications ont été intégrées et les fonctionnalités testées par le mainteneur du projet.

Projet communautaire indépendant, sans affiliation à Peugeot, Stellantis ni OpenAI.

---

## English

Browser extension that **locally captures** the OAuth authorization code returned during MyPeugeot authentication, including for use when configuring the Stellantis Vehicles integration in Home Assistant.

### Tested browsers (v1.1.0)

| Browser | Platform | Result |
| --- | --- | --- |
| Microsoft Edge | Windows 11 | Installation and OAuth capture verified |
| Microsoft Edge Canary | Android | CRX installation and OAuth capture verified |
| Mozilla Firefox | Android | Signed XPI installation and OAuth capture verified |

Other Chromium-based browsers and Firefox platforms have not been tested.

### Downloads

See the [GitHub releases](https://github.com/lhplab/mypeugeot-oauth-code-extractor/releases) for:

- **Edge / Chromium:** `mypeugeot-oauth-code-extractor-chromium-v1.1.0.crx`
- **Firefox Android:** `mypeugeot-oauth-code-extractor-firefox-v1.1.0.xpi` (**Mozilla-signed**)

These assets are intended for the `v1.1.0` release and will be available once that release is published.

### Install — Edge on Windows 11

1. Download the repository source files.
2. Run `build.bat` at the project root (no Python installation required on Windows 11).
3. Open `edge://extensions` and enable **Developer mode**.
4. Choose **Load unpacked** and select `dist/chromium`.

Direct installation of a CRX outside an approved extension store may be restricted on Edge for Windows. Loading the unpacked folder is the tested method.

### Install — Edge Canary on Android

1. Install Microsoft Edge Canary for Android.
2. Enable its developer options if needed.
3. Open **Developer options → Extension install by crx**.
4. Select `mypeugeot-oauth-code-extractor-chromium-v1.1.0.crx` and confirm.
5. Authenticate with MyPeugeot and open the extension to copy the OAuth code.

CRX installation on Edge Canary for Android is **experimental** and may change.

### Install — Firefox on Android

1. Download the signed `mypeugeot-oauth-code-extractor-firefox-v1.1.0.xpi`.
2. In Firefox Android, go to **Settings → About Firefox** and, if needed, tap the Firefox logo five times to enable the debug menu.
3. Return to Settings and select **Install extension from file**.
4. Select the signed XPI and confirm installation.
5. Authenticate with MyPeugeot and open the extension to copy the OAuth code.

### Troubleshooting

If MyPeugeot authentication loops, returns to the login page or hangs, try clearing cookies and site data **for Peugeot sites only**, then sign in again. On Android, also check the default browser if redirects behave unexpectedly. These steps helped during testing but are not guaranteed fixes.

### Source layout and builds

- `common/`: shared JavaScript and popup interface.
- `chromium/manifest.json`: Chromium / Edge manifest.
- `firefox/manifest.json`: Firefox manifest and Mozilla-specific settings.
- `build.bat`: Windows build launcher, calling `scripts/build.ps1`.
- `scripts/build.py`: alternative build using Python 3.
- `dist/`: generated output, excluded from version control.

On Windows, double-click `build.bat`. Alternatively, run:

```powershell
python scripts/build.py
```

The build generates `dist/chromium/`, `dist/firefox/`, and `dist/mypeugeot-oauth-code-extractor-firefox-v1.1.0-unsigned.zip`. **The `dist/` directory is replaced on each build.**

For Chromium, use **Pack extension** in `edge://extensions` with `dist/chromium` as the extension root. Reuse the original private `.pem` key for updates so the extension ID remains stable; never publish that key. Rename the resulting CRX to `mypeugeot-oauth-code-extractor-chromium-v1.1.0.crx`.

For Firefox, submit the unsigned ZIP as a new version of the **existing add-on** in the [Mozilla Add-on Developer Hub](https://addons.mozilla.org/developers/). Download the signed XPI and rename it to `mypeugeot-oauth-code-extractor-firefox-v1.1.0.xpi`. Do not distribute the unsigned ZIP as an installable extension.

### Privacy and security

The OAuth authorization code is captured locally and temporarily stored in browser session storage. It can be copied manually to the clipboard. Never disclose credentials, OAuth codes, or private `.pem` signing keys in public repositories, screenshots or issue reports.

### Credits

Development, debugging and documentation of this extension were carried out with assistance from ChatGPT (OpenAI). Changes were integrated and functionality tested by the project maintainer.

This project is not affiliated with or endorsed by Peugeot, Stellantis or OpenAI.
