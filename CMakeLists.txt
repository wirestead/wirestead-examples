cmake_minimum_required(VERSION 3.12)

project(unilink_examples LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(UNILINK_EXAMPLES_USE_FETCHCONTENT "Fetch unilink using FetchContent" ON)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

if(UNILINK_EXAMPLES_USE_FETCHCONTENT)
  include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/FetchUnilink.cmake)
else()
  find_package(spdlog CONFIG QUIET)
  find_package(unilink CONFIG REQUIRED)
endif()

# The core repository defines this helper when built from source. Provide a
# local fallback so the migrated example CMake remains reusable in package mode.
if(NOT COMMAND unilink_configure_executable)
  function(unilink_configure_executable target)
    # Package-mode fallback: no extra per-target setup is required here.
  endfunction()
endif()

add_subdirectory(examples)
