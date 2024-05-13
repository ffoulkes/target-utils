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

add_subdirectory(bigcode)
add_subdirectory(klish)

# required for standalone builds for other packages
file(COPY klish/target-utils/ DESTINATION
  ${CMAKE_INSTALL_PREFIX}/include/target-utils)

if(ASAN)
  set(C_FLAGS "${C_FLAGS} -fsanitize=address -fsanitize-recover=address -fsanitize=leak")
endif()
