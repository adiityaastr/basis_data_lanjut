-- =============================================
-- UAS BASIS DATA LANJUT - SISTEM ONLINE FOOD DELIVERY
-- File: 01_create_database_simple.sql
-- Deskripsi: Script untuk membuat database dan tabel tanpa ENGINE syntax
-- 
-- Catatan:
-- - Script ini TIDAK menggunakan ENGINE syntax
-- - Migration Laravel sudah dilengkapi dengan Schema::hasTable() check
--   sehingga tidak akan bentrok jika tabel sudah ada dari import SQL ini
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
