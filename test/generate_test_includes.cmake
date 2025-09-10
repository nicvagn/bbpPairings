# test/generate_test_includes.cmake
# Script to generate test-includes.h

file(GLOB TEST_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/tests/*.cpp")
set(TEST_INCLUDES_H "${CMAKE_CURRENT_BINARY_DIR}/test-includes.h")

# Start with empty file
file(WRITE ${TEST_INCLUDES_H} "")

# Extract test IDs and generate includes
set(TEST_IDS)
foreach(TEST_SOURCE ${TEST_SOURCES})
    get_filename_component(TEST_ID ${TEST_SOURCE} NAME_WE)
    list(APPEND TEST_IDS ${TEST_ID})

    # Add the test include
    file(APPEND ${TEST_INCLUDES_H} "#define TEST_ID ${TEST_ID}\n")
    file(APPEND ${TEST_INCLUDES_H} "#include <tests/${TEST_ID}.cpp>\n")
    file(APPEND ${TEST_INCLUDES_H} "#undef TEST_ID\n")
endforeach()

# Add the runTests function
file(APPEND ${TEST_INCLUDES_H} "\n")
file(APPEND ${TEST_INCLUDES_H} "int runTests(const testing::Context &context)\n")
file(APPEND ${TEST_INCLUDES_H} "{\n")
file(APPEND ${TEST_INCLUDES_H} "  BEFORE_RUNNING_TESTS\n")

foreach(TEST_ID ${TEST_IDS})
    file(APPEND ${TEST_INCLUDES_H} "  RUN_TEST(${TEST_ID})\n")
endforeach()

file(APPEND ${TEST_INCLUDES_H} "  AFTER_RUNNING_TESTS\n")
file(APPEND ${TEST_INCLUDES_H} "}\n")
