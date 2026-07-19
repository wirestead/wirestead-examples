# Scripts

This directory contains helper scripts related to building or running the
examples.

- `verify.sh` runs the standard local validation flow. It checks whitespace,
  builds the FetchContent preset, requires `VCPKG_ROOT` for the vcpkg preset
  unless `--skip-vcpkg` is passed, and can validate an installed `wirestead`
  package with `--installed-prefix`.
