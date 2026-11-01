
const field = document.getElementById("code");
const status = document.getElementById("status");
const button = document.getElementById("copy");

async function loadCode() {
  const data = await chrome.storage.session.get([
    "oauthCode",
    "capturedAt"
  ]);

  if (!data.oauthCode) {
    status.textContent = "En attente d'authentification...";
    return;
  }

  // Évite de proposer un ancien code OAuth.
  if (Date.now() - data.capturedAt > 120000) {
    await chrome.storage.session.remove([
      "oauthCode",
      "capturedAt"
    ]);
    await chrome.action.setBadgeText({ text: "" });
    status.textContent = "Code expiré. Recommencez.";
    return;
  }

  field.value = data.oauthCode;
  status.textContent = "Code OAuth récupéré !";
}

button.addEventListener("click", async () => {
  if (!field.value) return;

  await navigator.clipboard.writeText(field.value);
  status.textContent = "Code copié !";
});

loadCode();
