DISK_ERROR_MSG: db 'Disk Error',0
BTLD_START_MSG: db 'IMOS Bootloader',0
BT32_START_MSG: db 'PMode enabled',0
BTLD_LOADP_MSG: db 'Loading pmode',0

print_16bit:
	pusha
	mov ah,0x0e
.loop_16bit:
	mov al,[bx]
	int 0x10
	add bx,1
	cmp al,0
	jne .loop_16bit
	popa
	ret

VIDEO_MEMORY: equ 0xb8000
VIDEO_PTR: db VIDEO_MEMORY
WHITE_ON_BLACK: equ 0x0f

[bits 32]

print_32bit:
	pusha
	mov edx,[VIDEO_PTR]
.loop_32bit:
	mov al,[ebx]
	mov ah,WHITE_ON_BLACK
	cmp al,0
	je .done_32bit
	mov [edx],ax
	add ebx,1
	add edx,2
	jmp .loop_32bit
.done_32bit:
	popa
	ret

[bits 16]
