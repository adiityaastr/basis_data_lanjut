# Dokumentasi File SQL - UAS Basis Data Lanjut

## Struktur File SQL

File SQL disusun secara berurutan untuk memudahkan eksekusi:

### 1. `00_complete_setup.sql`
File utama yang akan menjalankan semua file SQL secara berurutan. **Catatan:** File ini menggunakan `SOURCE` command yang hanya bekerja di MySQL command line.

### 2. `01_create_database.sql`
Membuat struktur database:
- Database: `food_ordering_db`
- Tabel: `customers`
- Tabel: `orders`
- Tabel: `activity_logs`

**Cara menjalankan:**
```bash
mysql -u root -p < 01_create_database.sql
```

### 3. `02_insert_sample_data.sql`
Mengisi data sample:
- 50 customers
- 1000 orders (menggunakan stored procedure)

**Cara menjalankan:**
```bash
mysql -u root -p < 02_insert_sample_data.sql
```

**Catatan:** File ini menggunakan stored procedure untuk generate 1000 orders secara random. Proses ini mungkin membutuhkan waktu beberapa detik.

### 4. `03_create_triggers.sql`
Membuat trigger untuk logging CRUD operations:
- Trigger INSERT, UPDATE, DELETE untuk tabel `customers`
- Trigger INSERT, UPDATE, DELETE untuk tabel `orders`

**Cara menjalankan:**
```bash
mysql -u root -p < 03_create_triggers.sql
```

**Verifikasi trigger:**
```sql
SHOW TRIGGERS;
```

### 5. `04_test_queries.sql`
Berisi 5 query test sesuai spesifikasi soal:
1. Daftar pesanan lengkap dengan informasi pelanggan
2. Pelanggan yang belum pernah membuat pesanan
3. Jumlah pesanan per hari dalam 7 hari terakhir
4. Order terbesar untuk setiap pelanggan
5. Rata-rata total order harian dan perbandingan dengan hari ini

**Cara menjalankan:**
```bash
mysql -u root -p food_ordering_db < 04_test_queries.sql
```

Atau jalankan query satu per satu di MySQL client.

## Cara Menjalankan Semua File SQL

### Metode 1: Satu per satu (Direkomendasikan)
```bash
# 1. Buat database dan tabel
mysql -u root -p < 01_create_database.sql

# 2. Insert data sample
mysql -u root -p < 02_insert_sample_data.sql

# 3. Buat trigger
mysql -u root -p < 03_create_triggers.sql

# 4. Test query (opsional, untuk melihat hasil)
mysql -u root -p food_ordering_db < 04_test_queries.sql
```

### Metode 2: Menggunakan MySQL Command Line
```bash
mysql -u root -p
```
Kemudian di dalam MySQL:
```sql
SOURCE /path/to/01_create_database.sql;
SOURCE /path/to/02_insert_sample_data.sql;
SOURCE /path/to/03_create_triggers.sql;
```

### Metode 3: Menggunakan file lengkap
Jika ingin menjalankan semua dalam satu command:
```bash
cat 01_create_database.sql 02_insert_sample_data.sql 03_create_triggers.sql | mysql -u root -p
```

## Verifikasi Setup

Setelah menjalankan semua file SQL, verifikasi dengan query berikut:

```sql
USE food_ordering_db;

-- Cek jumlah customers (harus 50)
SELECT COUNT(*) AS total_customers FROM customers;

-- Cek jumlah orders (harus 1000)
SELECT COUNT(*) AS total_orders FROM orders;

-- Cek trigger yang sudah dibuat (harus 6 trigger)
SHOW TRIGGERS;

-- Cek activity logs (harus ada log dari insert data)
SELECT COUNT(*) AS total_logs FROM activity_logs;
SELECT table_name, action, COUNT(*) AS jumlah 
FROM activity_logs 
GROUP BY table_name, action;
```

## Testing Trigger

Untuk menguji trigger bekerja dengan baik:

```sql
USE food_ordering_db;

-- Test INSERT (akan membuat log)
INSERT INTO customers (name, phone, email, created_at) 
VALUES ('Test Customer', '081999999999', 'test@email.com', NOW());

-- Test UPDATE (akan membuat log)
UPDATE customers SET name = 'Test Customer Updated' 
WHERE phone = '081999999999';

-- Test DELETE (akan membuat log)
DELETE FROM customers WHERE phone = '081999999999';

-- Cek log yang terbuat
SELECT * FROM activity_logs 
WHERE record_id = (SELECT customer_id FROM customers WHERE phone = '081999999999')
ORDER BY created_at DESC;
```

## Troubleshooting

### Error: Database already exists
```sql
DROP DATABASE IF EXISTS food_ordering_db;
```
Kemudian jalankan ulang `01_create_database.sql`

### Error: Table already exists
```sql
USE food_ordering_db;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS activity_logs;
```
Kemudian jalankan ulang `01_create_database.sql`

### Error: Trigger already exists
File `03_create_triggers.sql` sudah include `DROP TRIGGER IF EXISTS`, jadi aman untuk dijalankan ulang.

### Error: Foreign key constraint fails
Pastikan menjalankan file SQL secara berurutan:
1. `01_create_database.sql` (membuat tabel customers dulu)
2. `02_insert_sample_data.sql` (insert data)
3. `03_create_triggers.sql` (trigger)

### Data tidak ter-generate dengan benar
Jika jumlah orders tidak mencapai 1000, jalankan ulang `02_insert_sample_data.sql`. Pastikan tidak ada error saat stored procedure berjalan.

## Catatan Penting

1. **Password MySQL:** Ganti `-p` dengan password MySQL Anda, atau gunakan `-p` dan masukkan password saat diminta.

2. **Path File:** Pastikan path file SQL benar saat menggunakan `SOURCE` command.

3. **Waktu Eksekusi:** File `02_insert_sample_data.sql` mungkin membutuhkan waktu beberapa detik untuk generate 1000 orders.

4. **Backup:** Sebelum menjalankan script, disarankan untuk backup database jika sudah ada data penting.

5. **MySQL Version:** Script ini menggunakan syntax MySQL 5.7+ / MariaDB 10.2+.
