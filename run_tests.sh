#!/bin/bash
set -e

MODULES=("core" "db" "about" "movie" "tv" "watchlist")

for module in "${MODULES[@]}"; do
  echo "--------------------------------------"
  echo "Running tests in: modules/$module"
  echo "--------------------------------------"
  cd "modules/$module"
  flutter pub get
  flutter test
  cd ../..
done

echo "--------------------------------------"
echo "Running Integration Tests"
echo "--------------------------------------"
# Using flutter drive for better integration with CI environments
flutter test integration_test/app_test.dart