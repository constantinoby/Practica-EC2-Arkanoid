*----------------------------------------------------------------------
* Title      : ARKANOID
* Written by : Valentino Coppola Ferrari y Constantino Byelov Serdiuk
* Date       : 10-11-2022
*----------------------------------------------------------------------

    ORG    $1000
    
    INCLUDE "SYSTEMCONST.X68"
    INCLUDE "LIB/DMMCONST.X68"
    INCLUDE "LIB/UTLCONST.X68"
    INCLUDE "LIB/DMMCODE.X68"
    INCLUDE "SYSTEM.X68"
    INCLUDE "CONST.X68"
    INCLUDE "LIB/AGLCODE.X68"
    INCLUDE "LIB/UTLCODE.X68" 
    INCLUDE "BALL.X68" 
    INCLUDE "PAD.X68"
    INCLUDE "POINT.X68"
    INCLUDE "GOVER.X68"
    INCLUDE "INTRO.X68"
    INCLUDE "WIN.X68"
    INCLUDE "STATES.X68"
    INCLUDE "GAME.X68"
    INCLUDE "BLOCK.X68"
    INCLUDE "FINAL.X68"

     
      
;--- INITIALIZE --------------------------------------------------------
START:   
        ORI.W   #$0700,SR     ; DISABLE INTERRUPTIONS               
        JSR SYSTEMINIT
        JSR UTLINIT
        JSR STAINIT
        
         

;--- UPDATE ------------------------------------------------------------
.LOOP   
        TRAP    #MOUTRAP      ; MOUSE TRAP, READ INPUTS FROM PERIPHERAL.
        JSR     STAUPD        
        
        ADDQ.W  #1,(REFCONT)  ; ADD 1 PER SYNC WAIT CYCLE, USED TO KNOW THE FPS OF THE PROGRAM
;--- SYNC -----------------------------------------------------------

.SCRN   TST.B   (SCRNINTR)
        BEQ     .SCRN
        CLR.B   (SCRNINTR)

      
;--- PLOT --------------------------------------------------------------
    
        JSR     STAPLOT
        TRAP    #SCRTRAP    ;UPDATE DOUBLE BUFFER
        
        
        BRA     .LOOP
        
        SIMHALT
        
        
;--- VARIABLES ----------------------------------------------------------

        INCLUDE "VAR.X68"
        INCLUDE "LIB/UTLVARS.X68"
        INCLUDE "SYSVAR.X68"
        INCLUDE "LIB/DMMVARS.X68"

        END    START        


















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
