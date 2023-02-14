# CMake quick guide

This is a quick guide to learn how to compile C and C++ code using [CMake](https://cmake.org/).

And example project is provided for the reader to see the commands execution. To execute it, type:

```bash
mkdir build
cd build
cmake ..
cmake --build .
cmake --install . --prefix $(pwd)/../install
../install/bin/tuto
```

## How to build the project

Provided that we have a project as the example in this repository, with a `CMakeLists.txt` file in it's root directory; first it's needed to define a source directory (where the code is), and a binary directory (where the compilation files will end up at).

```bash
mkdir [build_dir]
cd [build_dir]
cmake [root_source_dir]
```

Being on the `build` directory, that last lines establishes the PWD as the `CMAKE_BINARY_DIR` and the command `..` as the `CMAKE_SOURCE_DIR`.

Then, the project is compiled and installed as:

```bash
cmake --build [build_dir]
cmake --install [build_dir] --prefix [install_dir]
```

## CMakeLists.txt reference

All compilation, linking, and installation instruction must be stored in a file called `CMakeLists.txt` in the root directory of the project.

### Intial setup

First, setup the CMake version, C language standard, and the project name.

```cmake
cmake_minimum_required(VERSION <version_number>)

project([PROJECT_NAME])

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)
```

### Adding source files

A `target` represents an executable file to be compiled. A list of source files must be provided to generate that executable.

```cmake
add_executable(
    [target_name] 
    [sources ...]
)
```

### Adding a library

A target might need some librarys (files with `*.o` or `*.a` extensions) it needs to link to. They can be added as follows.

```cmake
add_library(
    [library_target_name]
    [sources...]
)
```

After that, the library can be linked with:

```cmake
target_link_libraries(
    <target_name> 
    PUBLIC|PRIVATE|INTERFACE <library_target_name>
)
```

The `PUBLIC|PRIVATE|INTERFACE` stablish the way in which the library will be included:

1. `PUBLIC`: The library can be seen by the target and every other target that links with it.

2. `PRIVATE`: The library can only be seen by the calling target.

3. `INTERFACE`: The library can only be seen by subsequent targets, but can not be seen by the calling target that includes it.

### Adding header files

An include directory, where all `*.h` headers files are stored, can be defined with:

```cmake
target_include_directories ([target_name] [PUBLIC|PRIVATE|INTERFACE] [header_folders ...])
```

This command allows to type something like `#include my_header.h`, and have the include path already configured for us.

### Miscellaneous

It's possible to define a subdirectory with a nested CMakeLists.txt file in it to be executed with:

```cmake
add_subdirectory([path_to_CMakeLists.txt])
```

A custom linux shell command can be executed with the following syntax:

```cmake
add_custom_command(
    OUTPUT [output_file]
    WORKING_DIRECTORY [path]
    COMMAND [linux command]
    COMMENT [What to print in terminal]
    DEPENDS [file]
)
```

### Installation commands

The installation proccess consists of cleanup and moving around the binaries generated, as a mean to expose only useful files to the user, and hide all the compilation ones.

```cmake
install(
    TARGETS|FILES|DIRECTORY [element] 
    DESTINATION [directory_path]
)
```

### Variables

A variable, accessible from the CMakeList.txt file, can be created as:

```cmake
set([VAR_NAME] [var_value])
```

And be read as follows:

```cmake
${VAR_NAME}
```

Some common global variables defined for every CMake project are:

```cmake
${CMAKE_SOURCE_DIR}

${CMAKE_CURRENT_SOURCE_DIR}

${CMAKE_BINARY_DIR}

${CMAKE_CURRENT_BINARY_DIR}

${PROJECT_SOURCE_DIR}

${PROJECT_BINARY_DIR}
```
