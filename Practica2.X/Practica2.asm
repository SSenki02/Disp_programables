LIST P=18F4550
    INCLUDE "P18F4550.INC"
    ; falta palabra de configuracion
   	
	    ORG 0X00 ;Registro de memoria en el que inica el programa
	    MOVLW   0X0F
	    MOVWF   ADCON1 ;Con el ADCON INDICAMOS QUE LAS ENTRADAS SON DIGITALES
	    MOVLW   0X07
	    MOVWF   CMCON 
	    MOVLW   0XFF
	    MOVWF   OSCCON 
	    BSF	    TRISA, RA0 ;RA0,RA1,RA2 Y RA3 FUNCIONARAN COMO ENTRADAS. POR ESO SE INICALIZAN EN SET
	    BSF	    TRISA, RA1 ;BSF = Bit Set File. Pone el bit en 1. Con Tris configuras en bit como entrada o salida
	    BSF	    TRISA, RA2 ;Las entradas se inicializan en 1
	    BSF	    TRISA, RA3
	    BCF	    TRISC, RC0	;BCF = Bit Clear File. Pone el bit en 0. Las salidas se inicializan en 0
	    BCF	    TRISC, RC1
	    
    INICIO  BTFSS   PORTA,RA0 ;BTFSS= Bit Test File,Skip if Set. Se saltara una linea si RA0 es 1 (pasara de la linea 20 a la 22)
	    GOTO    UNO
	    BTFSS   PORTA,RA1
	    GOTO    DOS
	    BSF	    LATC,RC1	;Mandar a salida Z un 1 logico
	    BTFSC   PORTA,RA2	;BTFSC=Bit Test File, Skip if Clear. Al igual que el BTFSS, se saltara una linea, en este casi si RA2 es igual a 0
	    BSF	    LATC,RC0
	    BTFSC   PORTA,RA3
	    BSF	    LATC,RC0
	    GOTO    APAGAR
    UNO	    BTFSS   PORTA,RA1
	    GOTO    CUATRO
	    BTFSS   PORTA,RA2
	    GOTO    CINCO
	    BSF	    LATC,RC1
	    BTFSS   PORTA,RA3
	    GOTO    APAGAR
	    BSF	    LATC,RC0
	    GOTO    APAGAR
    DOS	    BTFSC   PORTA,RA2
	    GOTO    TRES
	    BTFSS   PORTA,RA3
	    GOTO    APAGAR
	    BSF	    LATC,RC1
	    GOTO    APAGAR
    TRES    BSF	    LATC,RC1	
	    BTFSS   PORTA,RA3
	    GOTO    APAGAR
	    BSF	    LATC,RC0
	    GOTO    APAGAR
    CUATRO  BTFSS   PORTA,RA2	
	    GOTO    APAGAR
	    BTFSS   PORTA,RA3
	    GOTO    APAGAR
	    BSF	    LATC,RC1
	    GOTO    APAGAR
    CINCO   BTFSS   PORTA,RA3
	    GOTO    APAGAR
	    BSF	    LATC,RC1
	    GOTO    APAGAR
    APAGAR  BCF	    LATC,RC0
	    BCF	    LATC,RC1
	    GOTO    INICIO
	    END
