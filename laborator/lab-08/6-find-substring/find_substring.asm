%include "../utils/printf32.asm"

section .data
source_text: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCB", 0
substring: db "BABC", 0

print_format: db "Substring found at index: ", 0

section .text
extern printf
extern strstr
global main
main:
    push ebp
    mov ebp, esp

    push substring
    push source_text
    call strstr
    add esp, 8
    push eax
    mov ebx, eax
    push print_format
    call printf
    add esp, 8
    
    iteratie:
        push ebx
        push source_text
        call strstr
        add esp, 8
        cmp eax, 0
        jz end
        push eax
        mov ebx, eax
        push print_format
        call printf
        add esp, 8
        jmp iteratie

    end:
    leave
    ret
