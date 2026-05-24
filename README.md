# unilink-examples

[![CMake](https://github.com/unilink-lab/unilink-examples/actions/workflows/cmake.yml/badge.svg)](https://github.com/unilink-lab/unilink-examples/actions/workflows/cmake.yml)

Practical examples for using `unilink` in real-world C++ communication
scenarios.

This repository demonstrates how to build TCP, UDP, Serial, and Unix Domain
Socket applications using `unilink`'s unified async communication interface.

## What is unilink?

`unilink` is a modern C++ communication library that provides a unified
interface for serial, network, and local IPC transports.

Core library:
https://github.com/jwsung91/unilink

## Examples

| Category | Mode | Description |
|---|---|---|
| [TCP](examples/tcp/) | sync / async | Basic TCP client/server communication |
| [UDP](examples/udp/) | sync / async | Datagram-based communication |
| [UDS](examples/uds/) | sync / async | Unix Domain Socket local IPC |
| [Serial](examples/serial/) | sync / async | Serial communication examples |

Example sources live under `examples/` and preserve the transport-focused
layout from the core repository.

## Build

### Option 1: Build without installing unilink

This is the quickest path for trying the examples. CMake fetches `unilink`
v0.7.5 as configured in `cmake/FetchUnilink.cmake`.

```bash
cmake --preset fetchcontent
cmake --build --preset fetchcontent
```

This mode requires network access during the first configure step.

### Option 2: Use vcpkg

Use this when you want `unilink` and its dependencies managed by vcpkg. The
vcpkg package is named `jwsung91-unilink` and exports the CMake package
`unilink`.

```bash
cmake --preset vcpkg
cmake --build --preset vcpkg
```

Set `VCPKG_ROOT` to your vcpkg checkout path before running this command.
Use a vcpkg checkout that contains `jwsung91-unilink` 0.7.2 or newer. The
official `microsoft/vcpkg` registry includes `jwsung91-unilink` 0.7.2.

```bash
git clone https://github.com/microsoft/vcpkg "$VCPKG_ROOT"
"$VCPKG_ROOT/bootstrap-vcpkg.sh"
```

### Option 3: Use a local unilink source checkout

Use this when you already have the core repository locally and want to avoid
downloading it again.

```bash
cmake --preset fetchcontent \
  -DFETCHCONTENT_SOURCE_DIR_UNILINK=/path/to/unilink
cmake --build --preset fetchcontent
```

### Option 4: Use an installed unilink package

```bash
UNILINK_INSTALL_PREFIX=/path/to/unilink/install cmake --preset installed
cmake --build --preset installed
```

Installed-package mode assumes `unilink` and its exported dependencies are
discoverable by CMake, typically via `CMAKE_PREFIX_PATH` or a system install
location. `unilink` v0.7.5 resolves its exported dependencies from
`unilinkConfig.cmake`, so consumers do not need to call `find_package(spdlog)`
before `find_package(unilink CONFIG REQUIRED)`.

## Run

Binaries are generated under the selected preset's build directory:

```text
build/<preset>/bin
```

Examples:

```bash
./build/fetchcontent/bin/sync_tcp_echo_server
./build/fetchcontent/bin/sync_tcp_echo_client
./build/fetchcontent/bin/async_udp_receiver
./build/fetchcontent/bin/sync_uds_echo_server
./build/fetchcontent/bin/sync_serial_echo
```

See [examples/README.md](examples/README.md) for the full binary list and
transport-specific run commands.

## Notes

- TCP and UDP examples can usually be run locally.
- UDS examples are supported on Unix-like platforms.
- Serial examples may require an available serial device or loopback setup.

## Tested With

- CMake 3.28
- GCC 13
- `unilink` v0.7.5
- vcpkg package `jwsung91-unilink` 0.7.2
- Installed-package mode with a local `unilink` v0.7.5 install prefix

## Repository Layout

```text
.
├── CMakeLists.txt
├── CMakePresets.json
├── CONTRIBUTING.md
├── cmake/
│   └── FetchUnilink.cmake
├── examples/
│   ├── README.md
│   ├── tcp/
│   ├── udp/
│   ├── uds/
│   └── serial/
├── scripts/
└── vcpkg.json
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for formatting and validation guidance.

## License

Apache-2.0
