%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

inceput:
	dec ecx

iteratie:
	; -3 = -4 de la offset + 1 pentru a compensa decrementarea de mai sus
	mov ebx, [esi + ecx - 3]
	xor ebx, [edi + ecx - 3]
	mov [edx + ecx - 3], ebx
	sub ecx, 4
	js sfarsit
	jmp iteratie

sfarsit:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
