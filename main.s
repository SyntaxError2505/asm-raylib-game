.extern InitWindow
.extern WindowShouldClose
.extern CloseWindow
.extern SetTargetFPS

.section .rodata
screenWidth: .long 800
screenHeight: .long 450

.section .text
    .globl main
    .type main, @function

# if you dont know what it does, you could be kinda stupid
#
main:
    subq $8, %rsp
    mov $60, %rdi
    call SetTargetFPS
    addq $8, %rsp
    ret
