; ---------------------------------------------------------------------------------
; WIN SCREEN 
; ---------------------------------------------------------------------------------

; ---------------------------------------------------------------------------------
WININIT
; WIN SCREEN INIT
; ---------------------------------------------------------------------------------
        RTS
        

; ---------------------------------------------------------------------------------
WINUPD
; WIN SCREEN UPDATE
; ---------------------------------------------------------------------------------
        
          MOVEM.L D1,-(A7)
        
          MOVE.W    (MOULEFT),D1        ; SAVE MOUSE LEFT CLICK STATE IN D1 
          CMP.W     #0,D1               ; SEE IF IT'S BEEING ACTIVATED 
          BEQ       .END 
          MOVE.W    #4,(STANEXT)        ; GO TO GAME SCREEN
                
.END     
          MOVEM.L (A7)+,D1
          
             RTS
        
        
        
; ---------------------------------------------------------------------------------
WINPLOT
; WIN SCREEN PLOT
; ---------------------------------------------------------------------------------
        MOVEM.L D0-D1/A0,-(A7)
        
        CLR.L   D1                      ; SET BLACK FILL COLOR
        MOVE.B #81,D0
        TRAP #15

        LEA     .TXT1,A0                ; PRINT FIRST TEXT
        MOVE.B  #12,D0
        JSR     UTLPRINT
        
        BTST.B #4,(SCRYCCT)             ;MAKE SECOND TEXT BLINKING AND PRINT IT
        BEQ     .DONE
        
        LEA     .TXT2,A0
        MOVE.B  #25,D0
        JSR     UTLPRINT
        
.DONE   MOVEM.L (A7)+,D0-D1/A0

         RTS
        
.TXT1   DC.B 'GREAT GAME! YOU DID AMAZING',0
.TXT2   DC.B 'Press LEFT CLICK to continue',0   
        DS.W    0 
        


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
