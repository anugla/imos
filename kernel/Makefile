AS=nasm #Assembly compiler
ASFLAGS=-f elf -g #Assembly flags
LD=i686-elf-ld #Linker
LDFLAGS=-m elf_i386 #Linker flags
SOURCES=$(wildcard *.asm) #Sources
OBJECTS=$(SOURCES:.asm=.o) #Object files
EXECUTABLE=kernel.bin #Program name

#Check version
all: $(SOURCES) $(EXECUTABLE)

#Create executable
$(EXECUTABLE): $(OBJECTS) 
	$(LD) $(LDFLAGS) $(OBJECTS) -o $@

#Compile assembly program
$(OBJECTS): $(SOURCES)
	$(AS) $(ASFLAGS) $(SOURCES)
 
#Clean folder
clean:
	rm -rf *o $(EXECUTABLE)
