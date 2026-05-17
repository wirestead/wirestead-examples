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

For build-related changes, validate the supported consumption paths when
possible. The recommended entry point is:

```bash
scripts/verify.sh
```

The script always runs `git diff --check`, builds the FetchContent preset, and
builds the vcpkg preset when `VCPKG_ROOT` is set. Use a vcpkg checkout that
contains `jwsung91-unilink` 0.7.2 or newer. To include installed-package
validation, pass an installed `unilink` prefix:

```bash
scripts/verify.sh --installed-prefix /path/to/unilink/install
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
UNILINK_INSTALL_PREFIX=/path/to/unilink/install cmake --preset installed
cmake --build --preset installed --parallel
```

If a check is not applicable, note that in the pull request.
