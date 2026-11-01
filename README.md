# MyPeugeot OAuth Code Extractor

A lightweight Microsoft Edge browser extension that captures the OAuth authorization code returned during MyPeugeot authentication.

Developed with assistance from OpenAI's ChatGPT.

## Features

- Detects the MyPeugeot OAuth redirect to `mymap://oauth2redirect`.
- Extracts the OAuth authorization code automatically.
- Displays a green **OK** badge when a code is captured.
- Allows the code to be viewed and copied directly from the extension popup.
- Stores the code locally in browser session storage.
- Checks the code's age when the popup opens and removes it if older than two minutes.
- Does not intentionally send the captured code to any external server.

## Installation — Microsoft Edge

1. Download the repository as a ZIP file and extract it to a folder.
2. Open Microsoft Edge.
3. Navigate to `edge://extensions`.
4. Enable **Developer mode**.
5. Click **Load unpacked**.
6. Select the folder containing `manifest.json`.
7. Pin the extension to the Edge toolbar for easier access.

## Usage

1. Open the MyPeugeot authentication page used by your Stellantis integration.
2. Complete the authentication process normally.
3. When MyPeugeot redirects to `mymap://oauth2redirect?code=...`, the extension captures the authorization code.
4. Click the extension icon in Edge.
5. Click **Copier le code** to copy the authorization code.
6. Paste it into the application requesting the OAuth code.

The authorization code is temporary and should be used promptly.

## Files

| File | Description |
|---|---|
| `manifest.json` | Manifest V3 configuration and permissions |
| `background.js` | OAuth redirect detection and code capture |
| `popup.html` | Extension popup interface |
| `popup.js` | Code display, age check and clipboard copy |

## Privacy and security

The extension uses the `webRequest` and `storage` browser permissions and requests access to `https://idpcvs.peugeot.com/*`.

OAuth authorization codes are sensitive credentials. Never share a captured code, publish it in screenshots or commit it to a repository.

The extension stores captured codes in `chrome.storage.session`. The popup removes codes older than two minutes when opened; this is not an automatic expiration timer.

The clipboard may retain a copied code until it is overwritten.

## Compatibility

Designed and tested for Microsoft Edge using Chromium Manifest V3.

Compatibility with other Chromium-based browsers may be possible but has not been verified.

This is an independent community project, not an official Peugeot or Stellantis extension.

## Credits

Developed and tested by [lhplab](https://github.com/lhplab), with development and debugging assistance from OpenAI's ChatGPT.

This project is not affiliated with or endorsed by Peugeot, Stellantis or OpenAI.
