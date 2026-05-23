; ============================================================
; ShuoZi OS — Phase 0, Step 1: MBR Bootloader
;
; BIOS 把 512 字节的第一个扇区加载到 0x7C00 并跳过来。
; 这段代码做的事：
;   1. 清屏幕
;   2. 打印 "ShuoZi OS"
;   3. 死循环（halt）
;
; 编译: nasm -f bin boot.asm -o boot.bin
; 运行: qemu-system-x86_64 -drive format=raw,file=boot.bin
; ============================================================

[org 0x7C00]          ; BIOS 把 MBR 加载到 0x7C00
[bits 16]             ; CPU 通电后是 16 位实模式

start:
    ; 清屏幕
    mov ax, 0x0003
    int 0x10

    ; 设数据段
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; 设栈（从 0x7C00 向下长）
    mov ss, ax
    mov sp, 0x7C00

    ; 打印消息
    mov si, msg
.loop:
    lodsb               ; 从 [si] 读一个字节到 al，si++
    or al, al           ; al == 0?
    jz .halt            ; 是 → 结束
    mov ah, 0x0E        ; BIOS 打印一个字符
    int 0x10
    jmp .loop

.halt:
    cli
    hlt
    jmp .halt

msg: db "ShuoZi OS", 0

; 填到 510 字节，最后 2 字节写签名 0x55 0xAA
times 510 - ($ - $$) db 0
dw 0xAA55
