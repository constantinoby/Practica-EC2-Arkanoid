; =============================================================================
; TITLE    : PAD MANAGEMENT
; AUTHOR   : Valentino Coppola Ferrari y Constantino Byelov Serdiuk
; =============================================================================

;------------------------------------------------------------------------------
BALLINIT
; INITIALIZE THE BALL
;BALLPOSX (W) (A0)
;BALLPOSY (W) 2(A0)
;BALLVELX (W) 4(A0)
;BALLVELY (W) 6(A0)
;------------------------------------------------------------------------------
            MOVEM.L D0/A1,-(A7)
            
            MOVE.W  #SCRWIDTH/2,(A0)
            MOVE.W  #SCRHEIGH/2,2(A0)
            
            JSR     UTLRAND                         ;RANDOMIZE BALL TRAJECTORY FROM START
            AND.L   #$0000000C,D0
            LEA     .VELVEC,A1 
            MOVE.W  (A1,D0),4(A0)
            MOVE.W  2(A1,D0),6(A0)
            
            MOVEM.L (A7)+,D0/A1
            RTS
        
.VELVEC     DC.W    -BALLSPEED,-BALLSPEED           ;0
            DC.W    -BALLSPEED,BALLSPEED            ;4
            DC.W    BALLSPEED,-BALLSPEED            ;8
            DC.W    BALLSPEED,BALLSPEED             ;12         

;------------------------------------------------------------------------------
BALLUPD
; BALL UPDATE
;------------------------------------------------------------------------------


            MOVEM.W  D0-D2/A2-A3,-(A7) 
            
            ;UPDATE BALL COORDINATES
            MOVE.W  (A0),D0
            ADD.W   4(A0),D0
            MOVE.W  D0,(A0)                         ; BALPOSX=BALPOSX+BALLSPEEDX
            
            MOVE.W  2(A0),D0
            ADD.W   6(A0),D0
            MOVE.W  D0,2(A0)                        ; BALPOSY=BALPOSY+BALLSPEEDY
            
            ; CHECK VERTICAL AND HORIZONTAL COLLISIONS
            
            CMP.W   #BALLRAD,(A0)                   ; LEFT SIDE COLLISION
            BLT     .COLLEFT                    
            CMP.W   #SCRWIDTH-BALLRAD,(A0)          ; CHECK RIGHT BOUNDARY
            BGT     .COLRGT                                 
.CHKVERT    CMP.W   #BALLRAD,2(A0)                  ; CHECK TOP BOUNDARY
            BLT     .COLTOP                  
            
            ; CHECK PAD COLLISIONS

            CMP.W   #PADY-PADHEIGH/2-BALLRAD,2(A0) ; CHECK IF BALL NOT UNDER PAD
            BLE     .COLBLOCK                      ; IF NOT UNDER PAD CHECK WALL COLLISION
            
            MOVE.W  (PADPOSX),D0           
            SUB.W   #PADWIDTH/2+BALLRAD,D0   
            CMP.W   (A0),D0                         ; CHECK IF BALL AT RIGHT SIDE OF PAD
            BGE     .CHECKBOT                       ; IF NOT THERE CHECK BOTTOM COLLISION 
           
            MOVE.W  (PADPOSX),D0
            ADD.W   #PADWIDTH/2+BALLRAD,D0   
            CMP.W   (A0),D0                         ; CHECK IF BALL AT LEFT SIDE OF PAD
            BLE     .CHECKBOT                       ; IF NOT THERE CHECK BOTTOM COLLISION          
            
            
            ;PAD COLLISION
            NEG.W   6(A0)         
            MOVE.W  #PADY-PADHEIGH/2-BALLRAD,2(A0)
            MOVE.B  #SNDHIT,D7
            TRAP    #SNDPLTN
            
            BRA     .END
            
            
            ; CHECK COLLISIONS WITH WALL

.COLBLOCK   MOVE.W  (BLOCKTOTAL),D2                 ; MOVE Nº OF BLOCKS TO D2 AND SUBSTRACT 1 PER CHECK.     
            SUB.W   #1,D2                   
            LEA     XLIST,A2                        ; LOAD BLOCK (X,Y) COORDINATES LIST
            LEA     YLIST,A3                
           
.LOADBLOCK  MOVE.W  (A2)+,(BLOCKPOSX)               ; LOAD NEXT BLOCK (X,Y) COORDINATES
            MOVE.W  (A3)+,(BLOCKPOSY)                   
           
            ; BOTTOM BLOCK COLLISION
            MOVE.W  (BLOCKPOSY),D0
            ADD.W   #BLOCKHEIGH/2+BALLRAD,D0
            CMP.W   2(A0),D0                        ; CHECK IF BALLPOSY IN SCREENHEIGH REGION
            BGE     .CHECKTOP                       ; IF IN REGION CHECK BALLPOSX 
            BRA     .CHECKWALL                      ; IF NOT CHECK WALL EXISTENCE
            
.CHECKTOP      
            ; TOP BLOCK COLLISION
            MOVE.W  (BLOCKPOSY),D0              
            SUB.W   #BLOCKHEIGH/2+BALLRAD,D0
            CMP.W   2(A0),D0                        ; CHECK IF BALL LOWER THAN TOP OF BLOCK
           
            ; BLOCK X LEFT SIDE
            MOVE.W  (BLOCKPOSX),D0              
            SUB.W   #BLOCKWIDTH/2+BALLRAD,D0
            CMP.W   (A0),D0                         ; BALL HIGHER THAN LEFT OF WALL?
            BGE     .CHECKWALL                      ; NO : CHECK IF ANY WALLS LEFT
            
            ; BLOCK X RIGHT SIDE
            MOVE.W  (BLOCKPOSX),D0
            ADD.W   #BLOCKWIDTH/2+BALLRAD,D0
            CMP.W   (A0),D0                         ; BALL LOWER THAN RIGHT OF WALL?
            BLE     .CHECKWALL                      ; NO : CHECK IF ANY WALLS LEFT 
            
            NEG.W   6(A0)          
            MOVE.B  #SNDHIT,D7
            TRAP    #SNDPLTN
            BRA     .END
            
.CHECKWALL  DBRA    D2,.LOADBLOCK                    ; IF THERE ARE BLOCKS LEFT REPEAT CHECKING
            MOVE.W  #0,(BLOCKPOSX)                   ; RESET BLOCK (X,Y)
            MOVE.W  #0,(BLOCKPOSY)              
            BRA     .CHECKBOT            
           
            

            ;LEFT SIDE COLLISION
.COLLEFT    NEG.W   4(A0) 
            MOVE.W  #BALLRAD,D0
            MOVE.B  #SNDWALL,D7
            TRAP    #SNDPLTN
            BRA     .CHKVERT  
            
            ;RIGHT SIDE COLLISION
.COLRGT     NEG.W   4(A0)
            MOVE.W  #SCRWIDTH-BALLRAD,D0
            MOVE.B  #SNDWALL,D7
            TRAP    #SNDPLTN
            BRA     .CHKVERT 

            ;TOP COLLISION
.COLTOP     NEG.W   6(A0)
            MOVE.W  #BALLRAD,D1
            MOVE.B  #SNDWALL,D7
            TRAP    #SNDPLTN
            BRA .END
            
            ;CHEKC IF BOTTOM COLLISION REALLY HAPPENED
.CHECKBOT   CMP.W   #SCRHEIGH-BALLRAD,2(A0)
            BGT .COLBOT
            BRA .END
            
            
            ;BOTTOM COLLISION
.COLBOT     SUBQ.W  #1,(LIFES)
            MOVE.W  #SCRWIDTH/2,(A0)
            MOVE.W  #SCRHEIGH/2,2(A0)
            MOVE.B  #SNDMISS,D7
            TRAP    #SNDPLTN
            
.END        SUB.W   #2,A2                   
            SUB.W   #2,A3
            MOVE.W  #0,(A2)                 ; DELETE BLOCK (X,Y) FROM LIST
            MOVE.W  #0,(A3)                 
            
            MOVEM.W  (A7)+,D0-D2/A2-A3
            RTS
            
            
;------------------------------------------------------------------------------            
BALLCONF
; BALL PLOT
;------------------------------------------------------------------------------
        MOVEM.L D0-D4,-(A7)
        ;SET PEN COLOR
        MOVE.B  #80,D0
        MOVE.L  #BALLPCOL,D1
        TRAP    #15
        
        ;SET FILL COLOR
        MOVE.B  #81,D0
        MOVE.L  #BALLFCOL,D1
        TRAP #15
        
        ;SET COORDINATES
        MOVE.W  (A0),D1
        SUB.W   #BALLRAD,D1
        MOVE.W  2(A0),D2
        SUB.W   #BALLRAD,D2
        MOVE.W  D1,D3
        ADD.W   #2*BALLRAD,D3
        MOVE.W  D2,D4
        ADD.W   #2*BALLRAD,D4
        
        ;DRAWCIRCLE
        MOVE.W  #88,D0  
        TRAP    #15
        
        MOVEM.L (A7)+,D0-D4
        
        RTS
        








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
