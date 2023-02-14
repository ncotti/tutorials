# GoogleTest tutorial

GoogleTest (gtest) is a tool for unit and integration testing for C++ code.

## How to setup

First, prepare a `CMakeListx.txt` file, including the gtest depency from the [GoogleTest page](https://google.github.io/googletest/quickstart-cmake.html).

After that, a standard CMake project should be built with the following commands:

```bash
mkdir build
cd build
cmake ..
cmake --build .
```

And the tests can be executed with:

```bash
ctest
```

## Quick test API reference

In a test file, the header `#include "gtest/gtest.h"` must be included. After that, test functions are declared with the `TEST` macro with two arguments: The name of the group of tests, and the name of the individual test:

```c
TEST(GroupTestName, TestName) {}
```

After that, the test is a normal C++ code, where we can call the assertion functions to check whether our code behaves as expected or no.

```c
EXPECT_EQ(first_expression, second_expression);
EXPECT_TRUE(expression);
EXPECT_FALSE(expression);
EXPECT_STREQ(first_string, second_string);
EXPECT_THROW(expression, error_to_be_catched_in_a_try_catch)
```

It's possible to call `ASSERT_EQ(first, second)` and it's variants instead. The difference is that ASSERT end execution of the test, while EXPECT continues it until the end.
