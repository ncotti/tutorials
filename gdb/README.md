# Gdb quick guide

This is a quick guide for debugging with GDB: the GNU Debugger.

A sample code, binary and gdb script is included.

## What's needed before debugging

GDB works with the compiled binary, but it needs to include information relative to the source code structure to be able to debug properly, such as line numbers or variable names. Therefore, compilation must be done with the `-g` flag for the `gcc` compiler. For example:

```bash
gcc -Wall -g primes.c -lm
```

After that, start GDB interactively with:

```bash
gdb [binary_file]
```

Or from a file with the `-x` flag:

```bash
gdb -x [script.gdb] [binary_file]
```

## Basic commands

## Starting

To start GDB with a compiled binary:

```gdb
gdb [filename]
```

And to exit:

```gdb
(gdb) quit
```

To set a layout to display the code in the terminal (navigate your code with the up and down arrow keys):

```gdb
(gdb) lay[out] src
(gdb) refresh  # To clean the display if it bugs out
```

The program won't run until said so. To add command line arguments, type:

```gdb
(gdb) set args [arg_list ...]
```

To start or restart the program's execution:

```gdb
(gdb) r[un]
```

Help with any command can be printed out with:

```gdb
(gdb) h[elp] [command]
```

With no breakpoint, the program will run normally. Press `Ctrl + c` to halt execution in the currently proccessed line.

## Flow Control

Once the program has stopped, `continue` it's normal operation with:

```gdb
(gdb) c[ontinue]
```

To go directly to the `next` line of code in the current file (passing over function calls):

```gdb
(gdb) n[ext]
```

To `step into` the next line of code to be executed, even entering function calls:

```gdb
(gdb) s[tep]
```

To `step out` of a function, and go to the next line of code of the calling script:

```gdb
(gdb) fin[ish]
```

Press `Enter` to execute the last command typed.

## Breakpoint and Watchpoints

A breakpoint can be put in the beggining of a function call, or in any line number. All breakpoints get assigned a "breakpoint number" for future reference.

```gdb
(gdb) b[reak] [file_name:][function_name | line_number]
```

Conditional breakpoints that use the program variable names and simple mathematical expressions can be set with:

```gdb
break [file_name:][function_name | line_number] if [condition]
```

A watchpoint can be put over a variable. The program execution will be stopped every time the content of that memory address changes.

```gdb
(gdb) wat[ch] [variable_name]
```

Some of the possible operations with breakpoints are:

* List all breakpoints (the info command can be used ).

```gdb
(gdb) i[nfo] b[reak]

Num  Type        Disp  Enb  Address  What
1    breakpoint  keep  y    0xFFFF   in main at primec.c:34
```

* Delete a breakpoint (using the number shown with `info break`)

```gdb
(gdb) d[elete] [breakpoint_number ...]
(gdb) d[elete]  # Deletes all breakpoints
```

* Disable or enable a breakpoint.

```gdb
(gdb) dis[able] [breakpoint_number ...]
(gdb) en[able] [breakpoint_number ...]
```

* Ignore a breakpoint until it has been crossed `x` times.

```gdb
(gdb) ign[ore] [breakpoint_number ...] [x]
```

Create a temporary breakpoint that will be deleted after being reached once.

```gdb
(gdb) tb[reak] [function_name]
```

## Checking variables

While the program is stopped, you can check the variables value in scope with:

```gdb
(gdb) p[rint] [variable_name]
(gdb) p vector[index]
(gdb) p *vector@[len]
```

You can automatically print a variable value each time the execution stops with the `display` command.

```gdb
(gdb) display [variable_name]
(gdb) undisplay [variable_name]
```

It's posible also to print the `backtrace` of the program. This will print all the function calls that needed to be made to be where you are, with it's arguments and all the variables in scope.

```gdb
(gdb) bt full
```

## Writing a .gdb file script

It's possible to automate the debugging process writing a script file with commands for gdb to execute. The commands are exactly the same as the ones shown, but a few extra ones are needed.

First, we need to log the output to a file instead of stdout.

```gdb
(gdb) set logging file [file_name]
(gdb) set logging overwrite
(gdb) set logging enabled on
(gdb) set logging enabled off
```

Besides, we should tell the debugger what needs to be done each time it stops in a certain breakpoint.

```gdb
break [file_name:][function_name]
    command [breakpoint_number]
    # actual commands
    # Note that "next" or "step" commands are forbidden here, because
    # the code would move away from the breakpoint and stop execution of the debugger.
end
```

You can aswell use a `printf` just like the C function to print nicer outputs.

```gdb
(gdb) printf "some_text\n"
```

And example script can be found in `script.gdb`.

## Bibliography

* [gdb QuickStart](https://web.eecs.umich.edu/~sugih/pointers/gdbQS.html#:~:text=If%20you%20want%20gdb%20to,or%20gdb%20encounters%20a%20breakpoint.).

* [GDB: The GNU Project Debugger](https://www.sourceware.org/gdb/documentation/).
