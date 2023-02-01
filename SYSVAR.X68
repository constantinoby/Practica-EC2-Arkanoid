; ==============================================================================
; SYSTEM VARIABLES
; ==============================================================================

; --- TIMED INTERRUPT RELATED VARIABLES ----------------------------------------
SCRYCCT     DS.B    1                       ; CYCLE COUNTER
            DS.W    0         
 
SCRNINTR    DS.B    1                       ; INTERRUPT COUNTER
            DS.W    0


; --- MOUSE RELATED VARIABLES -------------------------------------------------

SYSMOUP                                    ; MOUSE COORDINATES
MOUPOSY    DS.W    1                       ; Y COORDINATES FROM MOUSE
MOUPOSX    DS.W    1                       ; X COORDINATES FROM MOUSE 
MOULEFT    DS.W    1

; --- SYSTEM FUNCTION VARIABLES -----------------------------------------------

REALREF    DS.W    1                       ; GOTTEN REFRESH TIME
REFCONT    DS.W    1                       ; SYNC WAIT COUNTER, USED FOR FPS COUNTING






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
