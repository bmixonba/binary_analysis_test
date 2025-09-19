# Binary Analysis Test

Practice materials for binary diffing and analysis techniques. This repository contains sample programs and scripts to help you learn and practice binary analysis and diffing skills.

## Overview

This repository provides:

1. **Sample C Programs**: Three versions of a simple program with progressive changes
2. **Build System**: Makefile with various compilation options
3. **Demo Scripts**: Automated demonstrations of binary analysis techniques
4. **Practice Examples**: Hands-on examples for learning binary diffing

## Getting Started

### Prerequisites

Ensure you have the following tools installed:
- `gcc` (GNU Compiler Collection)
- `make` (Build automation tool)
- `objdump` (Object file analyzer)
- `hexdump` / `xxd` (Hex dump utilities)
- `strings` (String extraction tool)
- `diff` (File comparison utility)
- `readelf` (ELF file analyzer)

### Quick Start

1. **Build all sample programs:**
   ```bash
   make all
   ```

2. **Run the basic binary diffing demo:**
   ```bash
   ./binary_diff_demo.sh
   ```

3. **Try advanced binary analysis techniques:**
   ```bash
   ./advanced_binary_diff.sh
   ```

## Sample Programs

### Program Versions

- **`sample_program_v1.c`**: Basic version with simple functionality
- **`sample_program_v2.c`**: Modified version with changed strings and values
- **`sample_program_v3.c`**: Advanced version with new functions and dynamic allocation

### Key Differences Between Versions

| Feature | V1 | V2 | V3 |
|---------|----|----|----| 
| Version String | "1.0" | "2.0" | "3.0" |
| Magic Number | 42 | 84 | 168 |
| Buffer Size | 256 | 256 | 512 |
| Functions | main only | main only | main + print_banner |
| Dynamic Allocation | No | No | Yes (malloc/free) |
| Additional Output | No | Yes | Yes + more |

## Build Targets

### Basic Builds
```bash
make all          # Build all versions
make debug        # Build with debug symbols (-g)
make optimized    # Build with optimization (-O2)
make stripped     # Build and strip symbols
```

### Analysis Targets
```bash
make hexdumps     # Generate hex dumps (*.hex files)
make disassembly  # Generate disassembly (*.asm files)
make run          # Run all programs to see output differences
```

### Cleanup
```bash
make clean        # Remove built binaries and artifacts
```

## Binary Analysis Techniques Demonstrated

### 1. File-Level Analysis
- File size comparison
- File type identification
- Basic metadata extraction

### 2. Content Analysis
- Hexadecimal dump comparison
- String extraction and diffing
- Byte-by-byte comparison

### 3. Structural Analysis
- ELF header analysis
- Section size comparison
- Symbol table differences
- Function identification

### 4. Advanced Techniques
- Disassembly comparison
- Library dependency analysis
- Entry point analysis
- Binary signature verification

## Practice Exercises

### Beginner Level

1. **Compare file sizes and identify which version is largest**
   ```bash
   ls -la sample_program_v*
   ```

2. **Extract and compare strings between versions**
   ```bash
   strings sample_program_v1 > v1_strings.txt
   strings sample_program_v2 > v2_strings.txt
   diff v1_strings.txt v2_strings.txt
   ```

3. **Identify the first byte difference between binaries**
   ```bash
   cmp -l sample_program_v1 sample_program_v2 | head -1
   ```

### Intermediate Level

1. **Compare hex dumps to find specific changes**
   ```bash
   diff <(xxd sample_program_v1) <(xxd sample_program_v2) | head -10
   ```

2. **Analyze section sizes**
   ```bash
   objdump -h sample_program_v1 | grep -E "\.text|\.data|\.rodata"
   objdump -h sample_program_v3 | grep -E "\.text|\.data|\.rodata"
   ```

3. **Compare disassembly of specific functions**
   ```bash
   objdump -d sample_program_v1 > v1.asm
   objdump -d sample_program_v3 > v3.asm
   diff v1.asm v3.asm
   ```

### Advanced Level

1. **Identify new function additions**
   ```bash
   objdump -t sample_program_v1 | grep -w "F"
   objdump -t sample_program_v3 | grep -w "F"
   ```

2. **Analyze library dependencies changes**
   ```bash
   ldd sample_program_v1
   ldd sample_program_v3
   ```

3. **Create visual binary diff**
   ```bash
   diff --side-by-side <(xxd sample_program_v1 | head -20) <(xxd sample_program_v2 | head -20)
   ```

## Useful Commands for Manual Analysis

### Binary Comparison
```bash
# Byte-by-byte comparison
cmp -l file1 file2

# Side-by-side hex comparison
diff --side-by-side <(xxd file1) <(xxd file2)

# Binary diff with context
diff -u <(hexdump -C file1) <(hexdump -C file2)
```

### Binary Analysis
```bash
# File information
file binary_file
readelf -h binary_file

# String extraction
strings binary_file

# Disassembly
objdump -d binary_file
objdump -t binary_file  # Symbol table

# Section analysis
objdump -h binary_file
readelf -S binary_file
```

### Advanced Tools (if available)
```bash
# Visual binary diff (if vbindiff is installed)
vbindiff file1 file2

# Radare2 binary diff (if radare2 is installed)
radiff2 file1 file2

# Binary analysis with ghidra, IDA Pro, etc.
```

## Learning Resources

### Recommended Reading
- "Practical Binary Analysis" by Dennis Andriesse
- "The IDA Pro Book" by Chris Eagle
- "Reverse Engineering for Beginners" by Dennis Yurichev

### Online Resources
- [Radare2 Documentation](https://radare.gitbooks.io/radare2book/)
- [GNU Binutils Documentation](https://sourceware.org/binutils/docs/)
- [ELF Format Specification](http://www.skyfree.org/linux/references/ELF_Format.pdf)

## Contributing

Feel free to add more sample programs, analysis techniques, or documentation improvements. When adding new samples:

1. Follow the existing naming convention (`sample_program_v*.c`)
2. Update the Makefile to include new targets
3. Add documentation for new techniques
4. Include practical exercises for the new materials

## License

This repository is for educational purposes. Feel free to use and modify the materials for learning binary analysis and reverse engineering.
