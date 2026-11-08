# b'ASK'a Tat — Dijital Menü

Mobil uyumlu Türkçe restoran menüsü ve Supabase tabanlı yönetim paneli. Menü yemeklerinde fotoğraf kullanılmaz; görseller yalnızca logo ve kampanya kartları içindir.

## Gerekenler
- Node.js 20 veya üzeri
- Supabase hesabı/projesi
- Vercel hesabı (yayınlamak için)

## 1. Supabase veritabanını kurun
1. Supabase Dashboard'da yeni bir proje oluşturun.
2. SQL Editor > New query bölümünü açın.
3. `supabase/schema.sql` dosyasının tamamını yapıştırıp çalıştırın.
4. Authentication > Users bölümünden yönetici için bir kullanıcı oluşturun (e-posta ve güçlü şifre). Public sign-up özelliğini kapalı tutun. Bu kullanıcı yönetici paneline giriş yapacaktır.
5. Project Settings > API bölümünden Project URL ve anon/public key değerlerini alın.

## 2. Projeyi yerelde çalıştırın
```bash
npm install
cp .env.example .env.local
```
`.env.local` dosyasını açıp Supabase değerlerini girin:
```
NEXT_PUBLIC_SUPABASE_URL=https://....supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJ...
```
Ardından:
```bash
npm run dev
```
Site: http://localhost:3000 — Yönetim: http://localhost:3000/admin

## 3. İnternette yayınlama (Vercel)
1. Projeyi GitHub'a yükleyin.
2. Vercel'de Add New > Project ile GitHub deposunu içe aktarın.
3. Environment Variables bölümüne `.env.local` içindeki iki değişkeni ekleyin.
4. Deploy'a basın. Vercel size HTTPS adresi verir.
5. Yayın adresini açıp menüyü ve `/admin` girişini test edin.

## Yönetim paneli
- E-posta/şifre Supabase Authentication kullanır.
- Logo ve kampanya fotoğrafları telefon galerisi/kamera dosya seçicisinden yüklenebilir.
- Kampanya adı, açıklaması, fiyatı; yemek adı, kategorisi ve fiyatı değiştirilebilir.
- Yeni yemek eklenebilir ve yemek silinebilir.
- Değişiklikler Supabase'e kaydedilir ve müşterilerin menüsüne yansır.

## Güvenlik notları
- `service_role` anahtarını asla tarayıcıya veya `.env.local` içindeki `NEXT_PUBLIC_` değişkenlerine koymayın.
- Yönetici şifresini kimseyle paylaşmayın; güçlü ve benzersiz şifre kullanın.
- Supabase public sign-up kapalı olmalıdır. Yönetici kullanıcılarını yalnızca proje sahibi oluşturmalıdır.
- Görsel yükleme sınırı 5 MB; JPEG, PNG ve WebP kabul edilir.

## Önemli
Bu kaynak kodu yayınlamaya hazır proje iskeletidir; canlı site kendiliğinden yayınlanmış değildir. Önce Supabase projesi ve Vercel bağlantısı kurulmalı, ortam değişkenleri girilmeli ve yönetici hesabı oluşturulmalıdır. Logo ve kampanya fotoğrafları yönetici panelinden sonradan yüklenebilir.
