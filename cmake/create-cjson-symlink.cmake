# Copyright 2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

# Creates a symlink to the new location of the cJSON header file,
# for compatibility with source files that use the old path:
#    #include "target-utils/third-party/cJSON/cJSON.h"
#
execute_process(
  COMMAND
    ${CMAKE_COMMAND} -E create_symlink
    ${CMAKE_INSTALL_PREFIX}/include/cjson
    ${CMAKE_INSTALL_PREFIX}/include/target-utils/third-party/cJSON
)

