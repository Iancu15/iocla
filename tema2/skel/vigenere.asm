%include "io.mac"

section .text
    global vigenere
    extern printf

section .data
	plaintext_len dd 0
	key_len dd 0
	rot_number dd 0

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha
	
    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

	; voi avea nevoie de ecx si ebx asa ca le golesc
	; ecx contor pentru cheie, eax contor pentru text
inceput:
	mov [plaintext_len], ecx
	mov [key_len], ebx
	xor ebx, ebx
	xor ecx, ecx
	mov eax, 0
	
	; bag cheia extinsta in chipertext, voi inlocui dupa cu ciphertext-ul
iteratie_ext:
	mov bl, byte [edi + ecx]
	cmp byte [esi + eax], 65
	jb caractere_speciale
	cmp byte [esi + eax], 122	
	ja caractere_speciale
	cmp byte [esi + eax], 90
	ja posibil_minuscule

incrementare:
	inc ecx
	cmp [key_len], ecx
	; daca s-a ajuns la finalul cheii resetez contorul
	jnz continua
	xor ecx, ecx
	jmp continua

posibil_minuscule:
	cmp byte [esi + eax], 97
	jae incrementare

	; adaug space pe pozitiile nefolosite
caractere_speciale:
	mov ebx, 32

continua:
	mov byte [edx + eax], bl
	inc eax
	cmp [plaintext_len], eax
	jnz iteratie_ext
	mov ecx, [plaintext_len]

iteratie:
	mov al, [edx + ecx - 1]
	sub al, 65
	mov [rot_number], al
	mov ebx, [esi + ecx - 1]
	cmp bl, 65
	jb adauga_char
	cmp bl, 90
	jbe majuscule
	ja non_majuscule

majuscule:
	mov al, 90
	sub al, bl
	cmp al, [rot_number]
	jae rotire
	sub [rot_number], al
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
	cmp al, [rot_number]
	jae rotire
	sub [rot_number], al
	mov ebx, 96

rotire:
	add ebx, [rot_number]

adauga_char:
	mov [edx + ecx - 1], bl
	loop iteratie

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
