# GNU make tutorial

The Makefile provided in this folder is a fully working example which serves as a modular template for future projects.

## How it works

A makefile is, in fact, a bash script with extra steps. Its power lays in the abilty to create a list of commands to be executed conditionally based on the last modification date of the source, object and headers files (called *recipes*), and determine which files need to be recompiled each time exclusively. If any of the prerequisites has a modification date newer than a target, the commands will be executed for that target only.

```make
targets: prerequisites
    command
    command
```

Both targets and prerequisites refer to filenames relative to the Makefile. All prerequisites must be existing files or must be targets with instructions on how to generate them. Order of execution goes from left to right for the prerequisites (if they are newer), and finally the target's commands (repeating for each target from left to right).

Executing `make` on the terminal will process the first target. Calling `make [target]` will process the specified target.

## Syntax

### Setup: How to write bash scripts inside a Makefile

To mimic a bash terminal for the rule's commands, Makefiles should start with the following [Special Targets](https://www.gnu.org/software/make/manual/html_node/Special-Targets.html), and use a double dolar sign `$$` instead of a single one for variables and command replacement. Single `$` is reserved for Makefile variables substitution.

```make
SHELL=/bin/bash
.ONESHELL:
.POSIX:
.EXPORT_ALL_VARIABLES:
.DELETE_ON_ERROR:
.SILENT:
```

If Bash commands want to be executed to define a Makefile variable, it can be done with the shell assignment operator `!=` and the special `define` syntax (note: the variable's value will equal to the totality of the stdout; besides, Makefile variables should be referenced with a single dolar sign `$`):

```make
# List all source files ending with ".c" in several directories
source_dirs := src1 src2
define source_files !=
    for dir in ${source_dirs}; do
        ls $${dir}/*.c
    done
endef
```

#### Special targets explained

* `SHELL`: Sets the terminal type.

```make
# Replaces the shebang "#!/bin/bash"
SHELL=/bin/bash
.ONESHELL:
```

* `.ONESHELL:`: Allows to execute all commands for a rule inside a single shell, instead of each newline being processed by a different terminal.

```make
# All commands in one terminal
.ONESHELL:
```

* `.POSIX:`: Normally, a Makefile would abort execution on the first command returning non zero, but while using `.ONESHELL:`, it will only check for the return value of the last command of the whole rule. To abort execution at the first error, include this target.

```make
.POSIX:
```

* `.EXPORT_ALL_VARIABLES:`: Makefile variables start with a `$` (they are replaced by it's literal value before execution), and Bash variables start with `$$` (they are replaced by the terminal itself on execution). This target allows Makefile variables to be seen by child Bash terminals (instead of manually writing `export`). To avoid confusion, handle all variables with `$$`.

```make
.EXPORT_ALL_VARIABLES:
```

* `.DELETE_ON_ERROR:`: If an error occurs while compiling a target, you may automatically delete it adding this target.

```make
.DELETE_ON_ERROR:
```

* `.SILENT:`: Commands should start with a `@` for them not to be printed. This target enforces this behaviour.

```make
.SILENT:
```

#### How to always run a target

The special target `.PHONY: <target>` allows to always execute the target's rules, no matter if the prerequesites are met.

```make
# The target clear will always be executed when called,
# even if a file called "clear" exists in the filesystem.
.PHONY: clear
clear:
    command
```

### Makefile variables

Makefile variables can be assigned in the global scope of the file for all targets to see with `:=` (single equal sign `=` is for recursive equal, not recommended). Variables' values are literal, and special characters such as quotes `"` will be included in the value.

```make
var1 := value
var2 := "value"

target: prerequisite
    echo "$${var1}"     # prints: value
    echo "$${var2}"     # prints: "value", with quoutes included
```

#### Special rule's variables

* `$@`: name of the target.
* `$^`: all the prerequisites, separated by spaces.
* `$?`: all the prerequisites newer than the target, separated by spaces.
* `$<`: the first prerequisite.

### Wildcards

The `*` can be used for targets and prerequistes exactly as in bash (take notice that, in case of no matches, the literal glob will be printed instead)

```make
# All files ending in ".c" are the prerequisites, or literal "*.c" if no match
target: *.c
    command
```

The `%` is used for *Pattern rules*. Provided an **existing target** that matches the wildcard expansion, take the matching part which will be replaces by the wildacrd operator `%` (called *stem*), and copy it in the prerequisites matching `%`.

```make
# For every target "stem.o", create a prerequisite "stem.c",
# where "stem" replaces the wildcard "%" operator.
%.o: %.c
    command
```

## Bibliography

* [makefiletutorial.com](https://makefiletutorial.com/).
* [The GNU Make](https://www.gnu.org/software/make/manual/make.html)
