#!/bin/bash
set -e

# Create a temporary database for this test
DB=$(mktemp)

echo "Recreating database..."
rm -f "$DB"
sqlite3 "$DB" < sql/schema/schema.sql

echo "Adding temp data..."
sqlite3 "$DB" ".mode csv" ".import tests/seeds/raw_person_names.csv raw_person_names"
sqlite3 "$DB" ".mode csv" ".import tests/seeds/raw_person_surnames.csv raw_person_surnames"

echo "Inserting standard data..."
for t in sql/seed/*.sql; do
    echo "----------------------------------------"
    echo "Running $t"
    sqlite3 "$DB" < "$t" 2>&1 || {
        echo "Error running $t"
        exit 1
    }
done

echo "Inserting test data..."
for t in tests/seeds/*.sql; do
    if [ -f "$t" ]; then
        echo "----------------------------------------"
        echo "Running $t"
        sqlite3 "$DB" < "$t" 2>&1 || {
            echo "Error running $t"
            exit 1
        }
    fi
done

echo "Running test cases..."
for t in tests/cases/*.sql; do
    if [ -f "$t" ]; then
        echo "----------------------------------------"
        echo "Running $t"
        sqlite3 "$DB" < "$t" 2>&1 || {
            echo "Error running $t"
            exit 1
        }
    fi
done

echo "All tests executed successfully."