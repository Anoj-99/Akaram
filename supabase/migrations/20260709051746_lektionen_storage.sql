-- Rekonstruiert aus Git-Historie von supabase/schema.sql am 16.09.2026.
-- Diese Migration wurde NIE gegen die Produktions-DB per Migrations-Mechanismus
-- ausgefuehrt -- sie lag als Abschnitt in der monolithischen schema.sql und wurde
-- laut Projekt-Notiz "einmalig im SQL-Editor" angewendet. Zeitstempel im Dateinamen
-- entspricht dem Datum des zugehoerigen Git-Commits, nicht einer echten Migrations-
-- Anwendung. UNGEPRUEFT gegen den tatsaechlichen Live-Stand (Projekt aktuell INACTIVE,
-- kein DB-Zugriff moeglich) -- siehe Hinweis in meta-akaram.md.


-- ---------------------------------------------------------------------------
-- Lektionen (geführtes Anfänger-Curriculum) - nachträglich hinzugefügt.
-- Falls du schema.sql schon einmal ausgeführt hast, reicht es, nur diesen
-- Abschnitt neu im SQL-Editor auszuführen.
-- ---------------------------------------------------------------------------

create table lektion_fortschritt (
  username text not null references accounts(username) on delete cascade,
  lektion_id text not null,
  teil integer not null,
  abgeschlossen_am timestamptz not null default now(),
  primary key (username, lektion_id, teil)
);

create table lektion_inhalt_ueberschreibung (
  zeichen text primary key,
  beispielwort_tamil text,
  beispielwort_deutsch text,
  bild_url text,
  aktualisiert_am timestamptz not null default now()
);

create table stufen_checkpoint_konfig (
  stufe_id text primary key,
  toleranz_prozent integer not null default 80,
  anzahl_vorherige_buchstaben integer not null default 3
);

create table stufen_checkpoint_ergebnisse (
  id bigint generated always as identity primary key,
  username text not null references accounts(username) on delete cascade,
  stufe_id text not null,
  bestanden boolean not null,
  richtig integer not null,
  gesamt integer not null,
  zeitpunkt timestamptz not null default now()
);
create index stufen_checkpoint_ergebnisse_username_idx
  on stufen_checkpoint_ergebnisse (username, zeitpunkt desc);

alter table lektion_fortschritt enable row level security;
alter table lektion_inhalt_ueberschreibung enable row level security;
alter table stufen_checkpoint_konfig enable row level security;
alter table stufen_checkpoint_ergebnisse enable row level security;

create policy "anon alles" on lektion_fortschritt for all to anon using (true) with check (true);
create policy "anon alles" on lektion_inhalt_ueberschreibung for all to anon using (true) with check (true);
create policy "anon alles" on stufen_checkpoint_konfig for all to anon using (true) with check (true);
create policy "anon alles" on stufen_checkpoint_ergebnisse for all to anon using (true) with check (true);

-- Storage-Bucket für vom Lehrer hochgeladene Bilder (ersetzt die
-- eingebauten Platzhalter-Illustrationen einzelner Buchstaben).
insert into storage.buckets (id, name, public)
values ('lektion-bilder', 'lektion-bilder', true)
on conflict (id) do nothing;

create policy "anon liest lektion-bilder" on storage.objects
  for select to anon using (bucket_id = 'lektion-bilder');
create policy "anon laedt lektion-bilder hoch" on storage.objects
  for insert to anon with check (bucket_id = 'lektion-bilder');
create policy "anon aktualisiert lektion-bilder" on storage.objects
  for update to anon using (bucket_id = 'lektion-bilder');
