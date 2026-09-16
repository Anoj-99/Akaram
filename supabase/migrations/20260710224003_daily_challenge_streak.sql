-- Rekonstruiert aus Git-Historie von supabase/schema.sql am 16.09.2026.
-- Diese Migration wurde NIE gegen die Produktions-DB per Migrations-Mechanismus
-- ausgefuehrt -- sie lag als Abschnitt in der monolithischen schema.sql und wurde
-- laut Projekt-Notiz "einmalig im SQL-Editor" angewendet. Zeitstempel im Dateinamen
-- entspricht dem Datum des zugehoerigen Git-Commits, nicht einer echten Migrations-
-- Anwendung. UNGEPRUEFT gegen den tatsaechlichen Live-Stand (Projekt aktuell INACTIVE,
-- kein DB-Zugriff moeglich) -- siehe Hinweis in meta-akaram.md.


-- ---------------------------------------------------------------------------
-- Daily Challenge & Streak-Freikauf (Phase 3 der neuen Struktur).
-- Falls du schema.sql schon einmal ausgeführt hast, reicht es, nur diesen
-- Abschnitt neu im SQL-Editor auszuführen.
-- ---------------------------------------------------------------------------

alter table punkte add column if not exists challenge_punkte integer not null default 0;
alter table punkte add column if not exists letzte_challenge date;
alter table punkte add column if not exists gerissener_streak integer not null default 0;
