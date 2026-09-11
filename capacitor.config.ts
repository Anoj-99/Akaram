import type { CapacitorConfig } from "@capacitor/cli";

// Architektur-Entscheidung (siehe src/lib/oeffentlicheUrl.ts für den Hintergrund):
// Akaram ist eine rein clientseitige Vite/React-SPA ohne serverseitiges
// Rendering, ohne Cookies/Server-Sessions - die Anmeldung läuft komplett
// über den Supabase-JS-Client direkt aus dem WebView. Deshalb wird die
// gebaute App LOKAL gebündelt (webDir), statt eine Live-Domain per
// server.url nachzuladen. Ein Domain-Platzhalter wird trotzdem gebraucht,
// aber nur für den QR-Code-/Freischalt-Link im Lehrer-/Admin-Bereich
// (siehe src/lib/oeffentlicheUrl.ts) - nicht hier in der Capacitor-Config.
const config: CapacitorConfig = {
  appId: "com.akaram.app",
  appName: "Akaram",
  webDir: "dist",
};

export default config;
