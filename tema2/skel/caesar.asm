%include "io.mac"

section .text
    global caesar
    extern printf

section .data
	key dd 0	

caesar:
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
	mov eax, edi
	mov bl, 26
	idiv bl
	; in AH a ajuns restul
	mov al, ah
	xor ah, ah
	mov [key], eax

iteratie:
	mov edi, [key]
	mov ebx, [esi + ecx - 1]
	cmp bl, 65
	jb adauga_char
	cmp bl, 90
	jbe majuscule
	ja non_majuscule

majuscule:
	mov al, 90
	sub al, bl
	cmp eax, edi
	jae rotire
	sub edi, eax
	mov ebx, 64
	jmp rotire

non_majuscule:
	cmp bl, 97
	jb adauga_char
	cmp bl, 122
	jbe minuscule
	jmp adauga_char

minuscule:
	mov al, 122
	sub al, bl
	cmp eax, edi
	jae rotire
	sub edi, eax
	mov ebx, 96

rotire:
	add ebx, edi

adauga_char:
	mov [edx + ecx - 1], bl
	loop iteratie

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
