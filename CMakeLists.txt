cmake_minimum_required(VERSION 3.10)

if(CMAKE_VERSION VERSION_GREATER "3.31.6")
  message(
    WARNING
      "This project has only been tested with CMake up to 3.31.6. You have ${CMAKE_VERSION}"
  )
endif()

project(bbpPairings)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Add compiler flags for better error reporting and C++17 support
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID STREQUAL
                                           "Clang")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -std=c++17")
endif()

# add src, it contains a further CMakeLists.txt
add_subdirectory(src)
