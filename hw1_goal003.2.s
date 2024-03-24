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
	MOV r9,#"M"
	MOV r6, #0				; Initialize obstacle counter
	MOV r7, #33				; Position of the rightmost obstacle
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
	BL OBSTACLE_LOOP		; Execute obstacle program
	ADR r0,SCRBG
	SWI SWI_Write0
	CMP r6, #10				; Check if 10 obstacles have been created
	BGE END_LOOP
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

; Obstacle creation and movement

OBSTACLE_LOOP

OBSTACLE_CREATE
	ADD r8, r1, r7			; Position of the current obstacle
	LDRB r0, [r8]			; Load the content at the current obstacle position
	CMP r0, #" "			; Check if the current position is empty (no obstacle)
	BEQ SKIP_OBSTACLE		; If there is already an obstacle, skip creating a new one
	STRB r9, [r8]			; Write the obstacle character ("M") to the current position
SKIP_OBSTACLE
	LDRB r0, [r8]			; Load the content of the previous position
	SUB r8, r8, #3			; Move the obstacle position 3 positions to the left
	STRB r0, [r8]			; Write the content to the new position
	ADD r6, r6, #1			; Increment obstacle counter

	MOV pc,r14	;return to main program

END_LOOP
	SWI SWI_Exit

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
