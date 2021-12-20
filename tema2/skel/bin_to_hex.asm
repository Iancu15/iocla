%include "io.mac"

section .text
    global bin_to_hex
    extern printf

section .data
	hex_chars: dd "0123456789ABCDEF", 0
	contor_biti dd 0
	op_inmultire dw 1
	hex_number dd 0
	number_of_hexes dd 0

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

	; label-urile inmultire_bit, test_conditie, adauga_hex,
	; sfarsit_hex si inceput sunt pur estetice
inceput:
	mov al, cl
	mov bl, 4
	idiv bl
	cmp ah, 0
	jz rest_zero
	jmp numarare
	
	; daca se imparte fix 4, atunci catul va fi cu 1 mai mult
rest_zero:
	dec al

numarare:
	xor ah, ah
	; adaug newline la final, LF in ascii e 10
	mov byte [edx + eax + 1], 10
	mov byte [number_of_hexes], al

	; trebuie sa calculez si ultimul octet procesat
iteratie:
	cmp ecx, 0
	jz inceput_hex
	mov bl, byte [esi + ecx - 1]
	sub bl, 48

inmultire_bit:
	imul bx, [op_inmultire]
	add [hex_number], bl
	mov bx, word [op_inmultire]
	imul bx, 2
	mov word [op_inmultire], bx 

test_conditie:
	dec ecx
	inc byte [contor_biti]
	cmp byte [contor_biti], 4
	jnz iteratie

inceput_hex:
	mov word [op_inmultire], 1
	mov byte [contor_biti], 0
	xor ebx, ebx

adauga_hex:
	mov bl, [hex_number]
	mov al, byte [hex_chars + ebx]
	mov byte [hex_number], 0
	mov bl, [number_of_hexes]
	mov byte [edx + ebx], al

sfarsit_hex:
	dec byte [number_of_hexes]
	cmp ecx, 0
	jz sfarsit
	jmp iteratie

sfarsit:

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFYx
