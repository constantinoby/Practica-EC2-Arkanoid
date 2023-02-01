; ---------------------------------------------------------------------------------
; FINAL SCREEN 
; ---------------------------------------------------------------------------------

; ---------------------------------------------------------------------------------
FINALINIT
; FINAL SCREEN INIT
; ---------------------------------------------------------------------------------
        RTS
        

; ---------------------------------------------------------------------------------
FINALUPD
; INTRO SCREEN UPDATE
; ---------------------------------------------------------------------------------
        
             RTS
        
; ---------------------------------------------------------------------------------
FINALPLOT
; INTRO SCREEN PLOT
; ---------------------------------------------------------------------------------
       
        MOVEM.L D0-D1/A0,-(A7)
        
        
        CLR.L   D1                  ; SET TEXT FILL COLOR TO BLACK
        MOVE.B #81,D0
        TRAP #15
        
        LEA     .TXT4,A0
        MOVE.B  #10,D0
        JSR     UTLPRINT
        
        LEA     .TXT1,A0            ; WRITE FIRST TEXT AT D1 ROW
        MOVE.B  #14,D0
        JSR     UTLPRINT
        
        LEA     .TXT2,A0            ; WRITE SECOND TEXT AT D1 ROW
        MOVE.B  #16,D0
        JSR     UTLPRINT
        
        LEA     .TXT3,A0            ; WRITE THIRD TEXT AT D1 ROW
        JSR     UTLPRINT
                
       
        
.DONE   MOVEM.L (A7)+,D0-D1/A0

         RTS

.TXT4   DC.B 'THANKS FOR PLAYING, HOPE YOU ENJOYED!',0
.TXT1   DC.B 'PROYECTO : ARKANOID',0
.TXT2   DC.B 'Valentino Coppola Ferrari y Constantino Byelov Serdiuk',0
.TXT3   DC.B '2022-2023',0 
        DS.W    0    




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
