-- =============================================
-- BAGIAN 1: CREATE DATABASE DAN STRUKTUR TABEL
-- =============================================

-- Hapus database jika sudah ada (untuk re-run)
DROP DATABASE IF EXISTS food_ordering_db;

-- Buat database baru
CREATE DATABASE food_ordering_db;
USE food_ordering_db;

-- =============================================
-- TABEL: customers
-- =============================================
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_phone (phone),
    INDEX idx_email (email)
);

-- =============================================
-- TABEL: orders
-- =============================================
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    order_total DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    INDEX idx_customer_id (customer_id),
    INDEX idx_order_date (order_date),
    INDEX idx_status (status),
    INDEX idx_order_total (order_total)
);

-- =============================================
-- TABEL: activity_logs (untuk trigger logging)
-- =============================================
CREATE TABLE activity_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(50) NOT NULL,
    action VARCHAR(20) NOT NULL COMMENT 'INSERT, UPDATE, DELETE',
    old_data TEXT NULL,
    new_data TEXT NULL,
    record_id VARCHAR(50) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_table_name (table_name),
    INDEX idx_action (action),
    INDEX idx_record_id (record_id),
    INDEX idx_created_at (created_at)
);

-- =============================================
-- BAGIAN 2: INSERT DATA SAMPLE
-- =============================================

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
-- INSERT DATA ORDERS (2000 data)
-- Menggunakan stored procedure untuk generate random data
-- =============================================

DELIMITER $$

-- Stored Procedure untuk generate orders
CREATE PROCEDURE generate_orders()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE customer_count INT;
    DECLARE random_customer_id INT;
    DECLARE random_date DATETIME;
    DECLARE random_total DECIMAL(10,2);
    DECLARE random_status VARCHAR(20);
    
    SELECT COUNT(*) INTO customer_count FROM customers;
    
    WHILE i <= 2000 DO
        -- Random customer_id dari 1 sampai customer_count
        SET random_customer_id = FLOOR(1 + RAND() * customer_count);
        
        -- Random date dalam 6 bulan terakhir
        SET random_date = DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 180) DAY);
        SET random_date = DATE_ADD(random_date, INTERVAL FLOOR(RAND() * 24) HOUR);
        SET random_date = DATE_ADD(random_date, INTERVAL FLOOR(RAND() * 60) MINUTE);
        
        -- Random total antara 10000 sampai 500000
        SET random_total = 10000 + (RAND() * 490000);
        SET random_total = ROUND(random_total, 2);
        
        -- Random status
        SET random_status = ELT(1 + FLOOR(RAND() * 4), 'pending', 'paid', 'canceled', 'delivered');
        
        INSERT INTO orders (customer_id, order_date, order_total, status)
        VALUES (random_customer_id, random_date, random_total, random_status);
        
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- Jalankan stored procedure untuk generate orders
CALL generate_orders();

-- Hapus stored procedure setelah digunakan
DROP PROCEDURE IF EXISTS generate_orders;

-- =============================================
-- BAGIAN 3: CREATE TRIGGERS UNTUK LOGGING CRUD
-- =============================================

-- Hapus trigger jika sudah ada (untuk re-run)
DROP TRIGGER IF EXISTS trg_customers_insert;
DROP TRIGGER IF EXISTS trg_customers_update;
DROP TRIGGER IF EXISTS trg_customers_delete;
DROP TRIGGER IF EXISTS trg_orders_insert;
DROP TRIGGER IF EXISTS trg_orders_update;
DROP TRIGGER IF EXISTS trg_orders_delete;

-- =============================================
-- TRIGGER UNTUK TABEL CUSTOMERS
-- =============================================

-- Trigger untuk INSERT pada tabel customers
DELIMITER $$
CREATE TRIGGER trg_customers_insert
AFTER INSERT ON customers
FOR EACH ROW
BEGIN
    INSERT INTO activity_logs (table_name, action, new_data, record_id, created_at)
    VALUES (
        'customers',
        'INSERT',
        JSON_OBJECT(
            'customer_id', NEW.customer_id,
            'name', NEW.name,
            'phone', NEW.phone,
            'email', NEW.email,
            'created_at', NEW.created_at
        ),
        CAST(NEW.customer_id AS CHAR),
        NOW()
    );
END$$
DELIMITER ;

-- Trigger untuk UPDATE pada tabel customers
DELIMITER $$
CREATE TRIGGER trg_customers_update
AFTER UPDATE ON customers
FOR EACH ROW
BEGIN
    INSERT INTO activity_logs (table_name, action, old_data, new_data, record_id, created_at)
    VALUES (
        'customers',
        'UPDATE',
        JSON_OBJECT(
            'customer_id', OLD.customer_id,
            'name', OLD.name,
            'phone', OLD.phone,
            'email', OLD.email,
            'created_at', OLD.created_at
        ),
        JSON_OBJECT(
            'customer_id', NEW.customer_id,
            'name', NEW.name,
            'phone', NEW.phone,
            'email', NEW.email,
            'created_at', NEW.created_at
        ),
        CAST(NEW.customer_id AS CHAR),
        NOW()
    );
END$$
DELIMITER ;

-- Trigger untuk DELETE pada tabel customers
DELIMITER $$
CREATE TRIGGER trg_customers_delete
AFTER DELETE ON customers
FOR EACH ROW
BEGIN
    INSERT INTO activity_logs (table_name, action, old_data, record_id, created_at)
    VALUES (
        'customers',
        'DELETE',
        JSON_OBJECT(
            'customer_id', OLD.customer_id,
            'name', OLD.name,
            'phone', OLD.phone,
            'email', OLD.email,
            'created_at', OLD.created_at
        ),
        CAST(OLD.customer_id AS CHAR),
        NOW()
    );
END$$
DELIMITER ;

-- =============================================
-- TRIGGER UNTUK TABEL ORDERS
-- =============================================

-- Trigger untuk INSERT pada tabel orders
DELIMITER $$
CREATE TRIGGER trg_orders_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO activity_logs (table_name, action, new_data, record_id, created_at)
    VALUES (
        'orders',
        'INSERT',
        JSON_OBJECT(
            'order_id', NEW.order_id,
            'customer_id', NEW.customer_id,
            'order_date', NEW.order_date,
            'order_total', NEW.order_total,
            'status', NEW.status
        ),
        CAST(NEW.order_id AS CHAR),
        NOW()
    );
END$$
DELIMITER ;

-- Trigger untuk UPDATE pada tabel orders
DELIMITER $$
CREATE TRIGGER trg_orders_update
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO activity_logs (table_name, action, old_data, new_data, record_id, created_at)
    VALUES (
        'orders',
        'UPDATE',
        JSON_OBJECT(
            'order_id', OLD.order_id,
            'customer_id', OLD.customer_id,
            'order_date', OLD.order_date,
            'order_total', OLD.order_total,
            'status', OLD.status
        ),
        JSON_OBJECT(
            'order_id', NEW.order_id,
            'customer_id', NEW.customer_id,
            'order_date', NEW.order_date,
            'order_total', NEW.order_total,
            'status', NEW.status
        ),
        CAST(NEW.order_id AS CHAR),
        NOW()
    );
END$$
DELIMITER ;

-- Trigger untuk DELETE pada tabel orders
DELIMITER $$
CREATE TRIGGER trg_orders_delete
AFTER DELETE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO activity_logs (table_name, action, old_data, record_id, created_at)
    VALUES (
        'orders',
        'DELETE',
        JSON_OBJECT(
            'order_id', OLD.order_id,
            'customer_id', OLD.customer_id,
            'order_date', OLD.order_date,
            'order_total', OLD.order_total,
            'status', OLD.status
        ),
        CAST(OLD.order_id AS CHAR),
        NOW()
    );
END$$
DELIMITER ;

-- =============================================
-- BAGIAN 4: TEST QUERIES SESUAI SPESIFIKASI SOAL
-- =============================================

-- =============================================
-- QUERY 1: Menampilkan daftar pesanan lengkap dengan:
-- - nama pelanggan
-- - nomor telepon
-- - total pesanan
-- - tanggal pesanan
-- Urutkan dari yang terbaru
-- =============================================
SELECT 
    o.order_id,
    c.name AS nama_pelanggan,
    c.phone AS nomor_telepon,
    o.order_total AS total_pesanan,
    o.order_date AS tanggal_pesanan,
    o.status
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;

-- =============================================
-- QUERY 2: Menampilkan pelanggan yang belum pernah 
-- membuat pesanan sama sekali
-- =============================================
SELECT 
    c.customer_id,
    c.name AS nama_pelanggan,
    c.phone AS nomor_telepon,
    c.email,
    c.created_at AS tanggal_registrasi
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- =============================================
-- QUERY 3: Menampilkan jumlah pesanan per hari 
-- dalam 7 hari terakhir
-- =============================================
SELECT 
    DATE(order_date) AS tanggal,
    COUNT(*) AS jumlah_pesanan,
    SUM(order_total) AS total_harian,
    AVG(order_total) AS rata_rata_harian
FROM orders
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY DATE(order_date)
ORDER BY tanggal DESC;

-- =============================================
-- QUERY 4: Menampilkan order terbesar untuk 
-- setiap pelanggan
-- =============================================
SELECT 
    c.customer_id,
    c.name AS nama_pelanggan,
    c.phone AS nomor_telepon,
    o.order_id,
    o.order_total AS total_terbesar,
    o.order_date AS tanggal_pesanan,
    o.status
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN (
    SELECT 
        customer_id,
        MAX(order_total) AS max_total
    FROM orders
    GROUP BY customer_id
) AS max_orders ON o.customer_id = max_orders.customer_id 
    AND o.order_total = max_orders.max_total
ORDER BY o.order_total DESC;

-- =============================================
-- QUERY 5: Menampilkan rata-rata total order harian 
-- dan membandingkannya dengan order hari ini
-- =============================================
SELECT 
    DATE(o.order_date) AS tanggal,
    COUNT(*) AS jumlah_order_hari_ini,
    SUM(o.order_total) AS total_order_hari_ini,
    AVG(o.order_total) AS rata_rata_order_hari_ini,
    (
        SELECT AVG(daily_total)
        FROM (
            SELECT DATE(order_date) AS tanggal, SUM(order_total) AS daily_total
            FROM orders
            WHERE order_date < CURDATE()
            GROUP BY DATE(order_date)
        ) AS daily_averages
    ) AS rata_rata_total_harian_sebelumnya,
    (
        SELECT AVG(order_total)
        FROM orders
        WHERE DATE(order_date) < CURDATE()
    ) AS rata_rata_order_per_item_sebelumnya
FROM orders o
WHERE DATE(o.order_date) = CURDATE()
GROUP BY DATE(o.order_date);

-- =============================================
-- BAGIAN 5: VERIFIKASI DATA DAN TRIGGER
-- =============================================

-- Cek jumlah customers (harus 50)
SELECT 'Total Customers' AS keterangan, COUNT(*) AS jumlah FROM customers;

-- Cek jumlah orders (harus 2000)
SELECT 'Total Orders' AS keterangan, COUNT(*) AS jumlah FROM orders;

-- Cek trigger yang sudah dibuat (harus 6 trigger)
SELECT 'Total Triggers' AS keterangan, COUNT(*) AS jumlah 
FROM information_schema.TRIGGERS 
WHERE TRIGGER_SCHEMA = 'food_ordering_db';

-- Cek activity logs dari trigger
SELECT 
    table_name,
    action,
    COUNT(*) AS jumlah_log
FROM activity_logs
GROUP BY table_name, action
ORDER BY table_name, action;

-- Cek 10 log terakhir
SELECT '10 Log Terakhir' AS keterangan, '' AS info;
SELECT * FROM activity_logs 
ORDER BY created_at DESC 
LIMIT 10;

-- =============================================
-- SELESAI
-- =============================================
-- File SQL ini sudah mencakup seluruh soal UAS:
-- 1. ✅ Design Database (CREATE TABLE customers, orders, activity_logs)
-- 2. ✅ Insert Data (50 customers, 2000 orders)
-- 3. ✅ Trigger untuk logging CRUD operations
-- 4. ✅ Test Query (5 query sesuai spesifikasi)
-- =============================================
