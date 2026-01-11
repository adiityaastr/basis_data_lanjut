# API Testing Guide

File-file JSON untuk testing API menggunakan Postman atau Insomnia.

## File yang Tersedia

1. **postman_collection.json** - Collection untuk Postman
2. **insomnia_collection.json** - Collection untuk Insomnia

## Cara Import

### Postman
1. Buka Postman
2. Klik **Import** di pojok kiri atas
3. Pilih file `postman_collection.json`
4. Collection akan muncul di sidebar

### Insomnia
1. Buka Insomnia
2. Klik **Create** > **Import From** > **File**
3. Pilih file `insomnia_collection.json`
4. Collection akan muncul di sidebar

## Konfigurasi Base URL

### Postman
- Variable `base_url` sudah diset ke `http://127.0.0.1:8000`
- Bisa diubah di tab **Variables** pada collection

### Insomnia
- Environment variable `base_url` sudah diset ke `http://127.0.0.1:8000`
- Bisa diubah di **Manage Environments**

## Endpoint yang Tersedia

### Customers
- `GET /api/customers` - Get all customers
- `GET /api/customers/{id}` - Get customer by ID
- `POST /api/customers` - Create customer
- `PUT /api/customers/{id}` - Update customer
- `DELETE /api/customers/{id}` - Delete customer

### Orders
- `GET /api/orders` - Get all orders
- `GET /api/orders/{id}` - Get order by ID
- `POST /api/orders` - Create order
- `PUT /api/orders/{id}` - Update order
- `DELETE /api/orders/{id}` - Delete order

### Query Tests (UAS)
- `GET /api/queries/1` - Daftar pesanan lengkap (urutkan terbaru)
- `GET /api/queries/2` - Pelanggan yang belum pernah membuat pesanan
- `GET /api/queries/3` - Jumlah pesanan per hari dalam 7 hari terakhir
- `GET /api/queries/4` - Order terbesar untuk setiap pelanggan
- `GET /api/queries/5` - Rata-rata total order harian dan perbandingan dengan hari ini
- `GET /api/queries/all` - Semua query sekaligus

## Contoh Request Body

### Create Customer
```json
{
    "name": "John Doe",
    "phone": "081234567890",
    "email": "john.doe@email.com"
}
```

### Create Order
```json
{
    "customer_id": 1,
    "order_date": "2024-01-15 10:00:00",
    "order_total": 50000.00,
    "status": "pending"
}
```

### Update Order
```json
{
    "customer_id": 1,
    "order_date": "2024-01-15 10:00:00",
    "order_total": 75000.00,
    "status": "paid"
}
```

## Status Code

- `200` - Success
- `201` - Created
- `404` - Not Found
- `422` - Validation Error

## Response Format

### Success Response
```json
{
    "success": true,
    "data": { ... },
    "message": "Optional message"
}
```

### Error Response
```json
{
    "success": false,
    "message": "Error message",
    "errors": {
        "field": ["Error message"]
    }
}
```
