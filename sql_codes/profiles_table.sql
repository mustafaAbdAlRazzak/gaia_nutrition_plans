create table public.profiles (
  id uuid not null,
  first_name text null,
  second_name text null,
  birthday date null,
  weight double precision null,
  height double precision null,
  gender boolean null,
  email text null,
  created_at timestamp with time zone null default now(),
  updated_at timestamp with time zone null default now(),
  subscription_expiry timestamp with time zone null,
  constraint profiles_pkey primary key (id),
  constraint profiles_id_fkey foreign KEY (id) references auth.users (id) on delete CASCADE
) TABLESPACE pg_default;
