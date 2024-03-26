.unlz4
                  jsr    get_byte                    
                  sta    token
                  lsr    a
                  lsr    a
                  lsr    a
                  lsr    a
                  beq    read_offset
                  cmp    #$0f
                  jsr    getLength
.literals         jsr    get_byte
                  jsr    store
                  bne    literals
.read_offset      jsr    get_byte
                  tay
                  sec
                  eor    #$ff
                  adc    dest
                  sta    src

                  jsr    get_byte
                  tax
                  eor    #$ff
                  adc    dest+1
                  sta    src+1
                  tya
                  bne    not_done
                  txa
                  beq    unlz4_done
.not_done         lda    #$ff
token             =      *-1
                  and    #$0f
                  adc    #$03                            
                  cmp    #$13
                  jsr    getLength

.l1               lda    $ffff
src               =      *-2
                  inc    src
                  bne    skip2
                  inc    src+1
.skip2
                  jsr    store
                  bne    l1
                  beq    unlz4                           
.store            sta    $ffff
dest              =      *-2
                  inc    dest
                  bne    skip3
                  inc    dest+1
.skip3
                  dec    lenL
                  bne    unlz4_done
                  dec    lenH
.unlz4_done       
                  rts
.getLength_next   jsr    get_byte
                  tay
                  clc
                  adc    #$00
lenL              =      *-1
                  bcc    l2
                  inc    lenH
.l2               iny
.getLength        sta    lenL
                  beq    getLength_next
                  tay
                  beq    l3
                  inc    lenH
.l3               rts
.lenH             EQUB   $00

.get_byte         lda   $ffff
source            =     *-2
                  inc   source
			      bne   skip1
			      inc   source+1
.skip1
                  rts