; ==============================================================================
; SYSTEM MANAGEMENT
; ==============================================================================

;----------------------------------------------------------------------
SYSTEMINIT
;INITIALIZE SYSTEM.
;----------------------------------------------------------------------

            MOVE.L  #SCRPLOT,($80+SCRTRAP*4)        ; INSTALL ALL THE TRAPS 
            MOVE.L  #MOUISR,($80+MOUTRAP*4)
            MOVE.L  #SNDPLAY,($80+SNDPLTN*4)
            MOVE.L  #SCRTIM,($60+SCRINTN*4)
            MOVE.L  #FPS,($60+SCRFPSN*4)

            JSR     SCREENINIT                     ; INITIALIZE ALL CLASSES
            JSR     MOUINIT
            JSR     SNDINIT
            JSR     DMMINIT
            
            MOVE.W  SR,-(A7)
            ANDI.W  #$D8FF,(A7)     ;pasamos a usuario y habilitamos excepciones
            RTE
;----------------------------------------------------------------------
MOUINIT
;INICIALIZES THE MOUSE
;----------------------------------------------------------------------
            
            MOVEM.L  D0-D1,-(A7)
            
            ;CLEAR MOUSE X VARIABLE
            CLR.L (MOUPOSX)
            CLR.L (MOULEFT)
            ;ENABLE MOUSE
            MOVE.B #60,D0
            MOVE.W $0100,D1
            
            TRAP #15
            
            MOVEM.L (A7)+,D0-D1
            RTS
    
;----------------------------------------------------------------------
MOUISR
;UPDATE MOUSE POSITION
;----------------------------------------------------------------------

            MOVEM.L D0-D1,-(A7)
            
            MOVE.B #61,D0           
            MOVE.W #0,D1
            TRAP #15
            
            MOVE.L  D1,(SYSMOUP)    ; LOAD ALL MOUSE INFORMATION GOTTEN FROM TRAP #15 INTO SYSMOUP
            AND.W   #$0001,D0       ; MASK TO GET ONLY WHEN THE LEFT CLICK IS ACTIVATED
            MOVE.W  D0,(MOULEFT)    
            
            MOVEM.L (A7)+,D0-D1
            RTE

;----------------------------------------------------------------------
SNDINIT
;INICIALIZES THE SOUNDS
;----------------------------------------------------------------------
            MOVEM.L  D0-D1/A0-A1,-(A7)

            CLR.B   D1
            LEA     .SNDLIST,A0
.LOOP       MOVE.L  (A0)+,D0
            BEQ     .DONE
            MOVE.L  D0,A1
            MOVE.B  #71,D0
            TRAP    #15
            ADDQ.B  #1,D1        
            BRA     .LOOP
            
.DONE      MOVEM.L  (A7)+,D0-D1/A0-A1
             RTS

.SNDWALL    DC.B    'SND/HIT.wav',0
.SNDHIT     DC.B    'SND/HIT.wav',0
.SNDMISS    DC.B    'SND/MISS.wav',0
.SNDLIST    DC.L    .SNDWALL,.SNDHIT,.SNDMISS,0

;----------------------------------------------------------------------
SNDPLAY
;PLAYS THE SOUND, GOTTEN FROM D7 REGISTER
;----------------------------------------------------------------------
            MOVEM.W D0-D1,-(A7)
            
            MOVE.B  #72,D0
            MOVE.B  D7,D1
            TRAP #15
            
            MOVEM.W (A7)+,D0-D1

            RTE
;----------------------------------------------------------------------
SCREENINIT
;INICIALIZES THE SCREEN 
;----------------------------------------------------------------------

            MOVEM.L D0-D3,-(A7)

            ; SET SCREEN RESOLUTION
            MOVE.B  #33,D0
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH,D1
            TRAP    #15
            
            ; SET WINDOWED MODE
            MOVE.L  #1,D1
            TRAP    #15
            
            ; CLEAR SCREEN
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            
            ; ENABLE DOUBLE BUFFER
            MOVE.B  #92,D0
            MOVE.B  #17,D1
            TRAP    #15
            
            ; ENABLE TIMED INTERRUPT
            MOVE.B  #32,D0
            MOVE.B  #6,D1
            MOVE.B  #$80|SCRINTN,D2
            MOVE.L  #1000/SCREFRES,D3
            TRAP    #15
            
            ; TIMED INTERRUPT EVERY SECOND, USED TO UPDATE THE FPS 
            MOVE.B  #32,D0
            MOVE.B  #6,D1
            MOVE.B  #$80|SCRFPSN,D2
            MOVE.L  #1000,D3
            TRAP    #15
            
            ; CLEAR INTERRUPT COUNTER
            CLR.W   (SCRNINTR)        
            
            
            MOVEM.L (A7)+,D0-D3
            RTS

; ------------------------------------------------------------------------------
SCRPLOT
; UPDATES DOUBLE BUFFER
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1,-(A7)
            
            ; SWITCH BUFFERS
            MOVE.B  #94,D0
            TRAP    #15
            
            ; CLEAR HIDDEN BUFFER
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1
            RTE
            
; ------------------------------------------------------------------------------
SCRTIM
; TIMED INTERRUPT SERVICE ROUTINE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            ADDQ.B  #1,(SCRNINTR)
            ADDQ.B  #1,(SCRYCCT)
            RTE

; ------------------------------------------------------------------------------
FPS
; TIMED INTERRUPT SERVICE ROUTINE, UPDATES THE FPS COUNTER EVERY 1 SECOND 
; ------------------------------------------------------------------------------
            MOVEM.L D0,-(A7)
            
            MOVE.W  (REFCONT),(REALREF)         ; UPDATE FPS COUNTER
            CLR.W   (REFCONT)
            
            ADDQ.W  #1,(SCOTIME)                ; UPDATE TIME 
            
            MOVEM.L (A7)+,D0
            RTE
            
            













*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
