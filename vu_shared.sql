-- 벨류업 데이터 온라인 공유 저장 (woozoo-apps 프로젝트에서 실행)
create table if not exists public.vu_shared (
  id         text primary key,
  data       jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.vu_shared enable row level security;
drop policy if exists vu_shared_all on public.vu_shared;
create policy vu_shared_all on public.vu_shared
  for all to anon, authenticated
  using (true) with check (true);
notify pgrst, 'reload schema';
grant select, insert, update, delete on public.vu_shared to anon, authenticated;
notify pgrst, ' reload schema';
