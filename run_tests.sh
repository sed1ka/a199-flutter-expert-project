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
# Using flutter drive for better integration with CI environments
flutter test integration_test/app_test.dart