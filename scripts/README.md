# Scripts

This directory contains helper scripts related to building or running the
examples.

- `verify.sh` runs the standard local validation flow. It checks whitespace,
  builds the FetchContent preset, builds the vcpkg preset when `VCPKG_ROOT` is
  set, and can validate an installed `unilink` package with
  `--installed-prefix`.
