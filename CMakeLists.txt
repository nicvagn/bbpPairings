cmake_minimum_required(VERSION 3.4...3.18)

# SET'S LIST NO LONGER IGNORES EMPTY SETS
cmake_policy(SET CMP0007 NEW)
# change relative source path's to absolute
CMAKE_POLICY(SET CMP0076 NEW)

project(bbpPairings LANGUAGES CXX)

# set the wich standard version (C++) the target's will be compiled with.
# Make it required
set(CMAKE_CXX_STANDARD 11)
set(CXX_STANDARD_REQUIRED On)
set(CMAKE_CXX_FLAGS "-Wall -Wextra -fPIC")
# set the standard version of C
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_FLAGS "-Wall -Wextra -fPIC")
set(CMAKE_C_STANDARD_REQUIRED ON)

# add the source dir
add_subdirectory(src)
