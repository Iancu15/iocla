%include "../utils/printf32.asm"

struc my_struct
    int_x: resb 4
    char_y: resb 1
    string_s: resb 32
endstruc

section .data
    string_format db "%s", 10, 0
    int_format db "%d", 10, 0
    char_format db "%c", 10, 0

    sample_obj:
        istruc my_struct
            at int_x, dd 1000
            at char_y, db 'a'
            at string_s, db 'My string is better than yours', 0
        iend

    new_int dd 2000
    new_char db 'b'
    new_string db 'Are you sure?', 0

section .text
extern printf
global main

get_int:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]
    add eax, int_x
    mov eax, [eax]
    leave
    ret

get_char:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]
    add eax, char_y
    mov eax, [eax]
    leave
    ret

get_string:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    add eax, string_s
    mov eax, [eax]

    leave
    ret

set_int:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    add eax, int_x
    mov ebx, [ebp + 12]
    mov [eax], ebx

    leave
    ret

set_char:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    add eax, char_y
    mov ebx, [ebp + 12]
    mov [eax], ebx

    leave
    ret

set_string:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    add eax, string_s
    mov ebx, [ebp + 12]
    mov [eax], ebx

    leave
    ret

main:
    push ebp
    mov ebp, esp

    mov edx, [new_int]
    push edx
    push sample_obj
    call set_int
    add esp, 8

    push sample_obj
    call get_int
    add esp, 4

    ;uncomment when get_int is ready
    push eax
    push int_format
    call printf
    add esp, 8

    movzx edx, byte [new_char]
    ; movzx is the same as
    xor edx, edx
    mov dl, byte [new_char]
    push edx
    push sample_obj
    call set_char
    add esp, 8

    push sample_obj
    call get_char
    add esp, 4

    ;uncomment when get_char is ready
    push eax
    push char_format
    call printf
    add esp, 8

    mov edx, new_string
    push edx
    push sample_obj
    call set_string
    add esp, 8

    push sample_obj
    call get_string
    add esp, 4

    ;uncomment when get_string is ready
    push eax
    push string_format
    call printf
    add esp, 8

    xor eax, eax
    leave
    ret
