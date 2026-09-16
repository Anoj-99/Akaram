-- Rekonstruiert aus Git-Historie von supabase/schema.sql am 16.09.2026.
-- Diese Migration wurde NIE gegen die Produktions-DB per Migrations-Mechanismus
-- ausgefuehrt -- sie lag als Abschnitt in der monolithischen schema.sql und wurde
-- laut Projekt-Notiz "einmalig im SQL-Editor" angewendet. Zeitstempel im Dateinamen
-- entspricht dem Datum des zugehoerigen Git-Commits, nicht einer echten Migrations-
-- Anwendung. UNGEPRUEFT gegen den tatsaechlichen Live-Stand (Projekt aktuell INACTIVE,
-- kein DB-Zugriff moeglich) -- siehe Hinweis in meta-akaram.md.


-- ---------------------------------------------------------------------------
-- Lernpfad: Level & Boss-Tests (Phase 1 der neuen Struktur).
-- Falls du schema.sql schon einmal ausgeführt hast, reicht es, nur diesen
-- Abschnitt neu im SQL-Editor auszuführen.
-- Hinweis: Die Tabellen stufen_checkpoint_konfig und
-- stufen_checkpoint_ergebnisse werden von der App nicht mehr verwendet
-- (der Boss-Test mit Fehler-Wiederholung ersetzt die Toleranz-Checkpoints);
-- sie können bei Gelegenheit gelöscht werden.
-- ---------------------------------------------------------------------------

create table level_fortschritt (
  username text not null references accounts(username) on delete cascade,
  level_id integer not null,
  bestanden_am timestamptz not null default now(),
  fragen_gesamt integer not null default 0,
  erste_runde_fehler integer not null default 0,
  primary key (username, level_id)
);

alter table level_fortschritt enable row level security;
create policy "anon alles" on level_fortschritt for all to anon using (true) with check (true);
