# Contributing

This repository contains standalone examples for Wirestead. Keep changes scoped
to example code, example build integration, and documentation that helps users
build or run the examples.

## Formatting

The repository follows the same formatting configuration as the core Wirestead
repository:

- C++ files use `.clang-format`.
- CMake files use `.cmake-format.py`.

Run the formatting workflow locally when changing C++ or CMake files, or verify
that CI formatting checks pass on the pull request.

## Validation

For build-related changes, validate the supported consumption paths when
possible. The recommended entry point is:

```bash
scripts/verify.sh
```

The script always runs `git diff --check`, builds the FetchContent preset, and
builds the vcpkg preset. Until the official registry includes `wirestead`, set
`VCPKG_ROOT` to a vcpkg checkout or overlay that contains the new port, or pass
`--skip-vcpkg` if that path is not applicable. To include installed-package
validation, pass an installed Wirestead prefix:

```bash
scripts/verify.sh --installed-prefix /path/to/wirestead/install
```

Equivalent manual commands are:

```bash
cmake --preset fetchcontent
cmake --build --preset fetchcontent --parallel
```

```bash
cmake --preset vcpkg
cmake --build --preset vcpkg --parallel
```

```bash
WIRESTEAD_INSTALL_PREFIX=/path/to/wirestead/install cmake --preset installed
cmake --build --preset installed --parallel
```

If a check is not applicable, note that in the pull request.
