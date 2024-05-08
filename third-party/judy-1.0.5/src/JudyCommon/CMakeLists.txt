include_directories(..)
include_directories(../target_utils)
add_library(JudyCommon OBJECT JudyMalloc.c)
target_link_libraries(JudyCommon PUBLIC target_sys)
