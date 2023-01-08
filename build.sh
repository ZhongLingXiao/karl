# cleanup
rm -rf build generated

# cmake config
cmake -B build

# cmake build
cmake --build build --config release --parallel
