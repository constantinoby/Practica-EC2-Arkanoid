; =============================================================================
; TITLE    : PAD MANAGEMENT
; AUTHOR   : Valentino Coppola Ferrari y Constantino Byelov Serdiuk
; =============================================================================

;------------------------------------------------------------------------------
PADINIT
; INITIALIZE THE PAD
;------------------------------------------------------------------------------
    
    MOVE.W #SCRWIDTH/2,(PADPOSX)        ; INITIALIZE PAD AT CENTER OF THE SCREEN
    RTS
    
; -----------------------------------------------------------------------------
PADUPD
; UPDATE THE PAD
;
; -----------------------------------------------------------------------------
        MOVE.W   D0,-(A7)
     
        MOVE.W  (MOUPOSX),D0            ; GET MOUSE POSX 

        ;CHECHK PAD COLLISIONS SO THE PAD DOESN'T LEAVE THE SCREEN
.CONT
        CMP.W   #PADWIDTH/2,D0          
        BGE     .CONT2
        MOVE.W  #PADWIDTH/2,D0
        BRA     .DONE
.CONT2
        CMP.W   #SCRWIDTH-PADWIDTH/2,D0
        BLE     .DONE   
        MOVE.W  #SCRWIDTH-PADWIDTH/2,D0
    
.DONE
        MOVE.W  D0,(PADPOSX)            ; AFTER MOUSE POSX CHECKED WE IMPLMENT THE NEW POSITION TO PADPOSX 
        
        MOVE.W  (A7)+,D0

        RTS
  


  
; -----------------------------------------------------------------------------
PADCONF
; CONFIGURATE THE PAD, AND CREATE THE PAD FIGURE
; -----------------------------------------------------------------------------
  
        MOVEM.L D0-D4,-(A7)             
  
        MOVE.B #80,D0                   ;SET PEN COLOR TASK
        MOVE.L #PADPCOL,D1              ;PAD COLOR
        TRAP #15
        MOVE.B #81,D0
        MOVE.L #PADFCOL,D1              ;FILLCOL
        TRAP #15

        ;DEFINE PAD COORDINATES
        MOVE.W (PADPOSX),D1             ; PAINT IT AT THE CENTER OF THE SCREEN AT 2 PAD WIDTHS FROM BOTTOM OF SCREEN
        SUB.W #PADWIDTH/2,D1
        MOVE.W D1,D3
        ADD.W #PADWIDTH,D3
  
        MOVE.W #PADY-PADHEIGH/2,D2
        MOVE.W #PADY+PADHEIGH/2,D4
  
        ;DRAW PAD
        MOVE.B    #87,D0
        TRAP      #15 
  
        MOVEM.L   (A7)+,D0-D4
        RTS
  
  
  
  
  
  








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
