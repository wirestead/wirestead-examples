# Contributing

This repository contains standalone examples for `unilink`. Keep changes scoped
to example code, example build integration, and documentation that helps users
build or run the examples.

## Formatting

The repository follows the same formatting configuration as the core `unilink`
repository:

- C++ files use `.clang-format`.
- CMake files use `.cmake-format.py`.

Run the formatting workflow locally when changing C++ or CMake files, or verify
that CI formatting checks pass on the pull request.

## Validation

For build-related changes, validate both supported consumption paths when
possible:

```bash
cmake -S . -B build -DUNILINK_EXAMPLES_USE_FETCHCONTENT=ON
cmake --build build --parallel
```

```bash
cmake -S . -B build-vcpkg \
  -DUNILINK_EXAMPLES_USE_FETCHCONTENT=OFF \
  -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake
cmake --build build-vcpkg --parallel
```

Also run:

```bash
git diff --check
```

If a check is not applicable, note that in the pull request.
