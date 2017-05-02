#! /usr/bin/env gforth

: FIBONACCI
  0 SWAP
  1 SWAP
  0 DO
    TUCK +
  LOOP
  DROP ;

: TEST
  6 FIBONACCI 8 = IF ." OK" CR ELSE ." FAIL" THEN
  BYE ;

TEST
