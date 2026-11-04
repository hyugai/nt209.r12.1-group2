#include <stdio.h>
#include <string.h>

/*
 * Helper functions
 * */
void PrintBits(unsigned int x) {
    int i;
    for (i = 8 * sizeof(x) - 1; i >= 0; i--) {
        (x & (1 << i)) ? putchar('1') : putchar('0');
    }
    printf("\n");
}
void PrintBitsOfByte(unsigned int x) {
    int i;
    for (i = 7; i >= 0; i--) {
        (x & (1 << i)) ? putchar('1') : putchar('0');
    }
    printf("\n");
}
unsigned f2u(float f) {
    unsigned u;
    memcpy(&u, &f, sizeof u);
    return u;
}
float u2f(unsigned u) {
    float f;
    memcpy(&f, &u, sizeof f);
    return f;
}
/*
 * End helper functions
 * */

/*
 * Assignment 1.1 to 1.6
 * */

// 1.1
int negative(int x) { return (x ^ -1) + 1; }

// 1.2
int cal50x(int x) { return (x << 5) + (x << 4) + (x << 1); }

// 1.3
int getByte(int x, int n) {
    int mask = 0xFF;
    int shift_count = n << 3;

    return (x >> shift_count) & mask;
}

// 1.4
int flipByte(int x, int n) {
    int mask = 0xFF;
    int shifted_mask = mask << (n << 3);

    return x ^ shifted_mask;
}

// 1.5
int divpw2(int x, int n) {
    int tmp = ~n + 1;

    return x << tmp;
}

// 1.6
int divpw2s(int x, int n) {
    int mask = x >> 31;
    int bias = mask & ((1 << n) - 1);

    return (x + bias) >> n;
}

/*
 * Assignment 2.1 to 2.6
 * */

// 2.1
int isOpposite(int x, int y) { return !(x ^ (~y + 1)) & !!(x ^ y); }

// 2.2
int is16x(int x) { return !(x & 15); }

// 2.3
int isPositive(int x) {
    int y = x >> 31;
    int isZero = !x;

    return !(y | isZero);
}

// 2.4
int isGE2(int x, int n) {
    int y = 1 << n;
    int z = ~y + 1;
    int u = (x + z) >> 31;

    return !u;
}

// 2.5
int subOK(int x, int y) {
    int kq = x + (~y + 1);

    int sx = (x >> 31);
    int sy = (y >> 31);
    int skq = (kq >> 31);

    return !((sx ^ sy) & (skq ^ sx));
}

// 2.6
int bitParity(int x) {
    x = x ^ (x >> 16);
    x = x ^ (x >> 8);
    x = x ^ (x >> 4);
    x = x ^ (x >> 2);
    x = x ^ (x >> 1);

    return x & 1;
}

/*
 * Assignment 3.1 to 3.4
 * */
// 3.1
unsigned float_negate(unsigned uf) {
    unsigned exp = (uf >> 23) & 0xff, frac = uf & 0x7fffff;

    if (exp == 0xff && frac != 0) {
        return uf;
    }

    return uf ^ 0x80000000;
}

// 3.2
unsigned float_absval(unsigned uf) {
    unsigned exp = (uf >> 23) & 0xff, frac = uf & 0x7fffff;

    if (exp == 0xff && frac != 0) {
        return uf;
    }

    return uf & 0x7fffffff;
}

// 3.3
unsigned float_twice(unsigned uf) {
    unsigned sign = uf & 0x80000000;
    unsigned exp = (uf >> 23) & 0xFF;
    unsigned frac = uf & 0x007FFFFF;

    if (exp == 0xFF)
        return uf;
    if (exp == 0)
        return sign | ((uf & 0x7FFFFFFF) << 1);
    exp = exp + 1;
    if (exp == 0xFF)
        return sign | 0x7F800000;

    return sign | (exp << 23) | frac;
}

// 3.4
int float_f2i(unsigned uf) {
    int sign = uf >> 31;
    int frac = (uf & 0x7FFFFF) | 0x800000;
    int exp = (uf >> 23) & 0xFF;
    int E = exp - 127;

    if (E < 0)
        return 0;
    if (E >= 31)
        return 0x80000000;
    if (E > 23)
        frac = frac << (E - 23);
    else
        frac = frac >> (23 - E);

    if (sign)
        return -frac;

    return frac;
}
