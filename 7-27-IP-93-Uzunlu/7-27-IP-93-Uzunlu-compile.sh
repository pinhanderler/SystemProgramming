nasm -f elf64 lab7.asm
nasm -f elf64 denom.asm
gcc -no-pie -nostartfiles lab7.o denom.o -o lab7
