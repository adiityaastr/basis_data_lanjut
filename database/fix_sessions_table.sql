-- =============================================
-- Fix Sessions Table untuk Laravel
-- =============================================

USE food_ordering_db;

-- Hapus tabel sessions jika ada (untuk re-create)
DROP TABLE IF EXISTS sessions;

-- Buat tabel sessions dengan struktur yang benar untuk Laravel
CREATE TABLE sessions (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    user_id BIGINT UNSIGNED NULL,
    ip_address VARCHAR(45) NULL,
    user_agent TEXT NULL,
    payload LONGTEXT NOT NULL,
    last_activity INT NOT NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_last_activity (last_activity),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
