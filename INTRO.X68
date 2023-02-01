; ---------------------------------------------------------------------------------
; INTRO SCREEN 
; ---------------------------------------------------------------------------------

; ---------------------------------------------------------------------------------
INTROINIT
; INTRO SCREEN INIT
; ---------------------------------------------------------------------------------
        RTS
        

; ---------------------------------------------------------------------------------
INTROUPD
; INTRO SCREEN UPDATE
; ---------------------------------------------------------------------------------
        
          MOVEM.L D1,-(A7)
        
          MOVE.W    (MOULEFT),D1        ; SAVE MOUSE LEFT CLICK STATE IN D1 
          CMP.W     #0,D1               ; SEE IF IT'S BEEING ACTIVATED 
          BEQ       .END 
          MOVE.W    #1,(STANEXT)        ; GO TO GAME SCREEN
                
.END     
          MOVEM.L (A7)+,D1
          
             RTS
        
        
        
; ---------------------------------------------------------------------------------
INTROPLOT
; INTRO SCREEN PLOT
; ---------------------------------------------------------------------------------
       
        MOVEM.L D0-D1/A0,-(A7)
        
        
        CLR.L   D1                  ; SET TEXT FILL COLOR TO BLACK 
        MOVE.B #81,D0
        TRAP #15
        
        LEA     .TXT1,A0            ; WRITE FIRST TEXT AT D1 ROW
        MOVE.B  #10,D0
        JSR     UTLPRINT
        
        LEA     .TXT2,A0            ; WRITE SECOND TEXT AT D1 ROW
        MOVE.B  #12,D0
        JSR     UTLPRINT
        
        LEA     .TXT3,A0            ; WRITE THIRD TEXT AT D1 ROW
        JSR     UTLPRINT
        
        BTST.B #4,(SCRYCCT)         ; WRITE FORTH TEXT AT D1 ROW AND IT'S BLINKING
        BEQ     .DONE
        
        LEA     .TXT4,A0
        MOVE.B  #25,D0
        JSR     UTLPRINT
        
.DONE   MOVEM.L (A7)+,D0-D1/A0

         RTS
        
.TXT1   DC.B 'PROYECTO : ARKANOID',0
.TXT2   DC.B 'Valentino Coppola Ferrari y Constantino Byelov Serdiuk',0
.TXT3   DC.B '2022-2023',0
.TXT4   DC.B 'Press LEFT CLICK to play',0   
        DS.W    0    




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
