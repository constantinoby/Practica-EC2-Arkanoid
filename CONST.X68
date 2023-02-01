; =============================================================================
; TITLE    : GAME CONSTANTS 
; =============================================================================

; --- PAD RELATED CONSTANTS ---------------------------------------------------
PADWIDTH    EQU     70                          ; PAD WIDTH
PADHEIGH    EQU     10                          ; PAD HEIGHT
PADPCOL     EQU     $0000FF00                   ; PEN COLOR
PADFCOL     EQU     $0000AA00                   ; FILL COLOR
PADY        EQU     SCRHEIGH-PADHEIGH-PADHEIGH  ; PAD Y COORDINATE

; --- SCOREBOARD RELATED CONSTANTS ---------------------------------------------
SCOFCOL     EQU     $00000000                   ; TEXT BACKGROUND COLOR
SCOLINE1    EQU     $0101                       ; FIRST TEXT LINE COORDINATES
SCOLINE2    EQU     $0102                       ; SECOND TEXT LINE COORDINATES
XYFPSDESIT  EQU     $0F01                       ; COORDINATES FOR THE WANTED FPS
XYFPSACONS  EQU     $0F02                       ; COORDINATES FOR THE GOTTEN FPS
LIFESCOR    EQU     $2301                       ; COORDINATES FOR THE LIVES

; --- BALL RELATED CONSTANTS ---------------------------------------------------
BALLRAD      EQU     8                          ; BALL RADIUS
BALLPCOL     EQU     $001100FF                  ; PEN COLOR
BALLFCOL     EQU     $00FFFFFF                  ; FILL COLOR
BALLSPEED    EQU     8                          ; BALL REFERENCE SPEED

; --- BLOCK RELATED CONSTANTS ----------------------------------------------------
BLOCKID      EQU     2                          ; BLOCK IDENTIFIER
BLOCKWIDTH   EQU     50                         ; BLOCK WIDTH
BLOCKHEIGH   EQU     20                         ; BLOCK HEIGHT
BLOCKPCOL    EQU     $00FFFFFF                  ; WHITE BLOCK PEN COLOR

; ---STATE RELATED CONSTANT-------------------------------------------------------

STANONE      EQU     -1                         ; NONE STATE









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
