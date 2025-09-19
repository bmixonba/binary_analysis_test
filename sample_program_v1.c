#include <stdio.h>
#include <string.h>

int main() {
    printf("Hello, Binary Analysis!\n");
    printf("Version: 1.0\n");
    
    char buffer[256];
    strcpy(buffer, "This is a test string");
    printf("Buffer content: %s\n", buffer);
    
    int result = 42;
    printf("Magic number: %d\n", result);
    
    return 0;
}