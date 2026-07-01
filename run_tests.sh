#!/bin/bash
set -e

MODULES=("core" "db" "about" "movie" "tv" "watchlist")

for module in "${MODULES[@]}"; do
  echo "--------------------------------------"
  echo "Running tests in: modules/$module"
  echo "--------------------------------------"
  cd "modules/$module"
  flutter pub get
  if find test -type f -name "*_test.dart" 2>/dev/null | grep -q .; then
    flutter test
  else
    echo "No unit tests found. Skipping..."
  fi
  cd ../..
done

echo "--------------------------------------"
echo "Running Integration Tests"
echo "--------------------------------------"
if find integration_test -type f -name "*_test.dart" | grep -q .; then
  for test_file in integration_test/*_test.dart; do
    echo "Running $test_file"
    flutter test "$test_file"
  done
else
  echo "No integration tests found. Skipping..."
fi