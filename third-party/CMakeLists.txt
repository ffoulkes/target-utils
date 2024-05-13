# third-party

# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

INCLUDE(ExternalProject)
INCLUDE(ProcessorCount)

ProcessorCount(N)

set(C_FLAGS " -O2 -fPIC")
if (FORCE32)
  set(C_FLAGS "${C_FLAGS} -m32")
endif()

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/bigcode/include/target_utils)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/klish/target_utils)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/xxHash/)

add_subdirectory(bigcode)
add_subdirectory(klish)
add_library(xxhash_o OBJECT xxHash/xxhash.c)
add_library(xxhash SHARED EXCLUDE_FROM_ALL $<TARGET_OBJECTS:xxhash_o>)

# required for standalone builds for other packages
file(COPY klish/target-utils/ DESTINATION
  ${CMAKE_INSTALL_PREFIX}/include/target-utils)

file(COPY xxHash DESTINATION
  ${CMAKE_INSTALL_PREFIX}/include/target-utils/third-party/xxHash/
  FILES_MATCHING PATTERN *.h)

if(ASAN)
  set(C_FLAGS "${C_FLAGS} -fsanitize=address -fsanitize-recover=address -fsanitize=leak")
endif()
