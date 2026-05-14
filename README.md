# unilink-examples

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
| TCP | sync / async | Basic TCP client/server communication |
| UDP | sync / async | Datagram-based communication |
| UDS | sync / async | Unix Domain Socket local IPC |
| Serial | sync / async | Serial communication examples |

Example sources live under `examples/` and preserve the transport-focused
layout from the core repository.

## Build

### Option 1: Fetch unilink automatically

```bash
cmake -S . -B build -DUNILINK_EXAMPLES_USE_FETCHCONTENT=ON
cmake --build build
```

### Option 2: Use installed unilink package

```bash
cmake -S . -B build-installed -DUNILINK_EXAMPLES_USE_FETCHCONTENT=OFF
cmake --build build-installed
```

Installed-package mode assumes `unilink` and its exported dependencies are
discoverable by CMake, typically via `CMAKE_PREFIX_PATH` or a system install
location.

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

## Notes

- TCP and UDP examples can usually be run locally.
- UDS examples are supported on Unix-like platforms.
- Serial examples may require an available serial device or loopback setup.

## Repository Layout

```text
.
├── CMakeLists.txt
├── cmake/
│   └── FetchUnilink.cmake
├── examples/
│   ├── tcp/
│   ├── udp/
│   ├── uds/
│   └── serial/
└── scripts/
```

## License

Apache-2.0
