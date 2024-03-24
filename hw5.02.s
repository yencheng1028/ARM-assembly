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
	MOV r8,#33		;r1'r3'r4'r8'r10'
	MOV r3,#3		;available'r2'r5
	MOV r4,#" "
	MOV r6,#0		;flag to determine whether to return or not
	ADR r10,SCR4
	ADR r1,SCR4	
LOOP	ADR r0,SCRBG
	SWI SWI_Write0
	BL OBSTACLE_LOOP1_LEFT		; Execute obstacle program
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

; Obstacle creation and movement

OBSTACLE_LOOP1_LEFT
	CMP r8, #3				; If already at the left boundary,return
	MOVLE r6,#1
	CMP r6,#1
	BEQ OBSTACLE_LOOP1_RIGHT		
	ADD r11,r10,r8			; Position of "M"
	LDRB r0,[r11]			; Store "M" in r0
	STRB r4,[r11]			; Write " " to r11
	SUB r8,r8,#3			; Move "M" 3 positions to the left
	ADD r11,r10,r8
	STRB r0,[r11]		
	MOV pc,r14		;return to main program
OBSTACLE_LOOP1_RIGHT
	CMP r8, #33				; If already at the right boundary,return
	MOVGE r6,#0
	CMP r6,#0
	BEQ OBSTACLE_LOOP1_LEFT		
	ADD r11,r10,r8			; Position of "M"
	LDRB r0,[r11]			; Store "M" in r0
	STRB r4,[r11]			; Write " " to r11
	ADD r8,r8,#3			; Move "M" 3 positions to the right
	ADD r11,r10,r8
	STRB r0,[r11]		
	MOV pc,r14		;return to main program	


END_LOOP
	SWI SWI_Exit	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;OUTPUT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCRBG = "**************************************************",&0a,&0d
SCR1  = "      $     $  $     $  $        M        O#O     ",&0a,&0d
SCR2  = "   $     $  $     $     $        M       *@*@*    ",&0a,&0d
SCR3  = "      $                 $        M         *      ",&0a,&0d
SCR4  = "   @                             M       *****    ",&0a,&0d
SCR5  = "   $  $        $        $        M         *      ",&0a,&0d
SCR6  = "            $  $  $              M         *      ",&0a,&0d
SCR7  = "   $     $        $              M        * *     ",&0a,&0d
SCR8  = "   $     $              $        M       *   *    ",&0a,&0d
SCRED = "**************************************************",&0a,&0d,0

	ALIGN
		
	END
