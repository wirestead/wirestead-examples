include(FetchContent)

set(UNILINK_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(UNILINK_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(UNILINK_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(UNILINK_ENABLE_INSTALL OFF CACHE BOOL "" FORCE)
set(BUILD_PYTHON_BINDINGS OFF CACHE BOOL "" FORCE)

FetchContent_Declare(
  unilink
  GIT_REPOSITORY https://github.com/jwsung91/unilink.git
  GIT_TAG v0.7.1
)

FetchContent_MakeAvailable(unilink)
