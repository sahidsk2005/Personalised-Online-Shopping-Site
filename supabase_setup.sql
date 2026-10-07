create table if not exists public.beauty_products (
    id text primary key,
    product jsonb not null check (jsonb_typeof(product) = 'object'),
    sort_order integer not null default 0
);

alter table public.beauty_products enable row level security;

grant usage on schema public to anon, authenticated;
grant select on public.beauty_products to anon, authenticated;
grant insert, update, delete on public.beauty_products to authenticated;

drop policy if exists "Anyone can read beauty products" on public.beauty_products;
create policy "Anyone can read beauty products"
    on public.beauty_products
    for select
    using (true);

drop policy if exists "Only Jasmin can insert beauty products" on public.beauty_products;
create policy "Only Jasmin can insert beauty products"
    on public.beauty_products
    for insert
    to authenticated
    with check ((auth.jwt() ->> 'email') = 'acpsahid2005@gmail.com');

drop policy if exists "Only Jasmin can update beauty products" on public.beauty_products;
create policy "Only Jasmin can update beauty products"
    on public.beauty_products
    for update
    to authenticated
    using ((auth.jwt() ->> 'email') = 'acpsahid2005@gmail.com')
    with check ((auth.jwt() ->> 'email') = 'acpsahid2005@gmail.com');

drop policy if exists "Only Jasmin can delete beauty products" on public.beauty_products;
create policy "Only Jasmin can delete beauty products"
    on public.beauty_products
    for delete
    to authenticated
    using ((auth.jwt() ->> 'email') = 'acpsahid2005@gmail.com');
