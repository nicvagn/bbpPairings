# test/CMakeLists.txt

# Set C++20 standard for tests (as per your Makefile)
set(CMAKE_CXX_STANDARD 20)

# Add all the warning flags from your Makefile
set(TEST_CXX_FLAGS
    -std=c++20
    -ftabstop=2
    -Werror
    -Wfatal-errors
    -pedantic
    -pedantic-errors
    -Wabi=0
    -Waligned-new=all
    -Wall
    -Walloc-zero
    -Walloca
    -Warith-conversion
    -Warray-bounds=2
    -Warray-parameter=2
    -Wattribute-alias=2
    -Wcast-align=strict
    -Wcast-qual
    -Wcatch-value=3
    -Wconditionally-supported
    -Wconversion
    -Wctad-maybe-unsupported
    -Wctor-dtor-privacy
    -Wdate-time
    -Wdisabled-optimization
    -Wdouble-promotion
    -Wduplicated-branches
    -Wduplicated-cond
    -Weffc++
    -Wenum-conversion
    -Wextra
    -Wextra-semi
    -Wfloat-equal
    -Wformat=2
    -Wformat-overflow=2
    -Wformat-signedness
    -Wformat-truncation=2
    -Wimplicit-fallthrough=3
    -Winline
    -Winvalid-imported-macros
    -Winvalid-pch
    -Wlogical-op
    -Wlong-long
    -Wmismatched-tags
    -Wmissing-braces
    -Wmissing-include-dirs
    -Wmultiple-inheritance
    -Wnormalized=nfkc
    -Wnull-dereference
    -Wold-style-cast
    -Woverloaded-virtual
    -Wpacked
    -Wpadded
    -Wplacement-new=2
    -Wpointer-arith
    -Wredundant-decls
    -Wredundant-tags
    -Wshadow
    -Wsign-conversion
    -Wsign-promo
    -Wstrict-null-sentinel
    -Wstrict-overflow=5
    -Wstringop-overflow=4
    -Wsuggest-attribute=cold
    -Wsuggest-attribute=const
    -Wsuggest-attribute=format
    -Wsuggest-attribute=malloc
    -Wsuggest-attribute=noreturn
    -Wsuggest-attribute=pure
    -Wsuggest-final-methods
    -Wsuggest-final-types
    -Wsuggest-override
    -Wswitch-default
    -Wswitch-enum
    -Wsync-nand
    -Wtrampolines
    -Wundef
    -Wunsafe-loop-optimizations
    -Wunused-macros
    -Wuseless-cast
    -Wvector-operation-performance
    -Wvirtual-inheritance
    -Wvla
    -Wzero-as-null-pointer-constant
)

# Add -static for MSYS/Windows
if(WIN32 OR MSYS)
    list(APPEND TEST_CXX_FLAGS -static)
endif()

# Find all test source files
file(GLOB TEST_SOURCES "tests/*.cpp")

# Generate test-includes.h
set(TEST_INCLUDES_H "${CMAKE_CURRENT_BINARY_DIR}/test-includes.h")

# Extract test IDs from filenames
set(TEST_IDS)
foreach(TEST_SOURCE ${TEST_SOURCES})
    get_filename_component(TEST_ID ${TEST_SOURCE} NAME_WE)
    list(APPEND TEST_IDS ${TEST_ID})
endforeach()

# Custom command to generate test-includes.h
add_custom_command(
    OUTPUT ${TEST_INCLUDES_H}
    COMMAND ${CMAKE_COMMAND} -E echo "" > ${TEST_INCLUDES_H}
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_SOURCE_DIR}/generate_test_includes.cmake
    DEPENDS ${TEST_SOURCES} ${CMAKE_CURRENT_SOURCE_DIR}/generate_test_includes.cmake
    COMMENT "Generating test-includes.h"
)

# Create the test executable
add_executable(bbpPairingsTests
    main.cpp
    ${TEST_INCLUDES_H}
)

# Set target properties
set_target_properties(bbpPairingsTests PROPERTIES
    CXX_STANDARD 20
    CXX_STANDARD_REQUIRED ON
    OUTPUT_NAME "bbpPairingsTests.exe"
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

# Add compile flags
target_compile_options(bbpPairingsTests PRIVATE ${TEST_CXX_FLAGS})

# Include directories
target_include_directories(bbpPairingsTests PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
)

# Add a custom target for running tests
add_custom_target(run_tests
    COMMAND bbpPairingsTests.exe ${CMAKE_SOURCE_DIR}/bbpPairings.exe ${CMAKE_CURRENT_SOURCE_DIR}/tests
    DEPENDS bbpPairingsTests bbpPairings
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMENT "Running tests"
)

# Clean target for test files
add_custom_target(clean_tests
    COMMAND ${CMAKE_COMMAND} -E remove_directory tests/*.output
    COMMAND ${CMAKE_COMMAND} -E remove bbpPairingsTests.exe bbpPairingsTests.d
    COMMAND ${CMAKE_COMMAND} -E remove ${TEST_INCLUDES_H}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMENT "Cleaning test files"
)
