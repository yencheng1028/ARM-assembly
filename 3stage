;The following is ARM251 assembly language 
;The screen image is printed out as a string
;You can use the 'a' button and the 'd' button to control @ to move left and right
;Please imitate my program and add in my program that you can press w and s to control @ to move up and down
;

AREA	Goalkeeper,CODE,READONLY
SWI_WriteC	EQU	&0
SWI_Exit	EQU	&11
SWI_ReadC	EQU	&4
SWI_Write0	EQU	&2
SWI_Clock	EQU	&61
FLASH		EQU	70
SWI_Time	EQU	&63
		ENTRY

START	
	MOV r3,#3
	MOV r4,#" "
	ADR r1,SCR4
LOOP	ADR r0,SCRBG
	SWI SWI_Write0
	SWI SWI_ReadC		; Read keyboard input
	CMP r0, #'a'		; If input is 'a'
	BEQ MOVE_LEFT
	CMP r0, #'d'		; If input is 'd'
	BEQ MOVE_RIGHT
	CMP r0, #'w'		; If input is 'w'
	BEQ MOVE_UP
	CMP r0, #'s'		; If input is 's'
	BEQ MOVE_DOWN
	B LOOP				; Otherwise, read keyboard input again

MOVE_LEFT
	CMP r3, #3				; If already at the left boundary, do not move
	BLE LOOP
	ADD r2,r1,r3			; Position of "@"
	LDRB r0,[r2]			; Store "@" in r0
	STRB r4,[r2]			; Write " " to r2
	SUB r3,r3,#3			; Move "@" 3 positions to the left
	ADD r2,r1,r3
	STRB r0,[r2]		
	B LOOP

MOVE_RIGHT
	CMP r3, #32				; If already at the right boundary, do not move
	BGE LOOP
	ADD r2,r1,r3			; Position of "@"
	LDRB r0,[r2]			; Store "@" in r0
	STRB r4,[r2]			; Write " " to r2
	ADD r3,r3,#3			; Move "@" 3 positions to the right
	ADD r2,r1,r3
	STRB r0,[r2]		
	B LOOP

MOVE_UP
	LDR r5, =SCR1		; Load the address of SCR1 into r5
	CMP r1, r5			; If already at the top boundary, do not move
	BLE LOOP
	ADD r2,r1,r3			; Position of "@"
	LDRB r0,[r2]			; Store "@" in r0
	STRB r4,[r2]			; Write " " to r2
	SUB r1,r1,#52			; Move "@" one line up
	ADD r2,r1,r3
	STRB r0,[r2]	
	B LOOP

MOVE_DOWN
	LDR r5, =SCR8		; Load the address of SCR8 into r5
	CMP r1, r5			; If already at the bottom boundary, do not move
	BGE LOOP
	ADD r2,r1,r3			; Position of "@"
	LDRB r0,[r2]			; Store "@" in r0
	STRB r4,[r2]			; Write " " to r2
	ADD r1,r1,#52			; Move "@" one line down
	ADD r2,r1,r3
	STRB r0,[r2]		
	B LOOP

	SWI SWI_Exit	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;OUTPUT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCRBG = "**************************************************",&0a,&0d
SCR1  = "                                           *      ",&0a,&0d
SCR2  = "                                          ***     ",&0a,&0d
SCR3  = "                                         *****    ",&0a,&0d
SCR4  = "   @                                       *      ",&0a,&0d
SCR5  = "                                           *      ",&0a,&0d
SCR6  = "                                           *      ",&0a,&0d
SCR7  = "                                           *      ",&0a,&0d
SCR8  = "                                           *      ",&0a,&0d
SCRED = "**************************************************",&0a,&0d,0
	ALIGN
		
	END
