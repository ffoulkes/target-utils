# bigcode/IOF/module/src

# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

set(IOF_INCLUDE_DIR ${BIGCODE_INCLUDE_DIR}/target-utils/IOF)

add_library(bigcode_iof_o OBJECT
  iof.c
  iof_config.c
  iof_log.c
  iof_log.h
  iof_module.c
  ${IOF_INCLUDE_DIR}/iof.h
  ${IOF_INCLUDE_DIR}/iof_config.h
  ${IOF_INCLUDE_DIR}/iof_dox.h
  ${IOF_INCLUDE_DIR}/iof_porting.h
)

set_bigcode_target_options(bigcode_iof_o)
