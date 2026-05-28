create table if not exists public.marathon_logs (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.marathon_logs enable row level security;

drop policy if exists "Users can read their own marathon log" on public.marathon_logs;
create policy "Users can read their own marathon log"
on public.marathon_logs
for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists "Users can insert their own marathon log" on public.marathon_logs;
create policy "Users can insert their own marathon log"
on public.marathon_logs
for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists "Users can update their own marathon log" on public.marathon_logs;
create policy "Users can update their own marathon log"
on public.marathon_logs
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

create or replace function public.set_marathon_logs_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_marathon_logs_updated_at on public.marathon_logs;
create trigger set_marathon_logs_updated_at
before update on public.marathon_logs
for each row
execute function public.set_marathon_logs_updated_at();
