[org 0x7c00]

[bits 16]
	jmp boot_entry

%include "str.asm"
%include "gdt.asm"

ldkernel:		; loads al sectors to es:bx from drive dl
	mov ah,0x2
	mov ch,0x0
	mov cl,0x1
	mov dh,0x0
	int 0x13
	jne disk_error
	ret

disk_error:
	mov bx,DISK_ERROR_MSG
	call print_16bit
	ret

boot_entry:
	mov ax,0x3	; set vmode to 3h incase bios does anything (80x25)
	int 0x10
	mov bx,BTLD_START_MSG
	call print_16bit
	mov bx,0x1000
	mov es,bx
	mov bx,0
	call ldkernel	; load kernel into 0x10000
	mov bx,0
	mov es,bx
	mov bx,BTLD_LOADP_MSG
	call print_16bit
	mov ax,0x2401
	int 0x15
	cli		; switch to pmode
	lgdt [gdt_pointer]
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax
	jmp CODE_SEG:bootp_entry

[bits 32]
bootp_entry:
	mov ax,DATA_SEG
	mov ds,ax
	mov ss,ax
	mov es,ax
	mov fs,ax
	mov gs,ax
	mov ebp,0x90000
	mov esp,ebp
	mov ebx,BT32_START_MSG
	call print_32bit
	jmp 0x10000

times 510-($-$$) db 0
dw 0xaa55
