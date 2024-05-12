# bigcode/ELS/module/src

# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

set(ELS_INCLUDE_DIR ${BIGCODE_INCLUDE_DIR}/target-utils/ELS)

add_library(bigcode_els_o OBJECT
  els.c
  els_config.c
  els_enums.c
  els_int.h
  els_log.c
  els_log.h
  els_module.c
  els_ucli.c
  ${ELS_INCLUDE_DIR}/els.h
  ${ELS_INCLUDE_DIR}/els.x
  ${ELS_INCLUDE_DIR}/els_config.h
  ${ELS_INCLUDE_DIR}/els_dox.h
  ${ELS_INCLUDE_DIR}/els_porting.h
)

set_bigcode_target_options(bigcode_els_o)
