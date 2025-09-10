#!/usr/bin/env bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

echo "Entered script dir: $SCRIPT_DIR"
./clean.sh

mkdir -p build && cd build
# Run cmake
cmake ..

# Build with CMake doing the parallel detection
cmake --build . --parallel
echo "Build complete"
