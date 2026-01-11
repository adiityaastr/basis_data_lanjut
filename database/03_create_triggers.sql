-- =============================================
-- UAS BASIS DATA LANJUT
-- Sistem Online Food Delivery
-- File: 03_create_triggers.sql
-- Deskripsi: Script untuk membuat trigger logging CRUD
-- =============================================

USE food_ordering_db;

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

-- Verifikasi trigger yang sudah dibuat
SHOW TRIGGERS;
