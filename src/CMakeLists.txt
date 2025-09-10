# src/CMakeLists.txt

# File formats library
add_library(
  fileformats
  fileformats/generatorconfiguration.cpp fileformats/generatorconfiguration.h
  fileformats/trf.cpp fileformats/trf.h fileformats/types.h)
target_include_directories(fileformats PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(fileformats PROPERTIES CXX_STANDARD 17)

# Tournament library
add_library(
  tournament
  tournament/checker.cpp tournament/checker.h tournament/generator.cpp
  tournament/generator.h tournament/tournament.cpp tournament/tournament.h)
target_include_directories(tournament PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(tournament PROPERTIES CXX_STANDARD 17)

# Matching library
add_library(
  matching
  matching/computer.cpp
  matching/computer.h
  matching/templateinstantiation.h
  matching/detail/graph.cpp
  matching/detail/graphimpl.h
  matching/detail/graphsig.h
  matching/detail/blossomimpl.h
  matching/detail/blossomsig.h
  matching/detail/parentblossom.cpp
  matching/detail/parentblossomimpl.h
  matching/detail/parentblossomsig.h
  matching/detail/rootblossom.cpp
  matching/detail/rootblossomimpl.h
  matching/detail/rootblossomsig.h
  matching/detail/types.h
  matching/detail/verteximpl.h
  matching/detail/vertexsig.h)
target_include_directories(matching PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(matching PROPERTIES CXX_STANDARD 17)

# Swiss systems library (depends on tournament and matching)
add_library(
  swisssystems
  swisssystems/burstein.cpp swisssystems/burstein.h swisssystems/common.cpp
  swisssystems/common.h swisssystems/dutch.cpp swisssystems/dutch.h)
target_include_directories(swisssystems PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(swisssystems PROPERTIES CXX_STANDARD 17)
target_link_libraries(swisssystems tournament matching)

# Main executable
add_executable(bbpPairings main.cpp)
target_include_directories(bbpPairings PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
set_target_properties(
  bbpPairings
  PROPERTIES CXX_STANDARD 17
             RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}
             SUFFIX ".exe")
target_link_libraries(bbpPairings fileformats swisssystems tournament matching)
