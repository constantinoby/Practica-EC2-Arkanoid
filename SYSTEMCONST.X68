; =============================================================================
; TITLE    : SYSTEM CONSTANTS
; 
; =============================================================================

; --- TRAP RELATED CONSTANTS --------------------------------------------------

SCRTRAP     EQU     0                       ; SCREEN REFRESH TRAP
MOUTRAP     EQU     1                       ; MOUSE UPDATE TRAP
SNDPLTN     EQU     2                       ; SOUNDPLAY TRAP NUMBER

; --- INTERRUPT NUMBERS --------------------------------------------------------

SCRINTN     EQU     1                       ; TIMED INTERRUPT NUMBER
SCRFPSN     EQU     2                       ; TIMED INTERRUPT NUMBER


;--- SCREEN CONSTANTS ---------------------------------------------------------

SCRWIDTH    EQU     640                     ; SCREEN WIDTH
SCRHEIGH    EQU     480                     ; SCREEN HEIGH
SCREFRES    EQU     50                      ; SCREEN FPS 


; --- SOUND IDENTIFIERS --------------------------------------------------------

SNDWALL     EQU     0                       ; SOUND NUMBER FOR WALL HIT
SNDHIT      EQU     1                       ; SOUND NUMBER FOR HIT
SNDMISS     EQU     2                       ; SOUND NUMBER FOR MISS






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
