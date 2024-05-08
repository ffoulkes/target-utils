# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.15)

project(target_utils VERSION 0.1 LANGUAGES C)

set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(CMAKE_BUILD_TYPE "RelWithDebInfo")

include(ConfigureChecks)

find_package(targetsys)
if(NOT targetsys_FOUND)
  message(FATAL_ERROR "Could not find targetsys package")
endif()
message(STATUS "Found target-sys ${targetsys_VERSION}")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror=unused-parameter")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror=unused-parameter")

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
include_directories(${CMAKE_CURRENT_BINARY_DIR})

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/third-party/bigcode/include/target_utils)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/third-party/cJSON)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/third-party/klish/target_utils)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/third-party/judy-1.0.5/src)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/third-party/tommyds/tommyds)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/third-party/xxHash)


add_subdirectory(src)
add_subdirectory(third-party)

add_library(target_utils SHARED
  $<TARGET_OBJECTS:target_sysutil_o>
  $<TARGET_OBJECTS:xxhash_o>
  $<TARGET_OBJECTS:tommyds_o>
  $<TARGET_OBJECTS:JudyCommon>
  $<TARGET_OBJECTS:JudyL>
  $<TARGET_OBJECTS:Judy1>
  $<TARGET_OBJECTS:JudySL>
  $<TARGET_OBJECTS:JudyHS>
)

# When linking cjson, we want to ensure that the whole archive is added
# to the target_utils library and the symbols are forced to always be in.
# Switching the whole-archive option after linking cjson is important so
# that other archives and libraries don't start using this option
target_link_libraries(target_utils PUBLIC
  -Wl,--whole-archive
  cjson
  -Wl,--no-whole-archive
)

file(COPY include/target-utils DESTINATION ${CMAKE_INSTALL_PREFIX}/include
  PATTERN "*.doxy" EXCLUDE
  PATTERN "*.am" EXCLUDE)

