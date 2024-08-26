#ifndef CONSOLE_H
#define CONSOLE_H

// Define our own integer types
typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;

typedef signed char int8_t;
typedef signed short int16_t;
typedef signed int int32_t;
typedef signed long long int64_t;

void console_clear();
void console_write(const char* str);

#endif