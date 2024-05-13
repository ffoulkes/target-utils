# Copyright 2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0
#
# Creates symbolic links to the new locations of header files, for
# compatibility with source files that have not been updated to use
# the new paths.
#

option(RELATIVE_PATH "Use relative path in symlink" ON)

set(INCLUDE_PREFIX ${CMAKE_INSTALL_PREFIX}/include)
set(TARGET_UTILS_PREFIX ${INCLUDE_PREFIX}/target-utils)

#-----------------------------------------------------------------------
# target-utils/third-party/cJSON -> cjson
#-----------------------------------------------------------------------
set(OLD_FOLDER ${TARGET_UTILS_PREFIX}/third-party)

if(RELATIVE_PATH)
  set(NEW_FOLDER ../..)
else()
  set(NEW_FOLDER ${INCLUDE_PREFIX})
endif()

file(MAKE_DIRECTORY ${OLD_FOLDER})

file(CREATE_LINK ${NEW_FOLDER}/cjson ${OLD_FOLDER}/cJSON SYMBOLIC)

#-----------------------------------------------------------------------
# target-utils/third-party/judy-1.0.5/src/Judy.h -> target-utils/judy/Judy.h
#-----------------------------------------------------------------------
set(OLD_FOLDER ${TARGET_UTILS_PREFIX}/third-party/judy-1.0.5/src)

if(RELATIVE_PATH)
  set(NEW_FOLDER ../../../judy)
else()
  set(NEW_FOLDER ${TARGET_UTILS_PREFIX}/judy)
endif()

file(MAKE_DIRECTORY ${OLD_FOLDER})

file(CREATE_LINK ${NEW_FOLDER}/Judy.h ${OLD_FOLDER}/Judy.h SYMBOLIC)

#-----------------------------------------------------------------------
# target-utils/third-party/tommyds/tommyds -> tommyds/tommyds
#-----------------------------------------------------------------------
set(OLD_FOLDER ${TARGET_UTILS_PREFIX}/third-party/tommyds)

if(RELATIVE_PATH)
  set(NEW_FOLDER ../..)
else()
  set(NEW_FOLDER ${INCLUDE_PREFIX})
endif()

file(MAKE_DIRECTORY ${OLD_FOLDER})

file(CREATE_LINK ${NEW_FOLDER}/tommyds ${OLD_FOLDER}/tommyds SYMBOLIC)
