%include "../io.mac"

section .text
    global main
    extern printf

main:
    mov eax, 2       ; vrem sa aflam al N-lea numar; N = 7
	mov ecx, 0
	mov edx, 1
	dec eax

    ; TODO: calculati al N-lea numar fibonacci (f(0) = 0, f(1) = 1)

iteratie:
	mov ebx, ecx
	mov ecx, edx
	mov edx, ebx
	add edx, ecx
	dec eax
	jz print
	jmp iteratie

print:
	PRINTF32 `%d\n\x0`, edx

    ret
