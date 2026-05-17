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
v0.7.3 as configured in `cmake/FetchUnilink.cmake`.

```bash
cmake -S . -B build
cmake --build build
```

This mode requires network access during the first configure step.

### Option 2: Use vcpkg

Use this when you want `unilink` and its dependencies managed by vcpkg. The
vcpkg package is named `jwsung91-unilink` and exports the CMake package
`unilink`.

```bash
cmake -S . -B build-vcpkg \
  -DUNILINK_EXAMPLES_USE_FETCHCONTENT=OFF \
  -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake
cmake --build build-vcpkg
```

Set `VCPKG_ROOT` to your vcpkg checkout path before running this command.
If you do not have vcpkg yet, clone https://github.com/microsoft/vcpkg and run
`bootstrap-vcpkg.sh`.

### Option 3: Use a local unilink source checkout

Use this when you already have the core repository locally and want to avoid
downloading it again.

```bash
cmake -S . -B build \
  -DUNILINK_EXAMPLES_USE_FETCHCONTENT=ON \
  -DFETCHCONTENT_SOURCE_DIR_UNILINK=/path/to/unilink
cmake --build build
```

### Option 4: Use an installed unilink package

```bash
cmake -S . -B build-installed \
  -DUNILINK_EXAMPLES_USE_FETCHCONTENT=OFF \
  -DCMAKE_PREFIX_PATH=/path/to/unilink/install
cmake --build build-installed
```

Installed-package mode assumes `unilink` and its exported dependencies are
discoverable by CMake, typically via `CMAKE_PREFIX_PATH` or a system install
location. `unilink` v0.7.3 resolves its exported dependencies from
`unilinkConfig.cmake`, so consumers do not need to call `find_package(spdlog)`
before `find_package(unilink CONFIG REQUIRED)`.

## Run

Binaries are generated under:

```text
build/bin
```

Examples:

```bash
./build/bin/sync_tcp_echo_server
./build/bin/sync_tcp_echo_client
./build/bin/async_udp_receiver
./build/bin/sync_uds_echo_server
./build/bin/sync_serial_echo
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
- `unilink` v0.7.3
- vcpkg package `jwsung91-unilink` 0.7.3
- Installed-package mode with a local `unilink` v0.7.3 install prefix

## Repository Layout

```text
.
├── CMakeLists.txt
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
