; =============================================================================
; TITLE    : BLOCKS MANAGEMENT
; AUTHOR   : Valentino Coppola Ferrari y Constantino Byelov Serdiuk
; =============================================================================

;------------------------------------------------------------------------------
BLOCKINIT
; BLOCK INIT FOR BLOCK AGENT
;------------------------------------------------------------------------------

            MOVE.W  (BLOCKPOSX),(A0)
            MOVE.W  (BLOCKPOSY),2(A0)
            MOVE.L  (BLOCKFCOL),4(A0)
            RTS
            
;------------------------------------------------------------------------------
BLOCKUPD
; BLOCK UPDATE
;------------------------------------------------------------------------------
            
            RTS

;------------------------------------------------------------------------------
BLOCKPLOT
; BLOCK PLOT
;------------------------------------------------------------------------------
 
        MOVEM.L D0-D4,-(A7)
        
        ;SET PEN COLOR
        MOVE.B  #80,D0
        MOVE.L  #BLOCKPCOL,D1
        TRAP    #15
        
        ;SET FILL COLOR
        MOVE.B  #81,D0
        MOVE.L  4(A0),D1
        TRAP #15
        
        ;SET COORDINATES
        MOVE.W  (A0),D1
        SUB.W   #BLOCKWIDTH/2,D1
        MOVE.W  2(A0),D2
        SUB.W   #BLOCKHEIGH/2,D2
        MOVE.W  D1,D3
        ADD.W   #BLOCKWIDTH,D3
        MOVE.W  D2,D4
        ADD.W   #BLOCKHEIGH,D4
        
        ;DRAW RECTANGLE
        MOVE.W  #87,D0  
        TRAP    #15
        
        MOVEM.L (A7)+,D0-D4
        
        RTS
        
    


*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
