# File SQL Lengkap - COMPLETE_UAS_SQL.sql

## Deskripsi
File `COMPLETE_UAS_SQL.sql` adalah file SQL lengkap yang mencakup **seluruh soal UAS Basis Data Lanjut** dalam satu file. File ini bisa dijalankan sekali jalan untuk setup database lengkap.

## Isi File

File ini mencakup 5 bagian utama:

### 1. CREATE DATABASE dan Struktur Tabel ✅
- Database: `food_ordering_db`
- Tabel `customers` dengan struktur sesuai spesifikasi
- Tabel `orders` dengan foreign key ke `customers`
- Tabel `activity_logs` untuk logging trigger

### 2. INSERT Data Sample ✅
- **50 customers** dengan data lengkap (nama, phone, email, created_at)
- **1000 orders** yang di-generate secara random menggunakan stored procedure
  - Random customer_id (distribusi merata)
  - Random order_date (dalam 6 bulan terakhir)
  - Random order_total (antara 10.000 - 500.000)
  - Random status (pending, paid, canceled, delivered)

### 3. CREATE TRIGGERS ✅
- **6 trigger** untuk logging CRUD operations:
  - `trg_customers_insert` - Log setiap INSERT di tabel customers
  - `trg_customers_update` - Log setiap UPDATE di tabel customers
  - `trg_customers_delete` - Log setiap DELETE di tabel customers
  - `trg_orders_insert` - Log setiap INSERT di tabel orders
  - `trg_orders_update` - Log setiap UPDATE di tabel orders
  - `trg_orders_delete` - Log setiap DELETE di tabel orders

### 4. TEST QUERIES ✅
**5 query sesuai spesifikasi soal:**
1. Daftar pesanan lengkap dengan nama pelanggan, nomor telepon, total pesanan, tanggal pesanan (urutkan terbaru)
2. Pelanggan yang belum pernah membuat pesanan sama sekali
3. Jumlah pesanan per hari dalam 7 hari terakhir
4. Order terbesar untuk setiap pelanggan
5. Rata-rata total order harian dan perbandingan dengan order hari ini

### 5. Verifikasi Data ✅
- Cek jumlah customers (harus 50)
- Cek jumlah orders (harus 1000)
- Cek trigger yang sudah dibuat (harus 6)
- Cek activity logs dari trigger

## Cara Menggunakan

### Metode 1: Command Line (Direkomendasikan)
```bash
mysql -u root -p < database/COMPLETE_UAS_SQL.sql
```

Atau jika sudah masuk ke MySQL:
```bash
mysql -u root -p
```
Kemudian:
```sql
SOURCE /path/to/COMPLETE_UAS_SQL.sql;
```

### Metode 2: Copy-Paste
1. Buka file `COMPLETE_UAS_SQL.sql`
2. Copy semua isinya
3. Paste ke MySQL client (phpMyAdmin, MySQL Workbench, atau command line)
4. Jalankan

## Waktu Eksekusi
- **Perkiraan waktu:** 10-30 detik (tergantung spesifikasi server)
- Bagian yang paling lama: Generate 1000 orders menggunakan stored procedure

## Verifikasi Setelah Eksekusi

Setelah file SQL berhasil dijalankan, verifikasi dengan query berikut:

```sql
USE food_ordering_db;

-- Cek jumlah customers (harus 50)
SELECT COUNT(*) AS total_customers FROM customers;

-- Cek jumlah orders (harus 1000)
SELECT COUNT(*) AS total_orders FROM orders;

-- Cek trigger (harus 6 trigger)
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
WHERE table_name = 'customers' 
ORDER BY created_at DESC 
LIMIT 5;
```

## Troubleshooting

### Error: Database already exists
File sudah include `DROP DATABASE IF EXISTS`, jadi aman untuk dijalankan ulang.

### Error: Stored procedure error
Pastikan menggunakan MySQL 5.7+ atau MariaDB 10.2+. Stored procedure memerlukan MySQL versi yang mendukung.

### Error: Foreign key constraint fails
Pastikan menjalankan file secara lengkap. Jangan skip bagian CREATE TABLE.

### Data tidak lengkap
Jika jumlah orders tidak mencapai 1000, jalankan ulang file SQL. Pastikan tidak ada error saat stored procedure berjalan.

## Catatan Penting

1. **Backup Database:** Jika sudah ada database `food_ordering_db`, file ini akan menghapusnya. Backup dulu jika ada data penting.

2. **MySQL Version:** File ini menggunakan syntax MySQL 5.7+ / MariaDB 10.2+. Pastikan versi MySQL Anda kompatibel.

3. **Waktu Eksekusi:** Proses generate 1000 orders mungkin membutuhkan waktu beberapa detik. Tunggu sampai selesai.

4. **Trigger Logging:** Setelah file SQL dijalankan, semua operasi CRUD akan otomatis tercatat di tabel `activity_logs`.

5. **Re-run:** File ini aman untuk dijalankan ulang karena sudah include `DROP DATABASE IF EXISTS` dan `DROP TRIGGER IF EXISTS`.

## Struktur File untuk Laporan

File `COMPLETE_UAS_SQL.sql` ini bisa digunakan langsung untuk:
- ✅ Screenshot struktur database
- ✅ Screenshot hasil query
- ✅ Dokumentasi source code SQL
- ✅ Paper jawaban UAS

## Keuntungan File Lengkap

1. **Satu File:** Semua dalam satu file, mudah dijalankan
2. **Lengkap:** Mencakup seluruh soal UAS
3. **Siap Pakai:** Tidak perlu menjalankan beberapa file terpisah
4. **Dokumentasi:** Sudah ada komentar di setiap bagian
5. **Verifikasi:** Sudah include query verifikasi di akhir

---

**File ini siap digunakan untuk UAS Basis Data Lanjut!** 🎓
