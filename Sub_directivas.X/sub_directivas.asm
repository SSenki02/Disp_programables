List P=18F4550
    INCLUDE "P18F4550.INC"
    CBLOCK 0X00
    OPER1
    ENDC
    ORG 0X00
    MOVLW 0X02
    MOVWF OPER1
    MOVLW 0X08
    SUBWF OPER1,1
    END


