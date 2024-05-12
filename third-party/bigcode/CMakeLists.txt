# third-party/bigcode

# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.15)

set(BIGCODE_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)
set(BIGCODE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

function(set_bigcode_target_options TARGET)
  target_compile_definitions(${TARGET} PUBLIC
    -DUCLI_CONFIG_INCLUDE_ELS_LOOP=1
    -DUCLI_CONFIG_INCLUDE_MODULE_NODES=0
  )

  target_compile_options(${TARGET} PUBLIC
    -Wno-shadow
    -Wno-format-security
  )

  target_include_directories(${TARGET} PUBLIC
    ${BIGCODE_SOURCE_DIR}
    ${BIGCODE_INCLUDE_DIR}
  )

  target_link_libraries(${TARGET} PUBLIC target_sys)
endfunction()

add_subdirectory(AIM/module/src)
add_subdirectory(BigData/BigList/module/src)
add_subdirectory(ELS/module/src)
add_subdirectory(IOF/module/src)
add_subdirectory(OS/module/src)
add_subdirectory(uCli/module/src)

add_library(bigcode STATIC
  $<TARGET_OBJECTS:bigcode_aim_o>
  $<TARGET_OBJECTS:bigcode_biglist_o>
  $<TARGET_OBJECTS:bigcode_els_o>
  $<TARGET_OBJECTS:bigcode_iof_o>
  $<TARGET_OBJECTS:bigcode_os_o>
  $<TARGET_OBJECTS:bigcode_ucli_o>
)

target_include_directories(bigcode PUBLIC
  $<BUILD_INTERFACE:${BIGCODE_INCLUDE_DIR}>
)

install(
  DIRECTORY include/target-utils/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/target-utils/
  PATTERN *.h
)
