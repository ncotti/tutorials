# Example gdb
set logging file output.txt
set logging overwrite
set args 15

# Let's check that the command line argument is in fact n=15
break primes.c:main
    command 1
    print *argv@2
    c
end

# Let's keep and eye on that "total" variable.
break primes.c:49
    command 2
    # Here we could achieve the same with "display total"
    watch total
        command 4
        print total
        c
    end
    c
end

# Let's break only in one iteration of the loop
break primes.c:51 if i == 5
    command 3
    bt full
    c
end

# Run the script with all the the breakpoints set
set logging enabled on
run

# Quitting
#set logging enabled off
quit