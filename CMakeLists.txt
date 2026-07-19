cmake_minimum_required(VERSION 3.12)

project(wirestead_examples LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(DEFINED UNILINK_EXAMPLES_USE_FETCHCONTENT
   AND NOT DEFINED WIRESTEAD_EXAMPLES_USE_FETCHCONTENT
)
  set(WIRESTEAD_EXAMPLES_USE_FETCHCONTENT
      "${UNILINK_EXAMPLES_USE_FETCHCONTENT}"
      CACHE BOOL "Fetch Wirestead using FetchContent" FORCE
  )
endif()

option(WIRESTEAD_EXAMPLES_USE_FETCHCONTENT "Fetch Wirestead using FetchContent"
       ON
)

if(DEFINED UNILINK_EXAMPLES_USE_FETCHCONTENT
   AND NOT "${WIRESTEAD_EXAMPLES_USE_FETCHCONTENT}" STREQUAL
       "${UNILINK_EXAMPLES_USE_FETCHCONTENT}"
)
  message(
    FATAL_ERROR
      "WIRESTEAD_EXAMPLES_USE_FETCHCONTENT and UNILINK_EXAMPLES_USE_FETCHCONTENT disagree"
  )
endif()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

if(WIRESTEAD_EXAMPLES_USE_FETCHCONTENT)
  include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/FetchWirestead.cmake)
else()
  find_package(wirestead CONFIG QUIET)
  if(NOT wirestead_FOUND)
    find_package(unilink CONFIG REQUIRED)
    if(TARGET unilink::unilink AND NOT TARGET wirestead::wirestead)
      add_library(wirestead::wirestead INTERFACE IMPORTED)
      target_link_libraries(wirestead::wirestead INTERFACE unilink::unilink)
    endif()
  endif()
endif()

# The core repository defines this helper when built from source. Provide a
# local fallback so the migrated example CMake remains reusable in package mode.
if(NOT COMMAND wirestead_configure_executable)
  function(wirestead_configure_executable target)
    # Package-mode fallback: no extra per-target setup is required here.
  endfunction()
endif()

add_subdirectory(examples)
