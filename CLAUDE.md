# Akaram (Tamil-lernen) – Projekt-Notizen

Deutschsprachige Lern-App für die tamilische Schrift (React + Vite +
TypeScript, Tailwind, Supabase mit localStorage-Fallback im Test-Modus).
Details zur Struktur: `docs/PLANUNG.md`, Einrichtung/Deployment: `README.md`.

## Arbeitsweise in diesem Repo

- Direkt auf `main` committen und pushen (kein PR-Workflow).
- Code, Kommentare und UI-Texte auf Deutsch.
- Vor dem Commit: `npm test` und `npm run build` müssen grün sein.

## Offene Punkte / Merkzettel

- **Domain:** `akaram.app` ist gekauft (IONOS), im Vercel-Projekt unter
  *Settings → Domains* hinzugefügt, DNS von Vercel als korrekt erkannt
  (`akaram.app` + `www.akaram.app`, Stand 16.09. beide „Generating SSL
  Certificate" – läuft automatisch durch, kein weiterer Schritt nötig).
  Code ist bereits auf `akaram.app` vorbereitet
  (`src/lib/oeffentlicheUrl.ts`, README). Sobald das Zertifikat fertig
  ist: kurz `https://akaram.app` im Browser prüfen, dann können Lehrer
  QR-Codes drucken (QR enthält die Web-Adresse).
- **Später geplant:** native App per Capacitor (App Store / Play Store);
  Haptik dann von `fehlerFeedback.ts` auf @capacitor/haptics umstellen.
- **Assets fehlen noch:** echte Illustrationen statt
  `public/lektionen/platzhalter.svg`, Audio-Aufnahmen der 247 Zeichen
  (aktuell Web Speech API), Maskottchen-Illustrationen (aktuell Emoji).
- **Supabase (16.09.2026 umgestellt):** `supabase/schema.sql` ist abgelöst.
  Schema-Änderungen jetzt als neue, datierte Datei unter
  `supabase/migrations/` anlegen (fünf bestehende Migrationen rekonstruiert
  aus der Git-Historie, byte-identisch zur alten schema.sql geprüft). Für
  eine neue Änderung: `supabase/migrations/YYYYMMDDHHMMSS_kurzname.sql`
  anlegen, committen, pushen – **nicht** mehr manuell im SQL-Editor
  ausführen. Voraussetzung für automatische Anwendung: Supabase-GitHub-
  Integration muss im Dashboard aktiviert sein (Stand 16.09. ungeprüft).
