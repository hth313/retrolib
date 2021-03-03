ADDR_L:       .equlab 0x9f20
ADDR_M:       .equlab 0x9f21
ADDR_H:       .equlab 0x9f22
DATA0:        .equlab 0x9f23
DATA1:        .equlab 0x9f24
CTRL:         .equlab 0x9f25

              .extern _Zp
              .public clearBitmap
clearBitmap:
              lda     #1
              trb     CTRL          ; use port 0

              lda     zp:_Zp        ; set up address
              sta     ADDR_L
              lda     zp:_Zp+1
              sta     ADDR_M
              lda     zp:_Zp+2
              ora     #0x10         ; address increment 1
              sta     ADDR_H

              ldy     #75/5         ; 19200/256 /5 for loop unrolling
              ldx     #0            ; 256 for inner loop

10$:          stz     DATA0
              stz     DATA0
              stz     DATA0
              stz     DATA0
              stz     DATA0
              dex
              bne     10$
              dey
              bne     10$
              rts
