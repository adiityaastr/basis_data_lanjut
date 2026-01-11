# Panduan Setup Proyek UAS Basis Data Lanjut

## Persyaratan
- PHP >= 8.2
- Composer
- MySQL
- Laravel 12

## Langkah-langkah Setup

### 1. Install Dependencies
```bash
composer install
```

### 2. Setup Environment
```bash
cp .env.example .env
php artisan key:generate
```

### 3. Konfigurasi Database
Edit file `.env` dan sesuaikan konfigurasi database:
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=food_ordering_db
DB_USERNAME=root
DB_PASSWORD=
```

### 4. Buat Database MySQL
```bash
mysql -u root -p
```
Kemudian jalankan:
```sql
CREATE DATABASE food_ordering_db;
EXIT;
```

Atau gunakan file SQL:
```bash
mysql -u root -p < database/database_structure.sql
```

### 5. Jalankan Migration
```bash
php artisan migrate
```

### 6. Setup Trigger (MySQL)
```bash
mysql -u root -p food_ordering_db < database/triggers.sql
```

### 7. Generate Data dengan Seeder
```bash
php artisan db:seed
```

Ini akan generate:
- 50 customers
- 1000 orders

### 8. Jalankan Server
```bash
php artisan serve
```

Server akan berjalan di `http://localhost:8000`

## Testing API

### Menggunakan Postman
1. Import collection dari dokumentasi API
2. Base URL: `http://localhost:8000/api`
3. Test semua endpoint CRUD

### Menggunakan cURL

**Get All Customers:**
```bash
curl http://localhost:8000/api/customers
```

**Create Customer:**
```bash
curl -X POST http://localhost:8000/api/customers \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "phone": "081234567890",
    "email": "john@example.com"
  }'
```

**Get All Orders:**
```bash
curl http://localhost:8000/api/orders
```

**Create Order:**
```bash
curl -X POST http://localhost:8000/api/orders \
  -H "Content-Type: application/json" \
  -d '{
    "customer_id": 1,
    "order_date": "2025-01-10 12:00:00",
    "order_total": 150000.00,
    "status": "pending"
  }'
```

## Testing Query

Jalankan query dari file `database/test_queries.sql` di MySQL:

```bash
mysql -u root -p food_ordering_db < database/test_queries.sql
```

Atau copy-paste query satu per satu di MySQL client.

## Verifikasi Trigger

Setelah melakukan operasi CRUD melalui API, cek tabel `activity_logs`:

```sql
SELECT * FROM activity_logs ORDER BY created_at DESC LIMIT 10;
```

## Troubleshooting

### Error: Database connection failed
- Pastikan MySQL berjalan
- Cek konfigurasi di `.env`
- Pastikan database sudah dibuat

### Error: Table already exists
```bash
php artisan migrate:fresh
```

### Error: Seeder tidak berjalan
```bash
php artisan db:seed --class=CustomerSeeder
php artisan db:seed --class=OrderSeeder
```

### Trigger tidak berfungsi
- Pastikan menggunakan MySQL (bukan SQLite)
- Pastikan trigger sudah dijalankan
- Cek dengan: `SHOW TRIGGERS;`
