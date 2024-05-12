# bigcode/AIM/module/src

# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

set(AIM_INCLUDE_DIR ${BIGCODE_INCLUDE_DIR}/target-utils/AIM)

add_library(bigcode_aim_o OBJECT
  aim_bitmap.c
  aim_config.c
  aim_daemon.c
  aim_datatypes.c
  aim_enums.c
  aim_error.c
  aim_int.h
  aim_log.c
  aim_log.h
  aim_map.c
  aim_memory.c
  aim_module.c
  aim_modules_init.c
  aim_object.c
  aim_printf.c
  aim_pvs.c
  aim_pvs_buffer.c
  aim_pvs_file.c
  aim_pvs_syslog.c
  aim_rl.c
  aim_sparse.c
  aim_string.c
  aim_util.h
  aim_valgrind.c
  ${AIM_INCLUDE_DIR}/aim.h
  ${AIM_INCLUDE_DIR}/aim.x
  ${AIM_INCLUDE_DIR}/aim_bitmap.h
  ${AIM_INCLUDE_DIR}/aim_config.h
  ${AIM_INCLUDE_DIR}/aim_daemon.h
  ${AIM_INCLUDE_DIR}/aim_datatypes.h
  ${AIM_INCLUDE_DIR}/aim_dox.h
  ${AIM_INCLUDE_DIR}/aim_error.h
  ${AIM_INCLUDE_DIR}/aim_list.h
  ${AIM_INCLUDE_DIR}/aim_log.h
  ${AIM_INCLUDE_DIR}/aim_map.h
  ${AIM_INCLUDE_DIR}/aim_memory.h
  ${AIM_INCLUDE_DIR}/aim_object.h
  ${AIM_INCLUDE_DIR}/aim_porting.h
  ${AIM_INCLUDE_DIR}/aim_printf.h
  ${AIM_INCLUDE_DIR}/aim_pvs.h
  ${AIM_INCLUDE_DIR}/aim_pvs_buffer.h
  ${AIM_INCLUDE_DIR}/aim_pvs_file.h
  ${AIM_INCLUDE_DIR}/aim_pvs_syslog.h
  ${AIM_INCLUDE_DIR}/aim_rl.h
  ${AIM_INCLUDE_DIR}/aim_sparse.h
  ${AIM_INCLUDE_DIR}/aim_string.h
  ${AIM_INCLUDE_DIR}/aim_utils.h
  ${AIM_INCLUDE_DIR}/aim_valgrind.h
  ${AIM_INCLUDE_DIR}/aim_valist.h
)

set_bigcode_target_options(bigcode_aim_o)
