 
    LIST P = 18F45k50
	; PIC18F45K50 Configuration Bit Settings

; Assembly source line config statements

#include "p18f45k50.inc"

; CONFIG1L
  CONFIG  PLLSEL = PLL4X        ; PLL Selection (4x clock multiplier)
  CONFIG  CFGPLLEN = OFF        ; PLL Enable Configuration bit (PLL Disabled (firmware controlled))
  CONFIG  CPUDIV = NOCLKDIV     ; CPU System Clock Postscaler (CPU uses system clock (no divide))
  CONFIG  LS48MHZ = SYS24X4     ; Low Speed USB mode with 48 MHz system clock (System clock at 24 MHz, USB clock divider is set to 4)

; CONFIG1H
  CONFIG  FOSC = INTOSCIO       ; Oscillator Selection (Internal oscillator)
  CONFIG  PCLKEN = ON           ; Primary Oscillator Shutdown (Primary oscillator enabled)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  nPWRTEN = ON          ; Power-up Timer Enable (Power up timer enabled)
  CONFIG  BOREN = SBORDIS       ; Brown-out Reset Enable (BOR enabled in hardware (SBOREN is ignored))
  CONFIG  BORV = 190            ; Brown-out Reset Voltage (BOR set to 1.9V nominal)
  CONFIG  nLPBOR = OFF          ; Low-Power Brown-out Reset (Low-Power Brown-out Reset disabled)

; CONFIG2H
  CONFIG  WDTEN = OFF           ; Watchdog Timer Enable bits (WDT disabled in hardware (SWDTEN ignored))
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscaler (1:32768)

; CONFIG3H
  CONFIG  CCP2MX = RC1          ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = ON           ; PORTB A/D Enable bit (PORTB<5:0> pins are configured as analog input channels on Reset)
  CONFIG  T3CMX = RC0           ; Timer3 Clock Input MUX bit (T3CKI function is on RC0)
  CONFIG  SDOMX = RB3           ; SDO Output MUX bit (SDO function is on RB3)
  CONFIG  MCLRE = ON            ; Master Clear Reset Pin Enable (MCLR pin enabled; RE3 input disabled)

; CONFIG4L
  CONFIG  STVREN = ON           ; Stack Full/Underflow Reset (Stack full/underflow will cause Reset)
  CONFIG  LVP = ON              ; Single-Supply ICSP Enable bit (Single-Supply ICSP enabled if MCLRE is also 1)
  CONFIG  ICPRT = OFF           ; Dedicated In-Circuit Debug/Programming Port Enable (ICPORT disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled)

; CONFIG5L
  CONFIG  CP0 = OFF             ; Block 0 Code Protect (Block 0 is not code-protected)
  CONFIG  CP1 = OFF             ; Block 1 Code Protect (Block 1 is not code-protected)
  CONFIG  CP2 = OFF             ; Block 2 Code Protect (Block 2 is not code-protected)
  CONFIG  CP3 = OFF             ; Block 3 Code Protect (Block 3 is not code-protected)

; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protect (Boot block is not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protect (Data EEPROM is not code-protected)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Block 0 Write Protect (Block 0 (0800-1FFFh) is not write-protected)
  CONFIG  WRT1 = OFF            ; Block 1 Write Protect (Block 1 (2000-3FFFh) is not write-protected)
  CONFIG  WRT2 = OFF            ; Block 2 Write Protect (Block 2 (04000-5FFFh) is not write-protected)
  CONFIG  WRT3 = OFF            ; Block 3 Write Protect (Block 3 (06000-7FFFh) is not write-protected)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Registers Write Protect (Configuration registers (300000-3000FFh) are not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protect (Boot block (0000-7FFh) is not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protect (Data EEPROM is not write-protected)

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Block 0 Table Read Protect (Block 0 is not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Block 1 Table Read Protect (Block 1 is not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Block 2 Table Read Protect (Block 2 is not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Block 3 Table Read Protect (Block 3 is not protected from table reads executed in other blocks)

; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protect (Boot block is not protected from table reads executed in other blocks)


		
		;----INICIO PROGRAMA----
	   CBLOCK 0x00
	   CONTADOR1
	   CONTADOR2
	   CONTADOR3
	   C_UNIDADES
	   C_DECENAS
	   C_CENTENAS
	   ENDC
	   ORG 0x00
	   
	   MOVLW   0xef  ; HFINTOSC a 8 MHz (ajustable)
	   MOVWF    OSCCON
	   CLRF	    ANSELA
	   CLRF	    ANSELB
	   CLRF	    ANSELC
	   CLRF	    ANSELD
	   CLRF	    ANSELE
	   CLRF	    TRISA 
	   CLRF	    TRISB   ;Salida de las unidades
	   BSF	    TRISC,RC0  ;Entrada del boton
	   CLRF	    TRISD

INICIO	   MOVLW    0X00
	   MOVWF    C_UNIDADES
	   MOVLW    b'1000000';mover 0 al contador de las unidades y pintaro en el display
	   MOVWF    LATB
	   MOVLW    0X00
	   MOVWF    C_DECENAS
	   MOVLW    b'1000000'
	   MOVWF    LATA
	   MOVLW    0X00
	   MOVWF    C_CENTENAS
	   MOVLW    b'1000000'
	   MOVWF    LATD
APRETAR	   BTFSS    PORTC,RC0 ;Si es 1 saltara, si es 0 preguntara de nuevo
	   GOTO	    APRETAR
	   CALL	    RETARDO
	   BTFSS    PORTC,RC0
	   GOTO	    APRETAR
SOLTAR	   BTFSC    PORTC,RC0
	   GOTO	    SOLTAR
	   MOVFF    C_UNIDADES,WREG
	   RLNCF    WREG
	   CALL	    D_UNIDADES
	   MOVWF    LATB
	   INCF	    C_UNIDADES,F
	   MOVLW    d'9'
	   CPFSGT   C_UNIDADES
	   GOTO	    APRETAR
	   GOTO	    DECENAS	   
DECENAS	   MOVLW    0X00
	   MOVWF    C_UNIDADES
	   MOVLW    b'1000000'
	   MOVWF    LATB ;PINTAR 0 EN UNIDADES
	   MOVFF    C_DECENAS,WREG
	   RLNCF    WREG
	   CALL	    D_DECENAS
	   MOVWF    LATA
	   INCF	    C_DECENAS,F
	   MOVLW    d'9'
	   CPFSGT   C_DECENAS
	   GOTO	    APRETAR
	   GOTO	    CENTENAS
CENTENAS   MOVLW    0X00
	   MOVWF    C_UNIDADES
	   MOVLW    b'1000000';mover 0 al contador de las unidades y pintaro en el display
	   MOVWF    LATB
	   MOVLW    0X00
	   MOVWF    C_DECENAS
	   MOVLW    b'1000000'
	   MOVWF    LATA ;PINTAR 0 EN DECENAS
	   MOVFF    C_CENTENAS,WREG
	   RLNCF    WREG
	   CALL	    D_CENTENAS
	   MOVWF    LATD
	   INCF	    C_CENTENAS,F
	   MOVLW    d'9'
	   CPFSGT   C_CENTENAS
	   GOTO	    APRETAR
	   GOTO	    INICIO	 	   

RETARDO
;CICLO4	MOVLW	d'10'
;	MOVWF	CONTADOR3
;CICLO3	MOVLW	d'2'
;	MOVWF	CONTADOR2	
;CICLO2	MOVLW	d'249'
;	MOVWF	CONTADOR1    
;CICLO1	NOP
;	DECFSZ	CONTADOR1,F
;	GOTO	CICLO1
;	DECFSZ	CONTADOR2,F
;	GOTO	CICLO2
;	DECFSZ	CONTADOR3,F
;	GOTO	CICLO3*/
	RETURN	   

D_UNIDADES ADDWF    PCL,F
	   RETLW    b'1111001';1
	   RETLW    b'0100100';2
	   RETLW    b'0110000';3
	   RETLW    b'0011001';4
	   RETLW    b'0010010';5
	   RETLW    b'0000010';6
	   RETLW    b'1111000';7
	   RETLW    b'0000000';8
	   RETLW    b'0010000';9
	   RETLW    b'1000000';0
	   
D_DECENAS  ADDWF    PCL,F
	   RETLW    b'1111001';1
	   RETLW    b'0100100';2
	   RETLW    b'0110000';3
	   RETLW    b'0011001';4
	   RETLW    b'0010010';5
	   RETLW    b'0000010';6
	   RETLW    b'1111000';7
	   RETLW    b'0000000';8
	   RETLW    b'0010000';9
	   RETLW    b'1000000';0
	   
D_CENTENAS ADDWF    PCL,F
	   RETLW    b'1111001';1
	   RETLW    b'0100100';2
	   RETLW    b'0110000';3
	   RETLW    b'0011001';4
	   RETLW    b'0010010';5
	   RETLW    b'0000010';6
	   RETLW    b'1111000';7
	   RETLW    b'0000000';8
	   RETLW    b'0010000';9
	   
END	   


