%include "../io.mac"

section .data
    myString: db "Hello, World!", 0
    theString: db "Goodbye, World!", 0

section .text
    global main
    extern printf

main:
    mov ecx, 6                      ; N = valoarea registrului ecx
    mov eax, 1
    mov ebx, 1
    cmp eax, ebx
    je print                        ; TODO1: eax > ebx?
    ret

print:
    PRINTF32 `%s\n\x0`, myString
    sub ecx, 1
    jne print
    PRINTF32 `%s\n\x0`, theString

    ret
