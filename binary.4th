: RAISE ( base exponent -- power )
  DUP
  IF
    1 -ROT
    0
    DO
      TUCK * SWAP
    LOOP
    DROP
  ELSE
    DROP DROP 1
  THEN ;

: BINARIZE ( decimal -- )
  0 3
  DO
    2 I RAISE
    2DUP
    < INVERT
    IF
      - ." 1"
    ELSE
      DROP ." 0"
    THEN
    -1
  +LOOP ;

: TEST
  0 BINARIZE CR
  1 BINARIZE CR
  2 BINARIZE CR
  BYE ;

TEST
