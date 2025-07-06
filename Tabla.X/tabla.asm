LIST P=18F4550
    INCLUDE "P18F4550.INC"
	    ORG 0X00 
	    MOVLW   0X0F
	    MOVWF   ADCON1 
	    MOVLW   0X07
	    MOVWF   CMCON 
	    MOVLW   0XFF
	    MOVWF   OSCCON 
	    SETF    TRISB 
	    CLRF    TRISC
    OTRO    MOVF    PORTB,W
	    ANDLW   B'00001111' ;Aqui se enmascara, solo estan en 1 los bits que usaremos como entrada
	    RLNCF   WREG,W
	    CALL    TABLA
	    MOVWF   LATC
	    GOTO    OTRO
    TABLA   ADDWF   PCL,F   ;esta instruccion sirve como contador, aumenta el numero de w
	    RETLW   0X02    ;en la tabla solo estan los hexadecimales de las salidas
	    RETLW   0X00
	    RETLW   0X00
	    RETLW   0X06
	    RETLW   0X00
	    RETLW   0X06
	    RETLW   0X06
	    RETLW   0X01
	    RETLW   0X00
	    RETLW   0X06
	    RETLW   0X06
	    RETLW   0X01
	    RETLW   0X06
	    RETLW   0X01
	    RETLW   0X01
	    RETLW   0X02
	    END


