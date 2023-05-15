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
AGN1	ADR r0,SCRBG
	SWI SWI_Write0
TRGT	CMP r3,#35
	BGT TLFT
	ADD r2,r1,r3	; @的位置
	LDRB r0,[r2]	; @放到r0
	STRB r4,[r2]	; " "寫入r2
	ADD r3,r3,#3
	ADD r2,r1,r3
	STRB r0,[r2]		
	B AGN1

AGN2	ADR r0,SCRBG
	SWI SWI_Write0
TLFT    CMP r3,#3
	BLT TRGT
	ADD r2,r1,r3	; @的位置
	LDRB r0,[r2]	; @放到r0
	STRB r4,[r2]	; " "寫入r2
	SUB r3,r3,#3
	ADD r2,r1,r3
	STRB r0,[r2]		
	B AGN2

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


