set(HEADERS
    ${AWP_SOURCE_DIR}/include/awp/definitions.h     
    ${AWP_SOURCE_DIR}/include/topography/topography.h     
    ${AWP_SOURCE_DIR}/include/topography/initializations/constant.h     
    ${AWP_SOURCE_DIR}/include/topography/initializations/random.h     
    ${AWP_SOURCE_DIR}/include/topography/initializations/cerjan.h     
    ${AWP_SOURCE_DIR}/include/topography/initializations/linear.h     
    ${AWP_SOURCE_DIR}/include/topography/initializations/quadratic.h     
    )

add_library(topography_initializations
        constant.c random.c cerjan.c linear.c quadratic.c ${HEADERS}
        )

target_include_directories(topography_initializations
        PUBLIC
        ${AWP_SOURCE_DIR}/include/
        )
