VPATH = src src/startup src/vera

# Lirbary products
ALL_LIBS = x16.a c64.a

# Common source files
ASM_SRCS = stub_exit.s
C_SRCS = stub_lseek.c stub_write.c stub_close.c

# Commander X16 source files
ASM_SRCS_X16 = x16startup.s stub_putchar.s stub_read.s clearbitmap.s
C_SRCS_X16 = $(C_SRCS)

# Commodore 64 source files
ASM_SRCS_C64 = x16startup.s stub_putchar.s stub_read.s
C_SRCS_C64 = $(C_SRCS)

# Object files
OBJS_X16 = $(ASM_SRCS_X16:%.s=%-65c02.o) $(C_SRCS_X16:%.c=%-65c02.o)
OBJS_C64 = $(ASM_SRCS_C64:%.s=%-6502.o) $(C_SRCS_C64:%.c=%-6502.o)

%-6502.o: %.s
	as6502 --core=6502 --list-file=$(@:%.o=obj/%.lst) -o obj/$@ $<

%-6502.o: %.c
	cc6502 --core=6502 -O2 --list-file=$(@:%.o=obj/%.lst) -o obj/$@ $<

%-65c02.o: %.s
	as6502 --core=65c02 --list-file=$(@:%.o=obj/%.lst) -o obj/$@ $<

%-65c02.o: %.c
	cc6502 --core=65c02 -O2 --list-file=$(@:%.o=obj/%.lst) -o obj/$@ $<

all: $(ALL_LIBS)

x16.a: $(OBJS_X16)
	(cd obj ; nlib ../$@ $^)

c64.a: $(OBJS_C64)
	(cd obj ; nlib ../$@ $^)

clean:
	-(cd obj ; rm $(OBJS_X16) $(OBJS_X16:%.o=%.lst))
	-(cd obj ; rm $(OBJS_C64) $(OBJS_C64:%.o=%.lst))
	-rm $(ALL_LIBS)
