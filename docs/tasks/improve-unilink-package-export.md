# Task: Improve unilink CMake package export dependencies

Status for `unilink` v0.7.3: completed in the core package export. The examples
repository no longer needs to call `find_package(spdlog CONFIG QUIET)` before
`find_package(unilink CONFIG REQUIRED)`.

## Context

Repository:
https://github.com/jwsung91/unilink

The standalone examples repository uses:

```cmake
find_package(unilink CONFIG REQUIRED)
target_link_libraries(example PRIVATE unilink::unilink)
```

Before the `unilink` v0.7.3 package export fix, when `unilink` was consumed
through vcpkg or an installed package, the exported
`unilink::unilink` target may reference dependency targets such as
`spdlog::spdlog`. If those targets are not created before `unilinkTargets.cmake`
is loaded, CMake generation could fail.

The examples repository used to work around this by calling:

```cmake
find_package(spdlog CONFIG QUIET)
find_package(unilink CONFIG REQUIRED)
```

That compatibility workaround belonged in the core package export instead and
has been removed from the examples repository for `unilink` v0.7.3.

## Goal

Make the installed `unilink` CMake package self-contained from a consumer's
perspective.

A consumer should be able to write only:

```cmake
find_package(unilink CONFIG REQUIRED)
target_link_libraries(my_app PRIVATE unilink::unilink)
```

and have all required transitive dependency targets available.

## Scope

Update the core `unilink` repository only.

Focus on CMake package export behavior. Do not redesign the public C++ API.

## Requirements

1. Inspect the package config template, likely under `cmake/`.
2. Ensure `unilinkConfig.cmake` includes `CMakeFindDependencyMacro`.
3. Ensure exported dependencies are resolved with `find_dependency(...)` before
   including `unilinkTargets.cmake`.
4. At minimum, handle dependencies that appear in exported link interfaces:
   `Threads`, `Boost`, and `spdlog`.
5. Preserve FetchContent/source-tree builds.
6. Preserve vcpkg package compatibility.
7. Keep dependency lookup conditional if the corresponding dependency is not
   part of the exported target for a given build configuration.

## Suggested Direction

The installed config should follow this shape:

```cmake
@PACKAGE_INIT@

include(CMakeFindDependencyMacro)

find_dependency(Threads REQUIRED)
find_dependency(Boost @UNILINK_MIN_BOOST_VERSION@ REQUIRED COMPONENTS system)
find_dependency(spdlog 1.9 CONFIG REQUIRED)

include("${CMAKE_CURRENT_LIST_DIR}/unilinkTargets.cmake")
```

Adjust exact versions and conditions to match the current core repository.

If `unilink_dependencies` is exported as a target, make sure its imported link
interface does not reference targets that have not been created.

## Validation

Validate at least these cases:

```bash
cmake -S . -B build-install \
  -DCMAKE_INSTALL_PREFIX=/tmp/unilink-prefix \
  -DUNILINK_BUILD_TESTS=OFF \
  -DUNILINK_BUILD_DOCS=OFF
cmake --build build-install
cmake --install build-install
```

Then validate a separate consumer project with only:

```cmake
find_package(unilink CONFIG REQUIRED)
target_link_libraries(consumer PRIVATE unilink::unilink)
```

Also validate through vcpkg after updating the port if needed:

```bash
cmake -S <consumer> -B build-vcpkg \
  -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake
cmake --build build-vcpkg
```

## Expected Result

Consumers no longer need to call `find_package(spdlog CONFIG QUIET)` before
`find_package(unilink CONFIG REQUIRED)`.

The examples repository can remove its compatibility workaround when validating
against `unilink` v0.7.3 or newer. The vcpkg path is also a 0.7.3 validation
path once the registry provides `jwsung91-unilink` 0.7.3.

## Final Summary Required

Report:

1. Which CMake package files changed.
2. Which dependencies are now resolved by `unilinkConfig.cmake`.
3. Which install/package consumer tests passed.
4. Whether the vcpkg port needs an update.
