
# Define source files for each component
set(FILEFORMATS_SOURCES
    fileformats/generatorconfiguration.cpp
    fileformats/trf.cpp
)

set(MATCHING_SOURCES
    matching/computer.cpp
    matching/detail/graph.cpp
    matching/detail/parentblossom.cpp
    matching/detail/rootblossom.cpp
)

set(SWISSSYSTEMS_SOURCES
    swisssystems/burstein.cpp
    swisssystems/common.cpp
    swisssystems/dutch.cpp
)

set(TOURNAMENT_SOURCES
    tournament/checker.cpp
    tournament/generator.cpp
    tournament/tournament.cpp
)

# Create libraries
add_library(fileformats STATIC ${FILEFORMATS_SOURCES})
add_library(matching STATIC ${MATCHING_SOURCES})
add_library(swisssystems STATIC ${SWISSSYSTEMS_SOURCES})
add_library(tournament STATIC ${TOURNAMENT_SOURCES})

# Set include directories
foreach(lib fileformats matching swisssystems tournament)
    target_include_directories(${lib} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
endforeach()

# Main executable
add_executable(main main.cpp)
target_link_libraries(main PRIVATE fileformats matching swisssystems tournament)
target_include_directories(main PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
