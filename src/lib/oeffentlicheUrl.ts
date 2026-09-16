// Öffentliche Basis-URL für Links, die die App selbst erzeugt (QR-Code für
// Schüler-Registrierung, Freischalt-Text im Admin-Bereich).
//
// Im Browser ist window.location.origin korrekt (echte Vercel-/Produktions-
// domain). In der nativen iOS-App (Capacitor) lädt die App den lokal
// gebündelten dist-Ordner, dort zeigt window.location.origin auf die interne
// WebView-Adresse (z. B. capacitor://localhost) - für einen QR-Code, den ein
// Schüler mit einem beliebigen Gerät scannt, ist das nutzlos. Deshalb wird
// nativ stattdessen die echte, öffentliche Domain fest hinterlegt.
import { Capacitor } from "@capacitor/core";

const OEFFENTLICHE_DOMAIN_NATIV = "https://akaram.app";

export function oeffentlicheBasisUrl(): string {
  if (Capacitor.isNativePlatform()) return OEFFENTLICHE_DOMAIN_NATIV;
  return window.location.origin;
}
