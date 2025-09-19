#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// Added a new function
void print_banner() {
    printf("=== Binary Analysis Practice ===\n");
}

int main() {
    print_banner();  // Call new function
    
    printf("Hello, Binary Analysis!\n");
    printf("Version: 3.0\n");
    
    char buffer[512];  // Increased buffer size
    strcpy(buffer, "This is a completely different test string for v3");
    printf("Buffer content: %s\n", buffer);
    
    int result = 168;  // Changed again
    printf("Magic number: %d\n", result);
    
    printf("Additional feature in v2\n");
    printf("Even more features in v3!\n");
    
    // Added dynamic allocation
    int *dynamic_value = malloc(sizeof(int));
    *dynamic_value = 999;
    printf("Dynamic value: %d\n", *dynamic_value);
    free(dynamic_value);
    
    return 0;
}