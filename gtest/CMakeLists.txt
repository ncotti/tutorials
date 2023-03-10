# Setup
cmake_minimum_required(VERSION 3.14)
project(my_project)
set(CMAKE_CXX_STANDARD 11)

set(SOURCES src/functions.cpp)

# The following was copied from the gtest page
include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/609281088cfefc76f9d0ce82e1ff6c30cc3591e5.zip
)

set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

# Let's create a library as our project
add_library(
  my_library
  ${SOURCES}
)

target_include_directories(
  my_library
  PUBLIC "include"
)

# This part was also copied from the gtest page.
enable_testing()

# Defining a test group
add_executable(
    hello_test
    tests/test.cpp
)

# Libraries needed to run the test
target_link_libraries(
  hello_test
  gtest_main
  my_library
)

include(GoogleTest)

# A list of all the tests
gtest_discover_tests(hello_test)
