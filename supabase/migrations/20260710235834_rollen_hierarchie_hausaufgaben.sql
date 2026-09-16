-- Rekonstruiert aus Git-Historie von supabase/schema.sql am 16.09.2026.
-- Diese Migration wurde NIE gegen die Produktions-DB per Migrations-Mechanismus
-- ausgefuehrt -- sie lag als Abschnitt in der monolithischen schema.sql und wurde
-- laut Projekt-Notiz "einmalig im SQL-Editor" angewendet. Zeitstempel im Dateinamen
-- entspricht dem Datum des zugehoerigen Git-Commits, nicht einer echten Migrations-
-- Anwendung. UNGEPRUEFT gegen den tatsaechlichen Live-Stand (Projekt aktuell INACTIVE,
-- kein DB-Zugriff moeglich) -- siehe Hinweis in meta-akaram.md.


-- ---------------------------------------------------------------------------
-- Rollen-Hierarchie & Hausaufgaben-Editor (Phase 4 der neuen Struktur).
-- Falls du schema.sql schon einmal ausgeführt hast, reicht es, nur diesen
-- Abschnitt neu im SQL-Editor auszuführen.
-- Rollen vergeben: update accounts set rolle = 'admin' where username = 'NAME';
-- ---------------------------------------------------------------------------

alter table accounts drop constraint if exists accounts_rolle_check;
alter table accounts add constraint accounts_rolle_check
  check (rolle in ('admin', 'schulleiter', 'lehrer', 'schueler'));
alter table accounts add column if not exists schule_id bigint;
alter table accounts add column if not exists lehrer_username text;
alter table accounts add column if not exists lehrer_code text;
alter table accounts add column if not exists email text;
create index if not exists accounts_lehrer_code_idx on accounts (lehrer_code);

create table if not exists schulen (
  id bigint generated always as identity primary key,
  name text not null,
  schul_code text not null unique,
  erstellt_am timestamptz not null default now()
);
alter table schulen enable row level security;
drop policy if exists "anon alles" on schulen;
create policy "anon alles" on schulen for all to anon using (true) with check (true);

-- Hausaufgaben-Pakete: Pool-Bausteine, Thema und Deadline. Die alten
-- Spalten gruppe_id/soll_anzahl bleiben für Bestandsdaten erhalten.
alter table hausaufgaben add column if not exists thema text;
alter table hausaufgaben add column if not exists deadline timestamptz;
alter table hausaufgaben add column if not exists aufgaben jsonb;
alter table hausaufgaben alter column gruppe_id set default '';
alter table hausaufgaben alter column soll_anzahl set default 0;
