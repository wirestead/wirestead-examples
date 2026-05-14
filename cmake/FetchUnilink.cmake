include(FetchContent)

set(UNILINK_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(UNILINK_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(UNILINK_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(BUILD_PYTHON_BINDINGS OFF CACHE BOOL "" FORCE)

FetchContent_Declare(
  unilink
  GIT_REPOSITORY https://github.com/jwsung91/unilink.git
  GIT_TAG main # TODO: replace with a stable release tag
)

FetchContent_MakeAvailable(unilink)
