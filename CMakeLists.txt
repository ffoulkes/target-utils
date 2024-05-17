# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.15)

project(targetutils VERSION 1.1.0 LANGUAGES C)

option(WITH_CJSON "Include cJSON in targetutils" OFF)

#-----------------------------------------------------------------------
# Modules
#-----------------------------------------------------------------------
include(CMakePackageConfigHelpers)
include(CMakePrintHelpers)
include(GNUInstallDirs)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

#-----------------------------------------------------------------------
# config.h file
#-----------------------------------------------------------------------
include(ConfigureChecks)

#-----------------------------------------------------------------------
# Packages
#-----------------------------------------------------------------------
find_package(targetsys REQUIRED)
message(STATUS "Found target-sys ${targetsys_VERSION}")

if(WITH_CJSON)
  find_package(cJSON REQUIRED)
  message(STATUS "Found cJSON ${cJSON_VERSION}")
endif()

find_package(judy REQUIRED)
message(STATUS "Found judy ${judy_VERSION}")

find_package(tommyds REQUIRED)
message(STATUS "Found tommyds ${tommyds_VERSION}")

find_package(xxhash REQUIRED)
message(STATUS "Found xxHash ${xxhash_VERSION}")

#-----------------------------------------------------------------------
# Build
#-----------------------------------------------------------------------
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(CMAKE_BUILD_TYPE "RelWithDebInfo")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror=unused-parameter")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror=unused-parameter")

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
include_directories(${CMAKE_CURRENT_BINARY_DIR})

set(EXPORTNAME TargetUtils)
set(EXPORTSTEM targetutils)

add_subdirectory(src)
add_subdirectory(third-party)

#-----------------------------------------------------------------------
# libtarget_utils
#-----------------------------------------------------------------------
add_library(target_utils SHARED
  $<TARGET_OBJECTS:target_sysutil_o>
)

target_include_directories(target_utils PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:$<INSTALL_PREFIX>/${CMAKE_INSTALL_INCLUDEDIR}>
)

target_link_libraries(target_utils PUBLIC
  judy
  target_sys
  tommyds
)

set_target_properties(target_utils PROPERTIES
  INSTALL_RPATH "$ORIGIN"
  VERSION ${PROJECT_VERSION}
  SOVERSION ${PROJECT_VERSION_MAJOR}
)

if(WITH_CJSON)
  # When linking cjson, we want to ensure that the whole archive is added
  # to the target_utils library and the symbols are forced to always be in.
  # Switching the whole-archive option after linking cjson is important so
  # that other archives and libraries don't start using this option
  target_link_libraries(target_utils PUBLIC
    -Wl,--whole-archive
    cjson
    -Wl,--no-whole-archive
  )
endif()

#-----------------------------------------------------------------------
# Install
#-----------------------------------------------------------------------
install(
  TARGETS target_utils
  EXPORT ${EXPORTNAME}
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

#-----------------------------------------------------------------------
# Create symbolic links
#-----------------------------------------------------------------------
install(SCRIPT cmake/create-symlinks.cmake)

#-----------------------------------------------------------------------
# pkg-config file
#-----------------------------------------------------------------------
set(_pkgconfig_file ${CMAKE_CURRENT_BINARY_DIR}/pkgconfig/libtarget_utils.pc)

configure_file(cmake/libtarget_utils.pc.in ${_pkgconfig_file} @ONLY)

install(
  FILES ${_pkgconfig_file}
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)

#-----------------------------------------------------------------------
# CMake configuration file
#-----------------------------------------------------------------------
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
  DESTINATION
    ${CMAKE_INSTALL_LIBDIR}/cmake/${EXPORTSTEM}
)

write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/${EXPORTSTEM}-config-version.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
)
