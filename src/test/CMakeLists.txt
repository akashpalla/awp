set(HEADERS
    ${AWP_SOURCE_DIR}/include/test/grid_check.h
    ${AWP_SOURCE_DIR}/include/test/test.h
    ${AWP_SOURCE_DIR}/include/awp/definitions.h
    )

add_library(testing
        test.c
        check.c
        grid_check.c
        )

target_link_libraries(testing
        ${MPI_C_LIBRARIES}
        m
        )

target_include_directories(testing
        PUBLIC
        ${AWP_SOURCE_DIR}/include/
        )




