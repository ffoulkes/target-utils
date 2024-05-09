# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.15)

project(target_utils VERSION 1.1.0 LANGUAGES C)

include(CMakePackageConfigHelpers)
include(CMakePrintHelpers)
include(GNUInstallDirs)

set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(CMAKE_BUILD_TYPE "RelWithDebInfo")

# Generate config.h file
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

################
# target_utils #
################

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

target_include_directories(target_utils PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}>
)

target_link_libraries(target_utils PUBLIC target_sys)

# When linking cjson, we want to ensure that the whole archive is added
# to the target_utils library and the symbols are forced to always be in.
# Switching the whole-archive option after linking cjson is important so
# that other archives and libraries don't start using this option
target_link_libraries(target_utils PUBLIC
  -Wl,--whole-archive
  cjson
  -Wl,--no-whole-archive
)

set_target_properties(target_utils PROPERTIES
  VERSION ${PROJECT_VERSION}
  SOVERSION ${PROJECT_VERSION_MAJOR}
)

###########
# install #
###########

set(EXPORTNAME targetutils)
set(EXPORTSTEM targetutils)

install(
  TARGETS target_utils
  EXPORT ${EXPORTNAME}
  COMPONENT target-utils
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(
    DIRECTORY include/target-utils
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    FILES_MATCHING
      PATTERN "*.h"
)

###################
# pkg-config file #
###################

set(_pkgconfig_file ${CMAKE_CURRENT_BINARY_DIR}/pkgconfig/libtarget_utils.pc)

configure_file(cmake/libtarget_utils.pc.in ${_pkgconfig_file} @ONLY)

install(
  FILES ${_pkgconfig_file}
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)

###############
# config-file #
###############

install(EXPORT ${EXPORTNAME}
  FILE ${EXPORTSTEM}-targets.cmake
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${EXPORTSTEM}
)

configure_package_config_file(
  cmake/${EXPORTSTEM}-config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/${EXPORTSTEM}-config.cmake
  INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${EXPORTSTEM}
)

install(
  FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${EXPORTSTEM}-config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${EXPORTSTEM}-config-version.cmake
  COMPONENT
    target-utils
  DESTINATION
    ${CMAKE_INSTALL_LIBDIR}/cmake/${EXPORTSTEM}
)

write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/${EXPORTSTEM}-config-version.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
)
