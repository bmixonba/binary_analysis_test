CC = gcc
CFLAGS = -Wall -Wextra -std=c99
TARGETS = sample_program_v1 sample_program_v2 sample_program_v3

# Build all versions
all: $(TARGETS)

# Individual targets
sample_program_v1: sample_program_v1.c
	$(CC) $(CFLAGS) -o $@ $<

sample_program_v2: sample_program_v2.c
	$(CC) $(CFLAGS) -o $@ $<

sample_program_v3: sample_program_v3.c
	$(CC) $(CFLAGS) -o $@ $<

# Build with debug symbols for analysis
debug: CFLAGS += -g
debug: $(TARGETS)

# Build with different optimization levels
optimized: CFLAGS += -O2
optimized: clean $(TARGETS)

# Build stripped versions (no symbols)
stripped: $(TARGETS)
	strip sample_program_v1
	strip sample_program_v2
	strip sample_program_v3

# Clean build artifacts
clean:
	rm -f $(TARGETS) *.o

# Generate hex dumps for analysis
hexdumps: $(TARGETS)
	xxd sample_program_v1 > sample_program_v1.hex
	xxd sample_program_v2 > sample_program_v2.hex
	xxd sample_program_v3 > sample_program_v3.hex

# Generate objdump disassembly
disassembly: $(TARGETS)
	objdump -d sample_program_v1 > sample_program_v1.asm
	objdump -d sample_program_v2 > sample_program_v2.asm
	objdump -d sample_program_v3 > sample_program_v3.asm

# Run all programs to see output differences
run: $(TARGETS)
	@echo "=== Running sample_program_v1 ==="
	./sample_program_v1
	@echo ""
	@echo "=== Running sample_program_v2 ==="
	./sample_program_v2
	@echo ""
	@echo "=== Running sample_program_v3 ==="
	./sample_program_v3

.PHONY: all debug optimized stripped clean hexdumps disassembly run