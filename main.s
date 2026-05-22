.extern InitWindow
.extern WindowShouldClose
.extern CloseWindow
.extern SetTargetFPS
.extern printf

.extern BeginDrawing
.extern DrawCircle
.extern EndDrawing
.extern ClearBackground

.section .rodata
screenWidth: .long 800
screenHeight: .long 450
screenName: .string "ASM btw"
printint: .string "%i\n"

.section .text
    .globl main
    .type main, @function

# if you dont know what it does, you could be kinda stupid

printdbg:
    xorq %rax, %rax
    mov %rdi, %rsi
    mov $printint, %rdi
    call printf

qword_from_4_bytes:
    xorq %rax, %rax
    mov %dil, %al
    shlq $8, %rax
    mov %sil, %al
    shlq $8, %rax
    mov %dl, %al
    shlq $8, %rax
    mov %cl, %al
    ret

game_loop:
    subq $8, %rsp
    # Draw calls inside here
    call BeginDrawing

    # Define a color struct (4*8bit in rdi representing rgba)
    mov $255, %dil
    mov $50, %sil
    mov $50, %dl
    mov $50, %cl
    call qword_from_4_bytes

    # make background red
    movq %rax, %rdi
    call ClearBackground

    # draw circle
    # calculate its colour
    mov $255, %dil
    mov $255, %sil
    mov $0, %dl
    mov $0, %cl
    call qword_from_4_bytes
    mov %rax, %rdx

    # calculate position and radius
    
    movq $400, %rdi
    movq $250, %rsi
    movl $50, %eax
    cvtsi2ss %rax, %xmm0

    # draw it
    call DrawCircle

    mov $5, %rdi
    call printdbg

    call EndDrawing
    
    # Check if the window needs to close
    call WindowShouldClose
    addq $8, %rsp
    testl %eax, %eax
    jz game_loop
    ret

main:
    # set up by setting fps and creating the window
    subq $8, %rsp
    mov $60, %rdi
    call SetTargetFPS

    # set up window
    movl $screenWidth, %edi
    movl (%edi), %edi
    movl $screenHeight, %esi
    movl (%esi), %esi
    movq $screenName, %rdx

    # Push y and x to stack
    pushq $400
    pushq $250

    call InitWindow
    call game_loop

    call CloseWindow
    addq $8, %rsp
    ret
