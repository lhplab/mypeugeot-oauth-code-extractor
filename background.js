
chrome.webRequest.onBeforeRedirect.addListener(
  async (details) => {
    if (details.type !== "main_frame") return;

    try {
      const redirect = new URL(details.redirectUrl);

      if (
        redirect.protocol !== "mymap:" ||
        redirect.hostname !== "oauth2redirect"
      ) {
        return;
      }

      const code = redirect.searchParams.get("code");

      if (!code) return;

      await chrome.storage.session.set({
        oauthCode: code,
        capturedAt: Date.now()
      });

      await chrome.action.setBadgeText({
        text: "OK"
      });

      await chrome.action.setBadgeBackgroundColor({
        color: "#008A55"
      });

    } catch (error) {
      console.error("Erreur OAuth :", error);
    }
  },
  {
    urls: ["https://idpcvs.peugeot.com/*"]
  }
);
