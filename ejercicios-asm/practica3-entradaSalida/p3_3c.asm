EOI EQU 20H
IMR EQU 21H
INT2 EQU 26H
DATOS EQU 40H
ESTADO EQU 41H

ORG 3000H
	SUB_HAND: MOV AL, [BX]
		OUT DATOS, AL
		INC BX
		
		MOV AL, EOI
		OUT EOI, AL
	IRET
	

ORG 1000H
	MSJ DB "SOMOS UNOS CAPOHHH"
	FIN DB ?

ORG 2000H
	;GUARDAR SUBRUTINA EN VI
	MOV AX, SUB_HAND
	MOV BX, 40
	MOV [BX], AX
	
	MOV BX, OFFSET MSJ
	
	;CONFIGURAMOS EL PICSARDO
	CLI
		MOV AL, 11111011B
		OUT IMR, AL
		
		MOV AL, 10
		OUT INT2, AL
		
		;ESTADO
		MOV AL, 10000000B
		OUT ESTADO, AL
	STI
	
	LOOP: CMP BX, OFFSET FIN
	JNZ LOOP
	
	;DESHABILITAMOS INTERRUPCION
	IN AL, ESTADO
	AND AL, 01111111B
	OUT ESTADO, AL

INT 0
END
