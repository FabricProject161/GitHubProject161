#!/bin/bash
set -e

# Create a temporary database for this test
DB=$(mktemp)

echo "Recreating database..."
rm -f "$DB"

run_sql() {
    local file="$1"
    echo "----------------------------------------"
    echo "Running $file"
    # Each sqlite3 process starts with foreign keys disabled. The schema
    # declares them, so turn them on for every script.
    sqlite3 "$DB" "PRAGMA foreign_keys = ON" ".read $file" || {
        echo "Error running $file"
        exit 1
    }
}

run_sql sql/schema/schema.sql

echo "Adding temp data..."
sqlite3 "$DB" ".mode csv" ".import tests/seeds/raw_person_names.csv raw_person_names"
sqlite3 "$DB" ".mode csv" ".import tests/seeds/raw_person_surnames.csv raw_person_surnames"

echo "Inserting standard data..."
# Translations reference dictionary_languages, which this file fills.
run_sql sql/seed/languages.sql
for t in sql/seed/*.sql; do
    if [ "$(basename "$t")" = "languages.sql" ]; then
        continue
    fi
    run_sql "$t"
done

echo "Inserting test data..."
# people and clubs have to exist before memberships, contacts, and sections.
# Alphabetical order would run members.sql and contact_types.sql first.
for t in \
    tests/seeds/people.sql \
    tests/seeds/clubs.sql \
    tests/seeds/members.sql \
    tests/seeds/contact_types.sql \
    tests/seeds/sections.sql
do
    run_sql "$t"
done

echo "Running test cases..."
for t in tests/cases/*.sql; do
    if [ -f "$t" ]; then
        run_sql "$t"
    fi
done

echo "All tests executed successfully."
