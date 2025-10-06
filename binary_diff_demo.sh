#!/bin/bash

# Binary Diffing Practice Script
# This script demonstrates various binary analysis and diffing techniques

echo "=== Binary Analysis and Diffing Practice ==="
echo "This script will demonstrate various techniques for analyzing and comparing binaries"
echo ""

# Make sure binaries exist
if [ ! -f "sample_program_v1" ] || [ ! -f "sample_program_v2" ] || [ ! -f "sample_program_v3" ]; then
    echo "Building sample programs first..."
    make all
    echo ""
fi

echo "1. Basic file information comparison:"
echo "----------------------------------------"
ls -la sample_program_v* | grep -v ".c"
echo ""

echo "2. File size differences:"
echo "-------------------------"
wc -c sample_program_v* | grep -v ".c"
echo ""

echo "3. File type information:"
echo "-------------------------"
file sample_program_v*
echo ""

echo "4. Generating hex dumps for comparison:"
echo "---------------------------------------"
make hexdumps > /dev/null 2>&1
echo "Generated: sample_program_v1.hex, sample_program_v2.hex, sample_program_v3.hex"
echo ""

echo "5. String differences between binaries:"
echo "---------------------------------------"
echo "Strings in v1:"
strings sample_program_v1 | grep -E "(Version|test|Magic|Additional|Binary)"
echo ""
echo "Strings in v2:"
strings sample_program_v2 | grep -E "(Version|test|Magic|Additional|Binary)"
echo ""
echo "Strings in v3:"
strings sample_program_v3 | grep -E "(Version|test|Magic|Additional|Binary)"
echo ""

echo "6. Binary diff using hexdump + diff:"
echo "------------------------------------"
echo "Comparing v1 vs v2 (first 20 lines of diff):"
diff <(hexdump -C sample_program_v1) <(hexdump -C sample_program_v2) | head -20
echo ""

echo "7. Using objdump for disassembly comparison:"
echo "--------------------------------------------"
make disassembly > /dev/null 2>&1
echo "Generated: sample_program_v1.asm, sample_program_v2.asm, sample_program_v3.asm"
echo ""
echo "Function differences (first 10 lines):"
diff sample_program_v1.asm sample_program_v3.asm | head -10
echo ""

echo "8. Entry point analysis:"
echo "------------------------"
echo "V1 entry point:"
objdump -f sample_program_v1 | grep "start address"
echo "V2 entry point:"
objdump -f sample_program_v2 | grep "start address"
echo "V3 entry point:"
objdump -f sample_program_v3 | grep "start address"
echo ""

echo "9. Section information:"
echo "----------------------"
echo "V1 sections:"
objdump -h sample_program_v1 | grep -E "\.text|\.data|\.rodata" | head -3
echo "V3 sections:"
objdump -h sample_program_v3 | grep -E "\.text|\.data|\.rodata" | head -3
echo ""

echo "10. Symbol table differences:"
echo "-----------------------------"
echo "V1 symbols (first 5):"
objdump -t sample_program_v1 | grep -E "FUNC|OBJECT" | head -5
echo "V3 symbols (first 5):"
objdump -t sample_program_v3 | grep -E "FUNC|OBJECT" | head -5
echo ""

echo "=== Binary Diffing Practice Complete ==="
echo "Files generated for further analysis:"
echo "- *.hex files: Hexadecimal dumps"
echo "- *.asm files: Disassembly output"
echo ""
echo "Try these additional commands:"
echo "- vbindiff sample_program_v1 sample_program_v2  (if available)"
echo "- radiff2 sample_program_v1 sample_program_v2   (if radare2 available)"
echo "- cmp -l sample_program_v1 sample_program_v2    (byte-by-byte comparison)"