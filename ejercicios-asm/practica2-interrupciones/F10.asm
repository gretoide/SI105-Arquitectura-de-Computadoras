EOI EQU 20H ;EOI, LE AVISA AL PIC QUE SI INTERRUPCION FUE ATENDIDA
IMR EQU 21H ;IMR, DECLARA QUE INTERRUPCIONES ESTAN HABILITADAS
INT0 EQU 24H ; INT 0, INTERRUPCION ASOCIADA AL F10 (DONDE DECLARAREMOS LOS ID)

ORG 3000H
	;SUBRUTINA QUE NOS CUENTE LA CANTIDAD DE VECES QUE SE PREESIONA LA TECLA F10
CONTAR: INC DL
		MOV AL, 20H
		OUT EOI, AL ;LE INDICAMOS QUE LA INTERRUPCION FUE ATENDIDA
IRET ;RETORNO DE LAS SUBRUTINAS DE ATENDIMIENTO DE INTERRUPCIONES
	
ORG 2000H
;CONFIGURAMOS EL VECTOR DE INTERRUPCIONES
	MOV AX, CONTAR ;LE MANDAMOS LA DIRECCION DE NUESTRA SUBRUTINA QUE ATIENDA LA INTERRUPCION AL = 3000H
	MOV BX, 40 ;DIRECCION DE NUESTRO VECTOR
	MOV [BX], AX ; NUESTRO VECTOR EN 20 = 3000H. DONDE VA A IR A BUSCAR LA SUB
	
;CONFIGURAMOS EL PIC (SIEMPRE ENTRE CLI Y STI)
	
	CLI
		;CONFIGURAMOS EL IMR
		MOV AL, 11111110B ; PARA QUE SOLO NOS ATIENDA LA INT 0 (TECLA F10)
		OUT IMR, AL ; 21H = 11111110
		;CONFIGURAMOS EL ID
		MOV AL,10
		OUT INT0, AL
	STI
	
	LOOP: JMP LOOP
	
	INT 0
END