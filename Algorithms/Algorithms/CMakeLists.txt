# CMakeList.txt : CMake project for Algorithms, include source and define
# project specific logic here.
#

# Add source to this project's executable.
add_executable (Algorithms "Algorithms.c" "Algorithms.h" "Common.h" "Sorting.c" "Sorting.h" "Common.c")

if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET Algorithms PROPERTY C_STANDARD 17)
endif()

# TODO: Add tests and install targets if needed.
