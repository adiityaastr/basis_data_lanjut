# Dokumentasi API - Sistem Online Food Delivery

## Base URL
```
http://localhost:8000/api
```

## Endpoints API

### 1. Customer Endpoints

#### 1.1. Get All Customers
**GET** `/api/customers`

**Response:**
```json
{
    "success": true,
    "data": [
        {
            "customer_id": 1,
            "name": "John Doe",
            "phone": "081234567890",
            "email": "john@example.com",
            "created_at": "2025-01-10T10:00:00.000000Z"
        }
    ]
}
```

#### 1.2. Get Customer by ID
**GET** `/api/customers/{id}`

**Parameters:**
- `id` (path parameter) - ID customer

**Response:**
```json
{
    "success": true,
    "data": {
        "customer_id": 1,
        "name": "John Doe",
        "phone": "081234567890",
        "email": "john@example.com",
        "created_at": "2025-01-10T10:00:00.000000Z"
    }
}
```

#### 1.3. Create Customer
**POST** `/api/customers`

**Request Body:**
```json
{
    "name": "John Doe",
    "phone": "081234567890",
    "email": "john@example.com"
}
```

**Response:**
```json
{
    "success": true,
    "message": "Customer berhasil dibuat",
    "data": {
        "customer_id": 1,
        "name": "John Doe",
        "phone": "081234567890",
        "email": "john@example.com",
        "created_at": "2025-01-10T10:00:00.000000Z"
    }
}
```

#### 1.4. Update Customer
**PUT** `/api/customers/{id}`

**Parameters:**
- `id` (path parameter) - ID customer

**Request Body:**
```json
{
    "name": "John Doe Updated",
    "phone": "081234567891",
    "email": "john.updated@example.com"
}
```

**Response:**
```json
{
    "success": true,
    "message": "Customer berhasil diupdate",
    "data": {
        "customer_id": 1,
        "name": "John Doe Updated",
        "phone": "081234567891",
        "email": "john.updated@example.com",
        "created_at": "2025-01-10T10:00:00.000000Z"
    }
}
```

#### 1.5. Delete Customer
**DELETE** `/api/customers/{id}`

**Parameters:**
- `id` (path parameter) - ID customer

**Response:**
```json
{
    "success": true,
    "message": "Customer berhasil dihapus"
}
```

---

### 2. Order Endpoints

#### 2.1. Get All Orders
**GET** `/api/orders`

**Response:**
```json
{
    "success": true,
    "data": [
        {
            "order_id": 1,
            "customer_id": 1,
            "order_date": "2025-01-10T12:00:00.000000Z",
            "order_total": "150000.00",
            "status": "pending",
            "customer": {
                "customer_id": 1,
                "name": "John Doe",
                "phone": "081234567890",
                "email": "john@example.com"
            }
        }
    ]
}
```

#### 2.2. Get Order by ID
**GET** `/api/orders/{id}`

**Parameters:**
- `id` (path parameter) - ID order

**Response:**
```json
{
    "success": true,
    "data": {
        "order_id": 1,
        "customer_id": 1,
        "order_date": "2025-01-10T12:00:00.000000Z",
        "order_total": "150000.00",
        "status": "pending",
        "customer": {
            "customer_id": 1,
            "name": "John Doe",
            "phone": "081234567890",
            "email": "john@example.com"
        }
    }
}
```

#### 2.3. Create Order
**POST** `/api/orders`

**Request Body:**
```json
{
    "customer_id": 1,
    "order_date": "2025-01-10 12:00:00",
    "order_total": 150000.00,
    "status": "pending"
}
```

**Note:** Status bersifat optional, default: "pending"
**Status yang valid:** pending, paid, canceled, delivered

**Response:**
```json
{
    "success": true,
    "message": "Order berhasil dibuat",
    "data": {
        "order_id": 1,
        "customer_id": 1,
        "order_date": "2025-01-10T12:00:00.000000Z",
        "order_total": "150000.00",
        "status": "pending",
        "customer": {
            "customer_id": 1,
            "name": "John Doe",
            "phone": "081234567890",
            "email": "john@example.com"
        }
    }
}
```

#### 2.4. Update Order
**PUT** `/api/orders/{id}`

**Parameters:**
- `id` (path parameter) - ID order

**Request Body:**
```json
{
    "customer_id": 1,
    "order_date": "2025-01-10 12:00:00",
    "order_total": 200000.00,
    "status": "paid"
}
```

**Response:**
```json
{
    "success": true,
    "message": "Order berhasil diupdate",
    "data": {
        "order_id": 1,
        "customer_id": 1,
        "order_date": "2025-01-10T12:00:00.000000Z",
        "order_total": "200000.00",
        "status": "paid",
        "customer": {
            "customer_id": 1,
            "name": "John Doe",
            "phone": "081234567890",
            "email": "john@example.com"
        }
    }
}
```

#### 2.5. Delete Order
**DELETE** `/api/orders/{id}`

**Parameters:**
- `id` (path parameter) - ID order

**Response:**
```json
{
    "success": true,
    "message": "Order berhasil dihapus"
}
```

---

## Error Responses

### Validation Error (422)
```json
{
    "success": false,
    "errors": {
        "name": ["The name field is required."],
        "phone": ["The phone has already been taken."]
    }
}
```

### Not Found Error (404)
```json
{
    "success": false,
    "message": "Customer tidak ditemukan"
}
```

---

## Testing dengan Postman

### Collection untuk Postman

1. **Setup Environment Variable:**
   - Variable: `base_url`
   - Value: `http://localhost:8000`

2. **Import Collection:**
   Buat collection baru dengan nama "Food Ordering API" dan tambahkan request berikut:

   **Customer Requests:**
   - GET `{{base_url}}/api/customers`
   - GET `{{base_url}}/api/customers/1`
   - POST `{{base_url}}/api/customers`
   - PUT `{{base_url}}/api/customers/1`
   - DELETE `{{base_url}}/api/customers/1`

   **Order Requests:**
   - GET `{{base_url}}/api/orders`
   - GET `{{base_url}}/api/orders/1`
   - POST `{{base_url}}/api/orders`
   - PUT `{{base_url}}/api/orders/1`
   - DELETE `{{base_url}}/api/orders/1`

3. **Testing Steps:**
   - Pastikan server Laravel berjalan: `php artisan serve`
   - Pastikan database sudah di-migrate dan di-seed
   - Test setiap endpoint dengan Postman
   - Screenshot hasil testing untuk dokumentasi

---

## Catatan Penting

1. Semua endpoint mengembalikan response dalam format JSON
2. Semua endpoint menggunakan prefix `/api`
3. Validasi dilakukan pada setiap request
4. Trigger akan otomatis mencatat semua operasi CRUD ke tabel `activity_logs`
5. Untuk testing trigger, pastikan trigger sudah dijalankan di database MySQL
