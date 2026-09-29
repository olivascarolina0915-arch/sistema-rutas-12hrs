-- Ejecuta este script UNA SOLA VEZ en Supabase > SQL Editor.
-- Crea la tabla compartida para las rutas del Sistema de Rutas Chihuahua.

create table if not exists public.rutas (
  id text primary key,
  name text not null default 'Ruta sin nombre',
  status text not null default 'guardada',
  responsable text,
  data jsonb not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.rutas enable row level security;

grant usage on schema public to anon, authenticated;
grant select, insert, update, delete on table public.rutas to anon, authenticated;

drop policy if exists "rutas_publicas" on public.rutas;
create policy "rutas_publicas"
on public.rutas
for all
to anon, authenticated
using (true)
with check (true);

create index if not exists rutas_updated_at_idx on public.rutas(updated_at desc);
