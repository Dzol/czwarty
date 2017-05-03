#! /usr/bin/env gforth

: FIBONACCI
  0 1 ROT
  0 DO
    TUCK +
  LOOP
  DROP ;

: TEST
  6 FIBONACCI 8 = IF ." OK" CR ELSE ." FAIL" THEN
  BYE ;

TEST
