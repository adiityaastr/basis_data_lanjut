-- =============================================
-- UAS BASIS DATA LANJUT
-- Sistem Online Food Delivery
-- File: 04_test_queries.sql
-- Deskripsi: Script untuk test query sesuai spesifikasi
-- =============================================

USE food_ordering_db;

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

-- Versi 1: Query detail dengan subquery
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

-- Versi 2: Query perbandingan dengan UNION
SELECT 
    'Hari Ini' AS periode,
    COUNT(*) AS jumlah_order,
    COALESCE(SUM(order_total), 0) AS total_order,
    COALESCE(AVG(order_total), 0) AS rata_rata_order
FROM orders
WHERE DATE(order_date) = CURDATE()

UNION ALL

SELECT 
    'Rata-rata Harian (Sebelumnya)' AS periode,
    ROUND(COUNT(*) / NULLIF(COUNT(DISTINCT DATE(order_date)), 0), 2) AS jumlah_order,
    COALESCE(AVG(daily_total), 0) AS total_order,
    COALESCE(AVG(daily_avg), 0) AS rata_rata_order
FROM (
    SELECT 
        DATE(order_date) AS tanggal,
        COUNT(*) AS daily_count,
        SUM(order_total) AS daily_total,
        AVG(order_total) AS daily_avg
    FROM orders
    WHERE DATE(order_date) < CURDATE()
    GROUP BY DATE(order_date)
) AS daily_stats;

-- =============================================
-- QUERY TAMBAHAN: Verifikasi data dan trigger
-- =============================================

-- Cek jumlah customers
SELECT COUNT(*) AS total_customers FROM customers;

-- Cek jumlah orders
SELECT COUNT(*) AS total_orders FROM orders;

-- Cek activity logs dari trigger
SELECT 
    table_name,
    action,
    COUNT(*) AS jumlah_log
FROM activity_logs
GROUP BY table_name, action
ORDER BY table_name, action;

-- Cek 10 log terakhir
SELECT * FROM activity_logs 
ORDER BY created_at DESC 
LIMIT 10;
