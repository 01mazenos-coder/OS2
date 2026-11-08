-- Run this entire file in Supabase Dashboard > SQL Editor.
create extension if not exists pgcrypto;
create table if not exists public.site_settings (
 id integer primary key default 1 check (id = 1),
 restaurant_name text not null default 'b''ASK''a Tat',
 logo_url text,
 contact_text text default 'KEBAP VE LAHMACUN SALONU',
 updated_at timestamptz not null default now()
);
create table if not exists public.offers (
 id text primary key,
 name text not null,
 price numeric(10,2) not null default 0,
 description text,
 image_url text,
 sort_order integer not null default 0,
 active boolean not null default true,
 updated_at timestamptz not null default now()
);
create table if not exists public.menu_items (
 id uuid primary key default gen_random_uuid(),
 category text not null,
 name text not null,
 price numeric(10,2) not null default 0,
 sort_order integer not null default 0,
 active boolean not null default true,
 updated_at timestamptz not null default now()
);
insert into public.site_settings(id) values(1) on conflict(id) do nothing;
insert into public.offers(id,name,price,description,sort_order) values
 ('family','Aile Menüsü',1500,'Ailenizle paylaşabileceğiniz özel menü',1),
 ('love','Aşk Tabağı',600,'Size özel lezzet tabağı',2)
on conflict(id) do nothing;
insert into public.menu_items(category,name,price,sort_order) values
('Kebaplar','Adana Kebap Servis',350,1),('Kebaplar','Light Kebap Servis',350,2),('Kebaplar','Kuşbaşı Servis',370,3),('Kebaplar','Karışık Izgara Servis',600,4),('Kebaplar','Kanat Servis',330,5),('Kebaplar','Kemiksiz Tavuk Servis',330,6),('Kebaplar','Kemikli Tavuk Servis',330,7),
('Dürümler','Adana Kebap Dürüm',250,8),('Dürümler','Tavuk Kıyma Dürüm',160,9),('Dürümler','Kuşbaşı Dürüm',250,10),('Dürümler','Tavuk Kemiksiz Dürüm',250,11),
('Lahmacun & Pide','Lahmacun',300,12),('Lahmacun & Pide','Etli Pide',330,13),('Lahmacun & Pide','Etli Kaşarlı Pide',350,14),('Lahmacun & Pide','Kıymalı Pide',330,15),('Lahmacun & Pide','Kıymalı Kaşarlı Pide',350,16),('Lahmacun & Pide','Kaşarlı Pide',280,17),('Lahmacun & Pide','Tavuklu Pide',300,18),('Lahmacun & Pide','Tavuk Kaşarlı Pide',330,19);
-- Public can read active menu content; only authenticated users can write.
alter table public.site_settings enable row level security;
alter table public.offers enable row level security;
alter table public.menu_items enable row level security;
drop policy if exists "Public read settings" on public.site_settings;
create policy "Public read settings" on public.site_settings for select using (true);
drop policy if exists "Authenticated manage settings" on public.site_settings;
create policy "Authenticated manage settings" on public.site_settings for all to authenticated using (true) with check (true);
drop policy if exists "Public read offers" on public.offers;
create policy "Public read offers" on public.offers for select using (true);
drop policy if exists "Authenticated manage offers" on public.offers;
create policy "Authenticated manage offers" on public.offers for all to authenticated using (true) with check (true);
drop policy if exists "Public read menu" on public.menu_items;
create policy "Public read menu" on public.menu_items for select using (true);
drop policy if exists "Authenticated manage menu" on public.menu_items;
create policy "Authenticated manage menu" on public.menu_items for all to authenticated using (true) with check (true);
insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types)
values('menu-media','menu-media',true,5242880,array['image/jpeg','image/png','image/webp'])
on conflict(id) do update set public=true,file_size_limit=5242880,allowed_mime_types=array['image/jpeg','image/png','image/webp'];
drop policy if exists "Public view menu media" on storage.objects;
create policy "Public view menu media" on storage.objects for select using (bucket_id='menu-media');
drop policy if exists "Authenticated upload menu media" on storage.objects;
create policy "Authenticated upload menu media" on storage.objects for insert to authenticated with check (bucket_id='menu-media');
drop policy if exists "Authenticated update menu media" on storage.objects;
create policy "Authenticated update menu media" on storage.objects for update to authenticated using (bucket_id='menu-media') with check (bucket_id='menu-media');
drop policy if exists "Authenticated delete menu media" on storage.objects;
create policy "Authenticated delete menu media" on storage.objects for delete to authenticated using (bucket_id='menu-media');
