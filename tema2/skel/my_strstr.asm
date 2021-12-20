%include "io.mac"

section .text
    global my_strstr
    extern printf

section .data
	haystack_len dd 0
	needle_len dd 0

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

inceput:
	; eliberez ecx si edx pentru a-i folosi drept contoare
    mov [haystack_len], ecx
	mov [needle_len], edx
	xor ecx, ecx
	xor edx, edx
	xor eax, eax
	
iteratie:
	mov eax, [esi + ecx]
	cmp al, byte [ebx + edx]
	jz egalitate
	sub ecx, edx
	; resetez contorul needle-lului
	xor edx, edx

incrementare:
	inc ecx
	cmp byte [haystack_len], cl
	jnz iteratie
	jmp de_negasit

egalitate:
	inc edx
	cmp byte [needle_len], dl
	jz egalitate_absoluta
	jmp incrementare

egalitate_absoluta:
	mov [edi], ecx
	; aduc pointerul la inceputul subsirului
	sub [edi], edx
	; off-by-one error, a trebuit sa incrementez
	inc byte [edi]
	jmp sfarsit

de_negasit:
	; incrementez contorul pentru a pointa la caracterul null
	inc ecx
	mov [edi], ecx
	
sfarsit:

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
