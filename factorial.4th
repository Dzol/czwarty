: FACTORIAL ( n -- n! )
  1 OVER 1 - DO
    I * -1
  +LOOP ;

: TEST
  2 FACTORIAL 2 = IF ." OK" CR THEN
  3 FACTORIAL 6 = IF ." OK" CR THEN
  BYE ;

TEST
