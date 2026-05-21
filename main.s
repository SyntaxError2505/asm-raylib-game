.extern InitWindow
.extern WindowShouldClose
.extern CloseWindow
.extern SetTargetFPS

.section .rodata
screenWidth: .long 800
screenHeight: .long 450
screenName: .string "ASM btw"
worksMessage: .string "working\n"

.section .text
    .globl main
    .type main, @function

# if you dont know what it does, you could be kinda stupid

game_loop:
    subq $8, %rsp
    #look if the loop is running
    mov $worksMessage, %rdi
    xor %al, %al
    call printf

    call WindowShouldClose
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

    call InitWindow
    call game_loop

    call CloseWindow
    addq $8, %rsp
    ret
