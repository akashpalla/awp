add_library(topography_receivers
        receiver.c receivers.c sgt.c
        )

target_include_directories(topography_receivers
        PUBLIC
        ${AWP_SOURCE_DIR}/include/
        )

target_link_libraries(topography_receivers topography_sources)

