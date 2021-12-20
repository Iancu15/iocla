%include "../utils/printf32.asm"

%define ARRAY_SIZE    10

section .data
    byte_array db 8, 19, 12, 3, 6, 200, 128, 19, 78, 102
    word_array dw 1893, 9773, 892, 891, 3921, 8929, 7299, 720, 2590, 28891
    dword_array dd 1392, 12544, 7992, 6992, 7202, 27187, 28789, 17897, 12988, 17992
    print_format db "Array sum is ", 0
	eex dw 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov ecx, ARRAY_SIZE     ; Use ecx as loop counter.
    xor eax, eax            ; Use eax to store the sum.
    xor edx, edx            ; Store current value in dl; zero entire edx.

add_byte_array_element:

    mov dl, byte [byte_array + ecx - 1]
    add eax, edx
    loop add_byte_array_element ; Decrement ecx, if not zero, add another element.

    PRINTF32 `%s\x0`, print_format
    PRINTF32 `%u\n\x0`, eax

    ; TODO: Compute sum for elements in word_array and dword_array.
	; word_array
	mov ecx, ARRAY_SIZE
	xor eax, eax           
    xor edx, edx
add_word_array_element:

	mov dx, word [word_array + ecx*2 - 2]
    add eax, edx
    loop add_word_array_element ; Decrement ecx, if not zero, add another element.

    PRINTF32 `%s\x0`, print_format
    PRINTF32 `%u\n\x0`, eax

	; dword_array
	mov ecx, ARRAY_SIZE
	xor eax, eax           
    xor edx, edx
	xor ebx, ebx
add_dword_array_element:
	mov eax, dword [dword_array + ecx*4 - 4]
	PRINTF32 `%u\n\x0`, eax
	mov edx, dword [dword_array + ecx*4 - 4]
	mul edx
	PRINTF32 `%u\n\x0`, eax
    add ebx, eax
    loop add_dword_array_element ; Decrement ecx, if not zero, add another element.

    PRINTF32 `%s\x0`, print_format
    PRINTF32 `%u\n\x0`, ebx

    leave
    ret
