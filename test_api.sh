#!/bin/bash

echo "=========================================="
echo "TEST API - UAS Basis Data"
echo "=========================================="
echo ""

BASE_URL="http://127.0.0.1:8000"

# Test 1: Get All Customers
echo "1. Testing GET /api/customers"
response=$(curl -s -w "\n%{http_code}" "$BASE_URL/api/customers")
http_code=$(echo "$response" | tail -n1)
body=$(echo "$response" | sed '$d')
if [ "$http_code" == "200" ]; then
    count=$(echo "$body" | grep -o '"customer_id"' | wc -l)
    echo "   ✅ Status: $http_code | Customers found: $count"
else
    echo "   ❌ Status: $http_code"
fi
echo ""

# Test 2: Get Customer by ID
echo "2. Testing GET /api/customers/1"
response=$(curl -s -w "\n%{http_code}" "$BASE_URL/api/customers/1")
http_code=$(echo "$response" | tail -n1)
body=$(echo "$response" | sed '$d')
if [ "$http_code" == "200" ]; then
    echo "   ✅ Status: $http_code"
    echo "$body" | grep -o '"name":"[^"]*"' | head -1 | sed 's/"name":"/   Customer: /' | sed 's/"$//'
else
    echo "   ❌ Status: $http_code"
fi
echo ""

# Test 3: Get All Orders
echo "3. Testing GET /api/orders"
response=$(curl -s -w "\n%{http_code}" "$BASE_URL/api/orders")
http_code=$(echo "$response" | tail -n1)
body=$(echo "$response" | sed '$d')
if [ "$http_code" == "200" ]; then
    count=$(echo "$body" | grep -o '"order_id"' | wc -l)
    echo "   ✅ Status: $http_code | Orders found: $count"
else
    echo "   ❌ Status: $http_code"
fi
echo ""

# Test 4: Get Order by ID
echo "4. Testing GET /api/orders/1"
response=$(curl -s -w "\n%{http_code}" "$BASE_URL/api/orders/1")
http_code=$(echo "$response" | tail -n1)
body=$(echo "$response" | sed '$d')
if [ "$http_code" == "200" ]; then
    echo "   ✅ Status: $http_code"
    echo "$body" | grep -o '"order_total":"[^"]*"' | head -1 | sed 's/"order_total":"/   Total: /' | sed 's/"$//'
else
    echo "   ❌ Status: $http_code"
fi
echo ""

# Test 5: Query 1
echo "5. Testing GET /api/queries/1"
response=$(curl -s -w "\n%{http_code}" "$BASE_URL/api/queries/1")
http_code=$(echo "$response" | tail -n1)
body=$(echo "$response" | sed '$d')
if [ "$http_code" == "200" ]; then
    count=$(echo "$body" | grep -o '"order_id"' | wc -l)
    echo "   ✅ Status: $http_code | Results: $count"
else
    echo "   ❌ Status: $http_code"
fi
echo ""

# Test 6: Query 2
echo "6. Testing GET /api/queries/2"
response=$(curl -s -w "\n%{http_code}" "$BASE_URL/api/queries/2")
http_code=$(echo "$response" | tail -n1)
body=$(echo "$response" | sed '$d')
if [ "$http_code" == "200" ]; then
    count=$(echo "$body" | grep -o '"customer_id"' | wc -l)
    echo "   ✅ Status: $http_code | Customers without orders: $count"
else
    echo "   ❌ Status: $http_code"
fi
echo ""

# Test 7: Query 3
echo "7. Testing GET /api/queries/3"
response=$(curl -s -w "\n%{http_code}" "$BASE_URL/api/queries/3")
http_code=$(echo "$response" | tail -n1)
if [ "$http_code" == "200" ]; then
    echo "   ✅ Status: $http_code"
else
    echo "   ❌ Status: $http_code"
fi
echo ""

# Test 8: Query 4
echo "8. Testing GET /api/queries/4"
response=$(curl -s -w "\n%{http_code}" "$BASE_URL/api/queries/4")
http_code=$(echo "$response" | tail -n1)
if [ "$http_code" == "200" ]; then
    echo "   ✅ Status: $http_code"
else
    echo "   ❌ Status: $http_code"
fi
echo ""

# Test 9: Query 5
echo "9. Testing GET /api/queries/5"
response=$(curl -s -w "\n%{http_code}" "$BASE_URL/api/queries/5")
http_code=$(echo "$response" | tail -n1)
if [ "$http_code" == "200" ]; then
    echo "   ✅ Status: $http_code"
else
    echo "   ❌ Status: $http_code"
fi
echo ""

echo "=========================================="
echo "TEST SELESAI"
echo "=========================================="
