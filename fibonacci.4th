#! /usr/bin/env gforth

INCLUDE test.4th

: FIBONACCI
  0 1 ROT
  0 DO
    TUCK +
  LOOP
  DROP ;

: TEST
  6 FIBONACCI 8 ASSERT
  6 FIBONACCI 7 ASSERT
  BYE ;

TEST
