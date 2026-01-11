-- =============================================
-- UAS BASIS DATA LANJUT
-- Sistem Online Food Delivery
-- File: 00_complete_setup.sql
-- Deskripsi: Script lengkap untuk setup database
-- Cara penggunaan:
--   mysql -u root -p < 00_complete_setup.sql
-- =============================================

-- Source semua file SQL secara berurutan
-- Atau jalankan manual:
-- 1. mysql -u root -p < 01_create_database.sql
-- 2. mysql -u root -p < 02_insert_sample_data.sql
-- 3. mysql -u root -p < 03_create_triggers.sql
-- 4. mysql -u root -p < 04_test_queries.sql

-- Atau jalankan semua dalam satu file ini:

SOURCE 01_create_database.sql;
SOURCE 02_insert_sample_data.sql;
SOURCE 03_create_triggers.sql;

-- Setelah setup selesai, jalankan query test secara manual:
-- mysql -u root -p food_ordering_db < 04_test_queries.sql
