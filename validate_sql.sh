#!/bin/bash

SQL_FILE="database/COMPLETE_UAS_SQL_SIMPLE.sql"

echo "=========================================="
echo "VALIDASI SQL SYNTAX"
echo "=========================================="
echo ""

# Check 1: DELIMITER pairs
echo "1. Checking DELIMITER pairs..."
delimiter_start=$(grep -c "DELIMITER \$\$" "$SQL_FILE")
delimiter_end=$(grep -c "DELIMITER ;" "$SQL_FILE")
if [ "$delimiter_start" -eq "$delimiter_end" ]; then
    echo "   ✅ DELIMITER pairs: $delimiter_start pairs (balanced)"
else
    echo "   ❌ DELIMITER mismatch: $delimiter_start starts, $delimiter_end ends"
fi
echo ""

# Check 2: CREATE TABLE statements
echo "2. Checking CREATE TABLE statements..."
table_count=$(grep -c "^CREATE TABLE" "$SQL_FILE")
echo "   ✅ CREATE TABLE statements: $table_count"
echo ""

# Check 3: CREATE PROCEDURE
echo "3. Checking CREATE PROCEDURE..."
if grep -q "CREATE PROCEDURE generate_orders" "$SQL_FILE" && grep -q "END\$\$" "$SQL_FILE"; then
    echo "   ✅ CREATE PROCEDURE: Found and properly closed"
else
    echo "   ❌ CREATE PROCEDURE: Missing or not properly closed"
fi
echo ""

# Check 4: CREATE TRIGGER
echo "4. Checking CREATE TRIGGER..."
trigger_count=$(grep -c "^CREATE TRIGGER" "$SQL_FILE")
if [ "$trigger_count" -eq 6 ]; then
    echo "   ✅ CREATE TRIGGER: $trigger_count triggers found (expected 6)"
else
    echo "   ⚠️  CREATE TRIGGER: $trigger_count triggers found (expected 6)"
fi
echo ""

# Check 5: INSERT statements
echo "5. Checking INSERT statements..."
insert_count=$(grep -c "^INSERT INTO" "$SQL_FILE")
echo "   ✅ INSERT statements: $insert_count"
echo ""

# Check 6: SELECT statements (queries)
echo "6. Checking SELECT statements..."
select_count=$(grep -c "^SELECT" "$SQL_FILE")
echo "   ✅ SELECT statements: $select_count"
echo ""

# Check 7: Parentheses balance
echo "7. Checking parentheses balance..."
open_paren=$(grep -o "(" "$SQL_FILE" | wc -l)
close_paren=$(grep -o ")" "$SQL_FILE" | wc -l)
if [ "$open_paren" -eq "$close_paren" ]; then
    echo "   ✅ Parentheses: Balanced ($open_paren open, $close_paren close)"
else
    echo "   ❌ Parentheses: Unbalanced ($open_paren open, $close_paren close)"
fi
echo ""

# Check 8: Semicolons
echo "8. Checking semicolons..."
semicolon_count=$(grep -o ";" "$SQL_FILE" | wc -l)
echo "   ✅ Semicolons: $semicolon_count found"
echo ""

# Check 9: Common syntax errors
echo "9. Checking for common syntax errors..."
errors=0

# Check for double semicolons
if grep -q ";;" "$SQL_FILE"; then
    echo "   ⚠️  Found double semicolons"
    errors=$((errors+1))
fi

# Check for missing semicolons after CREATE TABLE
if ! grep -q "CREATE TABLE customers.*);" "$SQL_FILE" && ! grep -A 10 "CREATE TABLE customers" "$SQL_FILE" | grep -q ");"; then
    echo "   ⚠️  Check CREATE TABLE customers semicolon"
    errors=$((errors+1))
fi

if [ $errors -eq 0 ]; then
    echo "   ✅ No common syntax errors found"
fi
echo ""

# Check 10: Keywords
echo "10. Checking SQL keywords..."
keywords=("CREATE" "INSERT" "SELECT" "UPDATE" "DELETE" "DROP" "ALTER" "TRIGGER" "PROCEDURE")
for keyword in "${keywords[@]}"; do
    count=$(grep -c "$keyword" "$SQL_FILE" 2>/dev/null || echo "0")
    if [ "$count" -gt 0 ]; then
        echo "   - $keyword: Found"
    fi
done
echo ""

echo "=========================================="
echo "VALIDASI SELESAI"
echo "=========================================="
