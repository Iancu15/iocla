%include "../utils/printf32.asm"

section .text

extern printf
global main
main:
    ; numbers are placed in these two registers
    mov eax, 4
    mov ebx, 5

    ; TODO: get maximum value. You are only allowed to use one conditional jump and push/pop instructions.
	push ebx
	cmp eax, ebx
	jb ceva
	push eax

ceva:
	pop eax
    PRINTF32 `Max value is: %d\n\x0`, eax ; print maximum value
	pop ebx

    ret
