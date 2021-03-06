# executable is named same as current directory
EXEC=$(shell basename $$PWD)
SRCS=$(EXEC).asm
OBJS=$(EXEC).o

# dwarf info is more powerful but to start out stabs is good as well
DBGI=dwarf
# DBGI=stabs

all: $(EXEC)

lldb: clean $(EXEC)
	lldb -- $(EXEC)

$(OBJS): $(SRCS)
	@nasm -f elf64 -g -F $(DBGI) $^ 

$(EXEC): $(OBJS)
	@ld -o $@ $^ 

clean:
	@rm -f $(OBJS) $(EXEC)

.PHONY: all clean gdb
