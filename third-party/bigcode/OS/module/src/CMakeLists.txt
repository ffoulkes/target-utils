# bigcode/OS/module/src

# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

set(OS_INCLUDE_DIR ${BIGCODE_INCLUDE_DIR}/target-utils/OS)

add_library(bigcode_os_o OBJECT
  os_config.c
  os_enums.c
  os_int.h
  os_log.c
  os_log.h
  os_module.c
  os_sem_none.c
  os_sem_osx.c
  os_sem_posix.c
  os_sem_windows.c
  os_sleep_none.c
  os_sleep_osx.c
  os_sleep_posix.c
  os_sleep_windows.c
  os_time_none.c
  os_time_osx.c
  os_time_posix.c
  os_time_windows.c
  os_ucli.c
  ${OS_INCLUDE_DIR}/os.h
  ${OS_INCLUDE_DIR}/os.x
  ${OS_INCLUDE_DIR}/os_config.h
  ${OS_INCLUDE_DIR}/os_porting.h
  ${OS_INCLUDE_DIR}/os_sem.h
  ${OS_INCLUDE_DIR}/os_sleep.h
  ${OS_INCLUDE_DIR}/os_time.h
)

set_bigcode_target_options(bigcode_os_o)
