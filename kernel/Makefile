# ShuoZi OS — Kernel Makefile
# Phase 0: Bootloader

ASM = nasm
QEMU = qemu-system-x86_64

.PHONY: all boot run clean

all: boot

boot: boot/boot.bin

boot/boot.bin: boot/boot.asm
	$(ASM) -f bin $< -o $@
	@echo "=> boot.bin: $$(wc -c < $@) bytes"

run: boot/boot.bin
	$(QEMU) -drive format=raw,file=boot/boot.bin

clean:
	rm -f boot/boot.bin
