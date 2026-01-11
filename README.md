# UAS Basis Data Lanjut - Sistem Online Food Delivery

## Deskripsi Proyek
Proyek ini adalah implementasi sistem online food delivery sederhana menggunakan Laravel dengan database MySQL. Sistem ini terdiri dari 2 tabel utama: `customers` dan `orders`.

## Struktur Database

### Tabel: customers
- `customer_id` (INT, PK, AUTO_INCREMENT)
- `name` (VARCHAR 100)
- `phone` (VARCHAR 20, UNIQUE)
- `email` (VARCHAR 100)
- `created_at` (DATETIME)

### Tabel: orders
- `order_id` (INT, PK, AUTO_INCREMENT)
- `customer_id` (INT, FK → customers.customer_id)
- `order_date` (DATETIME)
- `order_total` (DECIMAL 10,2)
- `status` (VARCHAR 20) - pending, paid, canceled, delivered

### Tabel: activity_logs
- `log_id` (INT, PK, AUTO_INCREMENT)
- `table_name` (VARCHAR 50)
- `action` (VARCHAR 20) - INSERT, UPDATE, DELETE
- `old_data` (TEXT, nullable)
- `new_data` (TEXT, nullable)
- `record_id` (VARCHAR 50, nullable)
- `created_at` (TIMESTAMP)

## Instalasi

1. Clone repository atau extract project
2. Install dependencies:
```bash
composer install
```

3. Copy file `.env.example` menjadi `.env`:
```bash
cp .env.example .env
```

4. Generate application key:
```bash
php artisan key:generate
```

5. Konfigurasi database di file `.env`:
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=food_ordering_db
DB_USERNAME=root
DB_PASSWORD=
```

6. Buat database MySQL:
```sql
CREATE DATABASE food_ordering_db;
```

7. Jalankan migration:
```bash
php artisan migrate
```

8. Jalankan trigger SQL (jika menggunakan MySQL):
```bash
mysql -u root -p food_ordering_db < database/triggers.sql
```

9. Jalankan seeder untuk generate data:
```bash
php artisan db:seed
```

10. Jalankan server:
```bash
php artisan serve
```

## API Endpoints

Lihat file `API_DOCUMENTATION.md` untuk dokumentasi lengkap API endpoints.

### Base URL
```
http://localhost:8000/api
```

### Endpoints Customer
- `GET /api/customers` - Get all customers
- `GET /api/customers/{id}` - Get customer by ID
- `POST /api/customers` - Create customer
- `PUT /api/customers/{id}` - Update customer
- `DELETE /api/customers/{id}` - Delete customer

### Endpoints Order
- `GET /api/orders` - Get all orders
- `GET /api/orders/{id}` - Get order by ID
- `POST /api/orders` - Create order
- `PUT /api/orders/{id}` - Update order
- `DELETE /api/orders/{id}` - Delete order

## Testing

### Testing API dengan Postman
1. Import collection dari `API_DOCUMENTATION.md`
2. Pastikan server Laravel berjalan
3. Test setiap endpoint
4. Screenshot hasil untuk dokumentasi

### Testing Query
File `database/test_queries.sql` berisi 5 query test sesuai spesifikasi:
1. Daftar pesanan lengkap dengan informasi pelanggan
2. Pelanggan yang belum pernah membuat pesanan
3. Jumlah pesanan per hari dalam 7 hari terakhir
4. Order terbesar untuk setiap pelanggan
5. Rata-rata total order harian dan perbandingan dengan hari ini

## File Penting

- `database/migrations/` - File migration untuk struktur database
- `database/seeders/` - Seeder untuk generate data (50 customers, 1000 orders)
- `database/triggers.sql` - SQL script untuk trigger logging
- `database/test_queries.sql` - SQL script untuk test query
- `app/Http/Controllers/Api/` - API Controllers
- `app/Models/` - Eloquent Models
- `routes/api.php` - API Routes
- `API_DOCUMENTATION.md` - Dokumentasi lengkap API

## Struktur Laporan

Format jawaban sesuai soal:
1. Cover (nama, NIM, kelas)
2. Design database
3. Capture hasil testing postman (CRUD), Trigger, dan hasil query
4. Source code Laravel API, database, paper jawaban

## Catatan

- Pastikan menggunakan MySQL untuk trigger (SQLite tidak mendukung trigger)
- Trigger akan otomatis mencatat semua operasi CRUD ke tabel `activity_logs`
- Seeder akan generate 50 customers dan 1000 orders secara otomatis
