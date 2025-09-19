#!/bin/bash

# Advanced Binary Diffing Techniques
# Demonstrates specific methods for analyzing binary differences

echo "=== Advanced Binary Diffing Techniques ==="
echo ""

# Check if programs exist
if [ ! -f "sample_program_v1" ]; then
    make all > /dev/null 2>&1
fi

echo "1. Byte-by-byte comparison with cmp:"
echo "------------------------------------"
echo "Comparing v1 and v2:"
cmp -l sample_program_v1 sample_program_v2 | head -10
echo "... (showing first 10 differences)"
echo ""

echo "2. Raw binary diff with specific tools:"
echo "---------------------------------------"
echo "Using xxd to create side-by-side hex comparison:"
echo "V1 (first 16 bytes):"
xxd sample_program_v1 | head -1
echo "V2 (first 16 bytes):"
xxd sample_program_v2 | head -1
echo ""

echo "3. String extraction and comparison:"
echo "------------------------------------"
echo "Extracting all strings and comparing:"
strings sample_program_v1 > /tmp/strings_v1.txt
strings sample_program_v2 > /tmp/strings_v2.txt
strings sample_program_v3 > /tmp/strings_v3.txt

echo "New strings in v2 compared to v1:"
diff /tmp/strings_v1.txt /tmp/strings_v2.txt | grep "^>"
echo ""
echo "New strings in v3 compared to v2:"
diff /tmp/strings_v2.txt /tmp/strings_v3.txt | grep "^>"
echo ""

echo "4. Function analysis:"
echo "---------------------"
echo "Functions in v1:"
objdump -t sample_program_v1 | grep -w "F" | awk '{print $6}' | grep -v "^$"
echo ""
echo "Functions in v3:"
objdump -t sample_program_v3 | grep -w "F" | awk '{print $6}' | grep -v "^$"
echo ""

echo "5. Code section size comparison:"
echo "--------------------------------"
echo "Text section sizes:"
objdump -h sample_program_v1 | grep "\.text" | awk '{print "V1: " $3}'
objdump -h sample_program_v2 | grep "\.text" | awk '{print "V2: " $3}'
objdump -h sample_program_v3 | grep "\.text" | awk '{print "V3: " $3}'
echo ""

echo "6. Entropy analysis (basic):"
echo "----------------------------"
echo "File sizes (as proxy for complexity):"
stat -c "%s bytes" sample_program_v1 | sed 's/^/V1: /'
stat -c "%s bytes" sample_program_v2 | sed 's/^/V2: /'
stat -c "%s bytes" sample_program_v3 | sed 's/^/V3: /'
echo ""

echo "7. Library dependencies:"
echo "------------------------"
echo "V1 dependencies:"
ldd sample_program_v1 2>/dev/null | head -3
echo "V3 dependencies:"
ldd sample_program_v3 2>/dev/null | head -3
echo ""

echo "8. Binary header analysis:"
echo "--------------------------"
echo "ELF header comparison:"
readelf -h sample_program_v1 | grep -E "(Entry point|Size of this header)"
readelf -h sample_program_v3 | grep -E "(Entry point|Size of this header)"
echo ""

echo "9. Creating visual diff of hex dumps:"
echo "------------------------------------"
echo "Use these commands for visual comparison:"
echo "diff -u <(xxd sample_program_v1) <(xxd sample_program_v2) | head -20"
echo ""
echo "Or for side-by-side:"
echo "diff --side-by-side <(xxd sample_program_v1 | head -10) <(xxd sample_program_v2 | head -10)"
echo ""

echo "10. Quick binary signature check:"
echo "---------------------------------"
echo "Magic bytes (ELF signature):"
xxd sample_program_v1 | head -1 | cut -d: -f2 | cut -d' ' -f1-5
echo ""

# Cleanup
rm -f /tmp/strings_v*.txt

echo "=== Advanced Binary Diffing Complete ==="