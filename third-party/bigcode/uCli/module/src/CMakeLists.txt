# bigcode/uCLI/module/src

# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

set(UCLI_INCLUDE_DIR ${BIGCODE_INCLUDE_DIR}/target-utils/uCli)

add_library(bigcode_ucli_o OBJECT
  ucli.c
  ucli_argparse.c
  ucli_config.c
  ucli_enums.c
  ucli_error.c
  ucli_handlers.c
  ucli_int.h
  ucli_log.c
  ucli_log.h
  ucli_module.c
  ucli_node.c
  ucli_printf.c
  ucli_util.c
  ucli_util.h
  ${UCLI_INCLUDE_DIR}/ucli.h
  ${UCLI_INCLUDE_DIR}/ucli.x
  ${UCLI_INCLUDE_DIR}/ucli_argparse.h
  ${UCLI_INCLUDE_DIR}/ucli_common.h
  ${UCLI_INCLUDE_DIR}/ucli_config.h
  ${UCLI_INCLUDE_DIR}/ucli_dox.h
  ${UCLI_INCLUDE_DIR}/ucli_errors.h
  ${UCLI_INCLUDE_DIR}/ucli_handler_macros.h
  ${UCLI_INCLUDE_DIR}/ucli_module.h
  ${UCLI_INCLUDE_DIR}/ucli_node.h
  ${UCLI_INCLUDE_DIR}/ucli_porting.h
)

set_bigcode_target_options(bigcode_ucli_o)
