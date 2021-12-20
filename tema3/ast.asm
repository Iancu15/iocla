
section .rodata
    operations db "+-*/", 0

section .data
    is_negative dd 0
    token dd 0
    len_atoi dd 0
    counter dd 0
    counter_atoi dd 0
    counter_recursive dd 0
    delim db " ", 10, 0
    ; offset pentru adresele token-urilor
    tokens dd 0

section .text

extern check_atoi
extern print_tree_inorder
extern print_tree_preorder
extern evaluate_tree
extern strlen
extern strtok
extern malloc
extern strchr
extern strdup

global create_tree
global iocla_atoi

iocla_atoi:
    push ebp
    mov ebp, esp
    mov edx, [ebp + 8]

    ; conform conventiei pastrarea ebx-ului este treaba apelatului
    push ebx
    xor ebx, ebx
    mov dword [is_negative], 0

    ; calculez lungimea sirului
    mov dword [token], edx
    push dword edx
    call strlen
    add esp, 4
    mov edx, [token]
    mov [len_atoi], eax
    xor eax, eax
    mov dword [counter_atoi], 0

    ; testez daca numarul e negativ
    cmp byte [edx], 45
    jnz iteration_atoi
    inc dword [is_negative]
    inc dword [counter_atoi]

    iteration_atoi:
        ; adaug caracterul iteratiei curente in numar
        imul eax, 10
        mov ecx, [counter_atoi]
        mov byte bl, [edx + ecx]
        sub bl, 48
        add eax, ebx

        ; daca s-a ajuns la finalul sirului ies din loop
        inc dword [counter_atoi]
        mov ecx, [counter_atoi]
        cmp ecx, dword [len_atoi]
        jnz iteration_atoi

    ; neg numarul daca este negativ
    cmp dword [is_negative], 0
    jz end_atoi
    neg eax

    end_atoi:
        pop ebx
    
    leave
    ret

create_tree_recursive:
    push ebp
    mov ebp, esp
    xor eax, eax

    ; verific daca tokenul e operator
    mov ecx, [counter_recursive]
    mov eax, [tokens + ecx * 4]
    push dword [eax]
    push operations
    call strchr
    add esp, 8

    ; urc token-ul pe stiva
    mov ecx, [counter_recursive]
    push dword [tokens + ecx * 4]
    inc dword [counter_recursive]
    xor ebx, ebx
    xor edi, edi

    ; daca token-ul e operand sar la fill_node
    cmp eax, 0
    jz fill_node

    ; numerele negative care se strecoara aici sunt redirectionate la fill_node
    mov ebx, [tokens + ecx * 4]
    push ebx
    call strlen
    add esp, 4
    xor ebx, ebx
    xor edi, edi
    cmp eax, 1
    jg fill_node

    ; creez nodul stang al operatorului si il urc pe stiva
    call create_tree_recursive
    push eax

    ; creez nodul drept al operatorului
    call create_tree_recursive
    mov ebx, eax

    ; scot de pe stiva adresa fiului stang
    pop edi

    fill_node:
        ; aloc memorie pentru nod, adresa nodului se afla in eax
        push 12
        call malloc
        add esp, 4

        ; adaug token-ul corespunzator nodului, fiul stang si fiul drept
        pop dword [eax]
        mov [eax + 4], edi
        mov [eax + 8], ebx

    leave
    ret

create_tree:
    push ebp
    mov ebp, esp

    ; folosesc ebx si edi asa ca urc pe stiva valorile stocate de apelant in ele
    push ebx
    push edi
    mov edi, dword [ebp + 8]

    ; stochez in ebx primul token din sir
    push delim
    push edi
    call strtok
    add esp, 8

    ; fac o copie pe heap a token-ului si ii stochez adresa in variabila tokens
    push eax
    call strdup
    add esp, 4
    mov [tokens], eax
    mov dword [counter], 1

    create_tokens:
        ; iau urmatorul token
        push delim
        push 0
        call strtok
        add esp, 8

        ; ca sa nu accesez memorie nepermisa fac verificarea inainte de mutare
        cmp eax, 0
        jz make_tree

        ; fac o copie a token-ului si o stochez in zona adreselor de dupa tokens
        push eax
        call strdup
        add esp, 4
        mov ecx, [counter]
        mov [tokens + ecx * 4], eax
        inc dword [counter]
        jmp create_tokens

    make_tree:
        call create_tree_recursive

    pop edi
    pop ebx
    leave
    ret
