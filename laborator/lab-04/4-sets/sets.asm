%include "../io.mac"

section .text
    global main
    extern printf

main:
    ;cele doua multimi se gasesc in eax si ebx
    mov eax, 139
    mov ebx, 169
	PRINTF32 `Multimea 1: \x0`
    PRINTF32 `%u\n\x0`, eax ; 0 1 3 7
	PRINTF32 `Multimea 2: \x0`
    PRINTF32 `%u\n\x0`, ebx ; 0 3 5 7

    ; TODO1: reuniunea a doua multimi
	mov ecx, eax
	or ecx, ebx
	PRINTF32 `Reuniunea: \x0`
	PRINTF32 `%u\n\x0`, ecx ; 0 1 3 5 7

    ; TODO2: adaugarea unui element in multime
	mov edx, 3
	shl edx, 9
	or ecx, edx
	PRINTF32 `Adaugarea elementelor 9 si 10 la reuniune: \x0`
	PRINTF32 `%u\n\x0`, ecx ; 0 1 3 5 7 9 10

    ; TODO3: intersectia a doua multimi
	mov edx, eax
	and edx, ebx
	PRINTF32 `Intersectia: \x0`
	PRINTF32 `%u\n\x0`, edx ; 0 3 7

    ; TODO4: complementul unei multimi
	mov ecx, eax
	not ecx
	PRINTF32 `Complementul multimii 1: \x0`
	PRINTF32 `%u\n\x0`, ecx ; 2 4 5 6 8 9 10 ... 31

    ; TODO5: eliminarea unui element
	mov ecx, 1
	shl ecx, 3
	xor eax, ecx
	PRINTF32 `Multimea 1 fara elementul 3: \x0`
	PRINTF32 `%u\n\x0`, eax ; 0 1 7

    ; TODO6: diferenta de multimi EAX-EBX
	mov edx, eax
	and edx, ebx
	mov ecx, eax
	xor ecx, edx
	PRINTF32 `Diferenta dintre multimea 1 si 2: \x0`
	PRINTF32 `%u\n\x0`, ecx ; 1

	xor ebx, ebx
    xor eax, eax
	xor ecx, ecx
	xor edx, edx
    ret
