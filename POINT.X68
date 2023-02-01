; ==============================================================================
; SCOREBOARD MANAGEMENT
; ==============================================================================


; ------------------------------------------------------------------------------
POINTINIT
; INITIALIZE SCOREBOARD
; ------------------------------------------------------------------------------
            CLR.W   (SCOPOINT)
            CLR.W   (SCOTIME)
            CLR.W   (LIFES)
            
            MOVE.W  #3,(LIFES)  ; START THE GAME WITH 3 LIFES   
            RTS

; ------------------------------------------------------------------------------
POINTUPD
; UPDATE SCOREBOARD
; ------------------------------------------------------------------------------
           RTS
          

; ------------------------------------------------------------------------------
POINTPLOT
; PLOT THE SCOREBOARD
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D1/A1,-(A7)

            ; SET BACKGROUND COLOR
            MOVE.B  #81,D0
            MOVE.L  #SCOFCOL,D1
            TRAP    #15
            
            ; SET FIRST LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE1,D1
            TRAP    #15

            ; PRINT FIRST LINE
            LEA     .TXT1,A1
            CLR.L   D1
            MOVE.W  (SCOPOINT),D1
            MOVE.B  #17,D0
            TRAP    #15

            ; SET SECOND LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #SCOLINE2,D1
            TRAP    #15

            ; PRINT SECOND LINE
            LEA     .TXT2,A1
            CLR.L   D1
            MOVE.W  (SCOTIME),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ;SET THIRD LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #XYFPSDESIT,D1
            TRAP    #15
            
            ;PRINT THIRD LINE  
            LEA     .TXT3,A1
            CLR.L   D1
            MOVE.W  #SCREFRES,D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ;SET FORTH LINE
            MOVE.B  #11,D0
            MOVE.W  #XYFPSACONS,D1
            TRAP    #15
            
            ;PRINT FORTH LINE  
            LEA     .TXT4,A1
            CLR.L   D1
            MOVE.W  (REALREF),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ;SET FIFTH LINE
            MOVE.B  #11,D0
            MOVE.W  #LIFESCOR,D1
            TRAP    #15
            
            ;PRINT FIFTH LINE
            LEA     .TXT5,A1
            CLR.L   D1
            MOVE.W  (LIFES),D1

            ;MOVE.W  (LIFES),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1/A1
            
            RTS
.TXT1       DC.B    'POINTS :',0
.TXT2       DC.B    'TIME   :',0
.TXT3       DC.B    'GOAL FPS:  ',0
.TXT4       DC.B    'ACTUAL FPS:  ',0
.TXT5       DC.B    'LIFES :',0




















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
