LIST P =18F4550
    INCLUDE "P18F4550.INC"
    ORG 0X00
    MOVLW 0X02	;Cambiamos valir de W a 0X02
    ADDLW 0X04	;Sumamos 0x04 a el valor de W (0x02) resultando 0x06
    END


 
 
