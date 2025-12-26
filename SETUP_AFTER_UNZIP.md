# Setup Instruksi Setelah Unzip

## GAWE LARAVEL

1. Install dependencies:
```bash
cd gawegawelaravel
composer install
```
- jika belum download sanctum 
composer require laravel/sanctum

2. Setup environment:
```bash
copy .env.example .env
php artisan key:generate
```

3. Setup database di .env:
```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=your_database_name
DB_USERNAME=root
DB_PASSWORD=
```

4. Migrate database:
```bash
php artisan migrate
php artisan storage:link
```


5. Jalankan server:
```bash
php artisan serve
php artisan serve --host 0.0.0.0 --port 8000
```

## Untuk wahidflutter (Frontend)

1. Install dependencies:
```bash
cd gawe
flutter pub get
```

2. Konfigurasi API URL di `lib/config/app_config.dart`:
   - Android Emulator: `http://10.0.2.2:8000/api`
   - Web (Chrome): `http://127.0.0.1:8000/api`
   - Physical Device: `http://YOUR_IP:8000/api`

3. Jalankan aplikasi:
```bash
# Untuk Chrome
flutter run -d chrome

# Untuk Android
flutter run

# Untuk iOS
flutter run -d ios
```

## Catatan Penting

- File `.env` di Laravel tidak disertakan dalam zip (security)
- Folder `vendor` di Laravel tidak disertakan (gunakan `composer install`)
- Folder `node_modules` tidak disertakan (jika ada)
- Folder `build` Flutter tidak disertakan (gunakan `flutter pub get`)
- Database harus dibuat manual dan di-migrate
- Passport keys akan di-generate saat `passport:install`

## Troubleshooting

Jika ada error setelah setup:
```bash
# Laravel
php artisan config:clear
php artisan cache:clear
php artisan route:clear
composer dump-autoload

# Flutter
flutter clean
flutter pub get
```
