: COUNTER
  CREATE
  0 ,
  DOES>
    DUP
    @ SWAP
    1 SWAP
    +! ;

COUNTER FU

: TEST
  FU 0 = IF ." OK" CR THEN
  FU 1 = IF ." OK" CR THEN
  FU 2 = IF ." OK" CR THEN
  BYE ;

TEST
