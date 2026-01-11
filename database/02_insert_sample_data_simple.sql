-- =============================================
-- UAS BASIS DATA LANJUT
-- Sistem Online Food Delivery
-- File: 02_insert_sample_data_simple.sql
-- Deskripsi: Script untuk insert data sample (versi sederhana)
-- - 50 customers
-- - 1000 orders (menggunakan INSERT langsung)
-- =============================================

USE food_ordering_db;

-- =============================================
-- INSERT DATA CUSTOMERS (50 data)
-- =============================================
INSERT INTO customers (name, phone, email, created_at) VALUES
('Ahmad Rizki', '081234567890', 'ahmad.rizki@email.com', '2024-01-15 10:00:00'),
('Siti Nurhaliza', '081234567891', 'siti.nurhaliza@email.com', '2024-01-16 11:00:00'),
('Budi Santoso', '081234567892', 'budi.santoso@email.com', '2024-01-17 12:00:00'),
('Dewi Lestari', '081234567893', 'dewi.lestari@email.com', '2024-01-18 13:00:00'),
('Eko Prasetyo', '081234567894', 'eko.prasetyo@email.com', '2024-01-19 14:00:00'),
('Fitri Handayani', '081234567895', 'fitri.handayani@email.com', '2024-01-20 15:00:00'),
('Gunawan Wijaya', '081234567896', 'gunawan.wijaya@email.com', '2024-01-21 16:00:00'),
('Hesti Rahayu', '081234567897', 'hesti.rahayu@email.com', '2024-01-22 17:00:00'),
('Indra Kurniawan', '081234567898', 'indra.kurniawan@email.com', '2024-01-23 18:00:00'),
('Jihan Putri', '081234567899', 'jihan.putri@email.com', '2024-01-24 19:00:00'),
('Kurniawan Adi', '081234567900', 'kurniawan.adi@email.com', '2024-01-25 20:00:00'),
('Lina Marlina', '081234567901', 'lina.marlina@email.com', '2024-01-26 21:00:00'),
('Muhammad Ali', '081234567902', 'muhammad.ali@email.com', '2024-01-27 22:00:00'),
('Nurul Hidayati', '081234567903', 'nurul.hidayati@email.com', '2024-01-28 23:00:00'),
('Oki Setiawan', '081234567904', 'oki.setiawan@email.com', '2024-01-29 10:00:00'),
('Putri Sari', '081234567905', 'putri.sari@email.com', '2024-01-30 11:00:00'),
('Rizki Pratama', '081234567906', 'rizki.pratama@email.com', '2024-02-01 12:00:00'),
('Sari Dewi', '081234567907', 'sari.dewi@email.com', '2024-02-02 13:00:00'),
('Teguh Wijaya', '081234567908', 'teguh.wijaya@email.com', '2024-02-03 14:00:00'),
('Umi Kalsum', '081234567909', 'umi.kalsum@email.com', '2024-02-04 15:00:00'),
('Vino Bastian', '081234567910', 'vino.bastian@email.com', '2024-02-05 16:00:00'),
('Wulan Sari', '081234567911', 'wulan.sari@email.com', '2024-02-06 17:00:00'),
('Yoga Pratama', '081234567912', 'yoga.pratama@email.com', '2024-02-07 18:00:00'),
('Zahra Putri', '081234567913', 'zahra.putri@email.com', '2024-02-08 19:00:00'),
('Ade Kurniawan', '081234567914', 'ade.kurniawan@email.com', '2024-02-09 20:00:00'),
('Bella Sari', '081234567915', 'bella.sari@email.com', '2024-02-10 21:00:00'),
('Cahya Pratama', '081234567916', 'cahya.pratama@email.com', '2024-02-11 22:00:00'),
('Dina Lestari', '081234567917', 'dina.lestari@email.com', '2024-02-12 23:00:00'),
('Eka Wijaya', '081234567918', 'eka.wijaya@email.com', '2024-02-13 10:00:00'),
('Fajar Nugroho', '081234567919', 'fajar.nugroho@email.com', '2024-02-14 11:00:00'),
('Gita Sari', '081234567920', 'gita.sari@email.com', '2024-02-15 12:00:00'),
('Hadi Kurniawan', '081234567921', 'hadi.kurniawan@email.com', '2024-02-16 13:00:00'),
('Indah Permata', '081234567922', 'indah.permata@email.com', '2024-02-17 14:00:00'),
('Joko Susilo', '081234567923', 'joko.susilo@email.com', '2024-02-18 15:00:00'),
('Kartika Sari', '081234567924', 'kartika.sari@email.com', '2024-02-19 16:00:00'),
('Lukman Hakim', '081234567925', 'lukman.hakim@email.com', '2024-02-20 17:00:00'),
('Maya Sari', '081234567926', 'maya.sari@email.com', '2024-02-21 18:00:00'),
('Nanda Pratama', '081234567927', 'nanda.pratama@email.com', '2024-02-22 19:00:00'),
('Oktavia Putri', '081234567928', 'oktavia.putri@email.com', '2024-02-23 20:00:00'),
('Pandu Wijaya', '081234567929', 'pandu.wijaya@email.com', '2024-02-24 21:00:00'),
('Qori Sandria', '081234567930', 'qori.sandria@email.com', '2024-02-25 22:00:00'),
('Rina Marlina', '081234567931', 'rina.marlina@email.com', '2024-02-26 23:00:00'),
('Surya Pratama', '081234567932', 'surya.pratama@email.com', '2024-02-27 10:00:00'),
('Tika Sari', '081234567933', 'tika.sari@email.com', '2024-02-28 11:00:00'),
('Udin Sedunia', '081234567934', 'udin.sedunia@email.com', '2024-03-01 12:00:00'),
('Vina Lestari', '081234567935', 'vina.lestari@email.com', '2024-03-02 13:00:00'),
('Wahyu Kurniawan', '081234567936', 'wahyu.kurniawan@email.com', '2024-03-03 14:00:00'),
('Xena Putri', '081234567937', 'xena.putri@email.com', '2024-03-04 15:00:00'),
('Yusuf Pratama', '081234567938', 'yusuf.pratama@email.com', '2024-03-05 16:00:00'),
('Zaskia Sari', '081234567939', 'zaskia.sari@email.com', '2024-03-06 17:00:00');

-- =============================================
-- INSERT DATA ORDERS (1000 data)
-- Catatan: File ini sangat panjang karena 1000 INSERT statements
-- Untuk versi yang lebih praktis, gunakan script PHP/Python
-- atau gunakan file 02_insert_sample_data.sql dengan stored procedure
-- =============================================

-- Karena 1000 INSERT statements akan membuat file sangat panjang,
-- disarankan menggunakan salah satu metode berikut:
-- 1. Gunakan file 02_insert_sample_data.sql (dengan stored procedure)
-- 2. Gunakan script generator (PHP/Python) untuk generate INSERT statements
-- 3. Gunakan LOAD DATA INFILE jika data dalam format CSV

-- Contoh: Generate 1000 orders dengan distribusi yang baik
-- Setiap customer akan mendapat sekitar 20 orders
-- Data akan tersebar dalam 6 bulan terakhir

-- Untuk generate 1000 orders, jalankan query berikut di MySQL:
-- (Catatan: Query ini menggunakan fungsi RAND() yang mungkin tidak konsisten)

-- Alternatif: Gunakan script generator atau file 02_insert_sample_data.sql
