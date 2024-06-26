;下列為ARM251 組合語言 console顯示
;可以用'a'按鍵和'd'按鍵控制@左右移動
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
	SWI SWI_ReadC		; 讀取鍵盤輸入
	CMP r0, #'a'		; 如果輸入的是 'a'
	BEQ MOVE_LEFT
	CMP r0, #'d'		; 如果輸入的是 'd'
	BEQ MOVE_RIGHT
	B LOOP				; 其他輸入則重新讀取鍵盤輸入

MOVE_LEFT
	CMP r3, #3				; 如果已經到左邊界，則不移動
	BLE LOOP
	ADD r2,r1,r3			; @的位置
	LDRB r0,[r2]			; @放到r0
	STRB r4,[r2]			; " "寫入r2
	SUB r3,r3,#3			; 將@向左移動3個位置
	ADD r2,r1,r3
	STRB r0,[r2]		
	B LOOP

MOVE_RIGHT
	CMP r3, #32				; 如果已經到右邊界，則不移動
	BGE LOOP
	ADD r2,r1,r3			; @的位置
	LDRB r0,[r2]			; @放到r0
	STRB r4,[r2]			; " "寫入r2
	ADD r3,r3,#3			; 將@向右移動3個位置
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
