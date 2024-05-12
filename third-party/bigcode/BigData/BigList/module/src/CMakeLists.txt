# bigcode/BigData/BigList/module/src

# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

set(BIGLIST_INCLUDE_DIR ${BIGCODE_INCLUDE_DIR}/target-utils/BigList)

add_library(bigcode_biglist_o OBJECT
  biglist.c
  biglist_alloc.c
  biglist_append.c
  biglist_append_list.c
  biglist_config.c
  biglist_copy.c
  biglist_dump.c
  biglist_find.c
  biglist_find_custom.c
  biglist_foreach.c
  biglist_free.c
  biglist_free_all.c
  biglist_from_array.c
  biglist_from_data_array.c
  biglist_insert_sorted.c
  biglist_int.h
  biglist_last.c
  biglist_length.c
  biglist_lock.c
  biglist_locked_append.c
  biglist_locked_create.c
  biglist_locked_find.c
  biglist_locked_free.c
  biglist_locked_free_all.c
  biglist_locked_length.c
  biglist_locked_prepend.c
  biglist_locked_remove.c
  biglist_locked_remove_link.c
  biglist_locked_remove_link_free.c
  biglist_log.c
  biglist_log.h
  biglist_next.c
  biglist_prepend.c
  biglist_prepend_list.c
  biglist_prev.c
  biglist_remove.c
  biglist_remove_link.c
  biglist_remove_link_free.c
  biglist_reverse.c
  biglist_sort.c
  biglist_to_array.c
  biglist_to_data_array.c
  biglist_unlock.c
  ${BIGLIST_INCLUDE_DIR}/biglist.h
  ${BIGLIST_INCLUDE_DIR}/biglist_config.h
  ${BIGLIST_INCLUDE_DIR}/biglist_dox.h
  ${BIGLIST_INCLUDE_DIR}/biglist_locked.h
  ${BIGLIST_INCLUDE_DIR}/biglist_porting.h
)

set_bigcode_target_options(bigcode_biglist_o)
