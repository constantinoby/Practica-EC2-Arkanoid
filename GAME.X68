; =============================================================================
; TITLE    : GAME MANAGEMENT
; AUTHOR   : Valentino Coppola Ferrari y Constantino Byelov Serdiuk
; =============================================================================

;------------------------------------------------------------------------------
GAMEINIT
; GAME INIT
;------------------------------------------------------------------------------
            MOVEM.L D0-D7/A1-A3,-(A7)
            
            JSR PADINIT
            JSR POINTINIT
            
            ;BALL INIT
            LEA     BALLINIT,A1                 ; WE CALL THE INITIALIZATION, UDPATE AND PLOT OF BALL
            LEA     BALLUPD,A2
            LEA     BALLCONF,A3
            MOVE.W  #1,D0                       ; WE SET THE BALLID TO 1 AND ADD IT TO THE GAME
         
            JSR     AGLADD
            
            ;BLOCK  INIT
            
            MOVE.L  #$00C0C0C0,(BLOCKFCOL)      ; SET BLOCK FILL COLOR
            MOVE.W  #80,(BLOCKPOSY)             ; SET FIRST BLOCK Y LINE
            MOVE.W  #50,(BLOCKPOSX)             ; SET FIRST BLOCK X LINE
            
            MOVE.W  #40,(BLOCKTOTAL)            ; DEFINE TOTAL BLOCKS NUMBER 
            MOVE.W  #3,D4                       ; SET NUMBER OF LINES (WITH DBRA IT WILL BECOME A GAME OF 3 LINES) 
            MOVE.W  #9,D3                       ; SET NUMBER OF BLOCKS PER LINE (WITH DBRA IT WILL BECOME A GAME OF 10 BLOCKS PER LINE)
            
            
            MOVE.W  #BLOCKID,D0                 ; DECLARE BLOCK AGENT ID
            MOVE.W  (BLOCKPOSX),D1              ; DECLARE BLOCK X PARAMETER
            MOVE.W  (BLOCKPOSY),D2              ; DECLARE BLOCK Y PARAMETER

            LEA     BLOCKINIT,A1                ; POINTER TO BLOCKINIT FUNCTION
            LEA     BLOCKUPD,A2                 ; POINTER TO BLOCKUPDATE FUNCTION
            LEA     BLOCKPLOT,A3                ; POINTER TO BLOCKPLOT FUNCTION 

            BRA .ADDBLOCK                       ; WE ADD THE FIRST BLOCK
            
.LOOP       ADD.W   #60,(BLOCKPOSX)             ; WITH THE LOOP WE ADD 60 PIXELS TO SET THE NEW BLOCK BESIDE THE LAST ONE
            MOVE.W  (BLOCKPOSX),D1              ; WE MOVE THE NEW BLOCKPOSX TO D1
            MOVE.W  (BLOCKPOSY),D2              ; WE MOVE THE BLOCKPOSY TO D2


.ADDBLOCK   JSR AGLADD                          ; WE ADD THE AGENT TO THE LIST
            DBRA D3,.LOOP                       ; WITH THIS DBRA WE ADD 10 AGENTS TO A Y POS FORMING A LINE.
          
            MOVE.W  #9,D3                       ; WE RESET THE NUMBER OF BLOCKS PER LINE
            MOVE.W  #50,(BLOCKPOSX)             ; RESET THE BLOCKPOSX 
            ADD.W  #35,(BLOCKPOSY)              ; ADD 35 PIXELS SO WE CONTINUE TO THE NEXT LINE
            
            DBRA   D4,.ADDBLOCK                 ; WITH THIS DBRA WE DO 2 MORE LINES
            MOVE.W  #50,(BLOCKPOSX)             ; RESET THE BLOCKPOSX TO NORMAL
            MOVE.W  #80,(BLOCKPOSY)             ; RESET THE BLOCKPOSY TO NORMAL
            
            MOVEM.L (A7)+,D0-D7/A1-A3
            RTS
            
            
;------------------------------------------------------------------------------
GAMEUPD
;UPDATE THE GAME
;
;------------------------------------------------------------------------------

            MOVEM.L D0-D7/A0-A2,-(A7)
            JSR     PADUPD                  ; PADUPDATE
          
            
            LEA     XLIST,A1                ; LOAD (X,Y) BLOCK LIST 
            LEA     YLIST,A2
            
            MOVE.W  #BLOCKID,D0             ; LOAD BLOCKID INTO D0
            JSR     DMMFRSTO                ; GET FIRST AGENT SEARCHING THE ID
            
.LOADBLOCKS 
            CMP.L   #0,A0                   ; CHECK IF BLOCK EXISTS
            BEQ     .AGTUPD                 ; IF DOESN'T EXIST UPDATE AGENT LIST
            
                                            ; NOW WE HAVE THE BLOCK ID IN D0, AND THE POINTER TO THE SLOT IN A0. 
            
            MOVE.W  8(A0),(A1)+             ; ADD AGENT (X,Y) COORDINATES TO LISTS
            MOVE.W  10(A0),(A2)+            
            
            JSR     DMMNEXTO                ; LOAD NEXT BLOCK
            BRA     .LOADBLOCKS             
            
            ; UPDATE AGENT LIST
.AGTUPD     JSR     AGLUPD                  ; UPDATE AGENT LIST  


            ; BLOCK AGENT KILL          
            LEA     BLOCKPOSX,A1            ; LOAD (X,Y) BLOCK COORDINATES
            LEA     BLOCKPOSY,A2
            
            MOVE.W  #BLOCKID,D0             ; LOAD BLOCKID INTO D0
            JSR     DMMFRSTO                ; GET FIRST AGENT SEARCHING THE ID
            
.BLOCKKILL  
            CMP.L   #0,A0                   ; CHECK IF BLOCK EXISTS
            BEQ     .WIN                    ; IF IT DOESN'T EXIST CHECK IF PLAYER WON
            
            MOVE.W  (A1),D2                 ; LOAD BLOCK
            MOVE.W  (A2),D3
            
            CMP.W    8(A0),D2               ; CHECK (X,Y) COORDINATES TO LOCATE THE 
            BNE     .NEXT                   ; BLOCK THAT WE NEED TO KILL                    
            CMP.W    10(A0),D3               
            BNE     .NEXT                   
            
            JSR     AGLKILL                 ; IF X=BLOCKPOSX & Y=BLOCKPOSY THEN WE HAVE LOCATED 
                                            ; THE BLOCK AND PROCCED TO KILL IT
                                            
            ADD.W  #10,(SCOPOINT)           ; ADD 10 POINT TO SCOREBOARD FOR BLOCK BREAK           
  
            MOVE.W  (BLOCKTOTAL),D4
            SUB.W   #1,D4                   ; DECREMENT Nº OF TOTAL BLOCKS 
            MOVE.W  D4,(BLOCKTOTAL)
            BRA     .WIN                    ; CHECK IF WIN

.NEXT       
            JSR     DMMNEXTO                ; GET NEXT BLOCK
            BRA     .BLOCKKILL  

.WIN    
            MOVE.W  (BLOCKTOTAL),D5
            CMP.W   #0,D5                   ; CHECK IF THERE ARE BLOCKS LEFT 
            
            BNE     .CHECKLIFES             ; CHECK PLAYER LIFES
            MOVE.W  #2,(STANEXT)            ; IF TEHRE ARE NO WALLS LEFT AND PLAYER HAS LIFES 
                                            ; THE PLAYER WON AND IS REDIRECTED TO WIN STATE
            BRA     .END
            
.CHECKLIFES            
            CMP     #0,(LIFES)              ; CHECK IF PLAYER HAS MORE THAN 0 LIFES 
            BLE     .GOVER                  ; IF PLAYER HAS 0 OR LESS LIFES, THE PLAYER LOST AND IS REDIRECTED TO GAME OVER STATE
            BRA     .END
            
.GOVER      
            MOVE.W  #3,(STANEXT)            ; GAME OVER

.END        MOVEM.L (A7)+,D0-D7/A0-A2
            RTS

;------------------------------------------------------------------------------
GAMEPLOT
; GAME PLOT 
;------------------------------------------------------------------------------
            JSR AGLPLOT
            JSR POINTPLOT
            JSR PADCONF
            RTS
      






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
