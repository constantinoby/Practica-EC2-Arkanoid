; ==============================================================================
; GAME VARIABLES
; ==============================================================================

; --- PAD RELATED VARIABLES ----------------------------------------------------

PADPOSX         DS.W    1                       ; PAD X COORDINATE

; --- SCOREBOARD RELATED VARIABLES ---------------------------------------------

SCOPOINT        DS.W    1                       ; NUMBER OF POINTS (BLOCKBROKEN)
SCOTIME         DS.W    1                       ; NUMBER OF THE TIME PASSED
LIFES           DS.W    1                       ; NUMBER OF LIFES

; --- BLOCK VARIABLES ----------------------------------------------------------

BLOCKTOTAL      DS.W    1                          ; NUMBER OF BLOCKS
BLOCKPOSX       DS.W    1                          ; BLOCK X COORDINATES
BLOCKPOSY       DS.W    1                          ; BLOCK Y COORDINATES
BLOCKFCOL       DS.L    1                          ; BLOCK FIL COLOR
XLIST           DS.W    40                         ; BLOCK X COORDINATES LIST
YLIST           DS.W    40                         ; BLOCK Y COORDINATES LIST

; --- STATE RELATED VARIABLES ----------------------------------------------------------

STACUR         DS.W    1                           ; CURRENT STATE  
STANEXT        DS.W    1                           ; NEXT STATE




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
