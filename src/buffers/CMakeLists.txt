set(HEADERS
    ${AWP_SOURCE_DIR}/include/buffers/buffer.h     
    ${AWP_SOURCE_DIR}/include/test/test.h
    )

add_library(buffers buffer.c ${HEADERS})

target_include_directories(buffers
        PUBLIC
        ${AWP_SOURCE_DIR}/include/
       )

target_link_libraries(buffers
        ${MPI_C_LIBRARIES} 
        )

