# Binary Analysis Quick Reference

## Essential Commands

### File Information
```bash
file binary_file              # Identify file type
ls -la binary_file            # File size and permissions
stat binary_file              # Detailed file information
```

### String Analysis
```bash
strings binary_file           # Extract printable strings
strings -n 8 binary_file      # Strings of minimum 8 characters
strings -t x binary_file      # Show offset in hex
```

### Hex Analysis
```bash
xxd binary_file               # Hex dump with ASCII
hexdump -C binary_file        # Canonical hex+ASCII display
od -t x1 binary_file          # Octal dump in hex bytes
```

### Binary Comparison
```bash
cmp file1 file2               # Compare files byte by byte
cmp -l file1 file2            # List all differences
diff <(xxd file1) <(xxd file2) # Hex diff
```

### ELF Analysis
```bash
readelf -h binary_file        # ELF header
readelf -S binary_file        # Section headers
readelf -s binary_file        # Symbol table
objdump -h binary_file        # Section headers (alternative)
objdump -t binary_file        # Symbol table (alternative)
objdump -d binary_file        # Disassembly
```

### Advanced Analysis
```bash
ldd binary_file               # Library dependencies
nm binary_file                # Symbol names
size binary_file              # Section sizes
strip binary_file             # Remove symbols
```

## Quick Diff Workflows

### Basic Binary Diff
1. `cmp -l file1 file2 | head -10`
2. `diff <(strings file1) <(strings file2)`
3. `diff <(xxd file1) <(xxd file2) | head -20`

### Structural Diff
1. `objdump -h file1 > file1.sections`
2. `objdump -h file2 > file2.sections`
3. `diff file1.sections file2.sections`

### Function Diff
1. `objdump -t file1 | grep -w F > file1.functions`
2. `objdump -t file2 | grep -w F > file2.functions`
3. `diff file1.functions file2.functions`

## Common Analysis Patterns

### Find New Strings
```bash
comm -23 <(strings file2 | sort) <(strings file1 | sort)
```

### Size Growth Analysis
```bash
echo "File1: $(stat -c%s file1) bytes"
echo "File2: $(stat -c%s file2) bytes"
echo "Growth: $(($(stat -c%s file2) - $(stat -c%s file1))) bytes"
```

### Entry Point Comparison
```bash
readelf -h file1 | grep "Entry point"
readelf -h file2 | grep "Entry point"
```