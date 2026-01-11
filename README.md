# UAS Basis Data Lanjut - Sistem Online Food Delivery

## Deskripsi Proyek
Proyek ini adalah implementasi sistem online food delivery sederhana menggunakan Laravel dengan database MySQL. Sistem ini terdiri dari 3 tabel utama: `customers`, `orders`, dan `sessions`.

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

### Tabel: activity_logs (Trigger Log)
- `log_id` (INT, PK, AUTO_INCREMENT)
- `table_name` (VARCHAR 50)
- `action` (VARCHAR 20) - INSERT, UPDATE, DELETE
- `old_data` (TEXT, nullable)
- `new_data` (TEXT, nullable)
- `record_id` (VARCHAR 50, nullable)
- `created_at` (TIMESTAMP)

### Tabel: sessions (Laravel Session)
- `id` (VARCHAR 255, PK)
- `user_id` (BIGINT, nullable)
- `ip_address` (VARCHAR 45)
- `user_agent` (TEXT)
- `payload` (LONGTEXT)
- `last_activity` (INT)

## Instalasi

### Prasyarat
- PHP 8.2+
- Composer
- MySQL

### Langkah Instalasi

1. **Clone repository**
   ```bash
   git clone [url-repo]
   cd [nama-folder]
   ```

2. **Install Dependencies**
   ```bash
   composer install
   ```

3. **Setup Environment**
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

4. **Konfigurasi Database (.env)**
   Sesuaikan dengan kredensial database Anda:
   ```env
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=food_ordering_db
   DB_USERNAME=root
   DB_PASSWORD=
   ```

5. **Setup Database**
   Terdapat dua cara untuk setup database. Pilih salah satu:

   **Opsi A: Full Import (Rekomendasi untuk Penilaian)**
   Gunakan file SQL lengkap yang sudah berisi struktur, trigger, stored procedure, dan data dummy (50 customer, 2000 order).
   
   1. Buat database kosong `food_ordering_db`.
   2. Import file `database/COMPLETE_UAS_SQL_SIMPLE.sql` ke database tersebut menggunakan HeidiSQL / phpMyAdmin / Terminal.
   
   **Opsi B: Laravel Migration & Seed (Development)**
   ```bash
   # Buat tabel
   php artisan migrate

   # Jalankan trigger manual (jika diperlukan)
   mysql -u root -p food_ordering_db < database/triggers.sql
   
   # Isi data dummy
   php artisan db:seed
   ```

6. **Jalankan Server**
   ```bash
   php artisan serve
   ```
   Akses di: `http://localhost:8000`

## API Endpoints

### 1. Customers
- `GET /api/customers` - List semua customer
- `GET /api/customers/{id}` - Detail customer
- `POST /api/customers` - Buat customer baru
- `PUT /api/customers/{id}` - Update customer
- `DELETE /api/customers/{id}` - Hapus customer

### 2. Orders
- `GET /api/orders` - List semua order
- `GET /api/orders/{id}` - Detail order
- `POST /api/orders` - Buat order baru
- `PUT /api/orders/{id}` - Update order
- `DELETE /api/orders/{id}` - Hapus order

### 3. Query Tests (Soal UAS)
Endpoint khusus untuk menjalankan 5 query wajib soal UAS:

- `GET /api/queries/1`
  *Daftar pesanan lengkap (nama, telp, total, tanggal)*
  
- `GET /api/queries/2`
  *Pelanggan yang belum pernah order*
  
- `GET /api/queries/3`
  *Jumlah pesanan per hari (7 hari terakhir)*
  
- `GET /api/queries/4`
  *Order terbesar untuk setiap pelanggan*
  
- `GET /api/queries/5`
  *Rata-rata order harian vs hari ini*

- `GET /api/queries/all`
  *Menjalankan semua query sekaligus*

## Verifikasi
1. **Trigger Logging**: Cek tabel `activity_logs` setelah melakukan create/update/delete via API.
2. **Data**: Pastikan tabel `customers` memiliki 50 data dan `orders` memiliki 2000 data (jika menggunakan Opsi A).
