VARIABLE PLAYER
0 PLAYER !

9 CONSTANT SIZE
95 CONSTANT EMPTY

79 CONSTANT NAUGHT
88 CONSTANT CROSS

\ ROW \
0 CONSTANT A
3 CONSTANT B
6 CONSTANT C

\ COLUMN \
0 CONSTANT FIRST
1 CONSTANT SECOND
2 CONSTANT THIRD

VARIABLE BOARD SIZE CELLS ALLOT

: TOGGLE
  PLAYER @
  IF 0 ELSE 1 THEN PLAYER ! ;

: INDEX-SQUARE  ( index# -- addr )
  CELLS
  BOARD
  + ;

: SET-SQUARE  ( palyer index# -- )
  INDEX-SQUARE ! ;

: !SQUARE ( player row column -- )
  + SET-SQUARE ;

: INITIALIZE ( -- )
  SIZE 0
  DO
    EMPTY I SET-SQUARE
  LOOP ;

: FETCH-SQUARE
  + INDEX-SQUARE @ ;

: SAME-THREE ( a b c -- boolean )
  TUCK \ a c b c
  =    \ a c X
  -ROT \ X a c
  =    \ X Y
  AND  \ TRUE/FALSE
;

: CHECK-COLUMN ( column -- boolean )
  DUP DUP \ c c c
  A       \ c c c a
  FETCH-SQUARE \ c c v
  -ROT    \ v c c
  B       \ v c c b
  FETCH-SQUARE \ v c v
  -ROT    \ v v c
  C       \ v v c C
  FETCH-SQUARE \ v v v
  SAME-THREE
;

: CHECK-ROW ( row -- boolean )
  DUP DUP \ c c c
  FIRST       \ c c c a
  FETCH-SQUARE \ c c v
  -ROT    \ v c c
  SECOND       \ v c c b
  FETCH-SQUARE \ v c v
  -ROT    \ v v c
  THIRD       \ v v c C
  FETCH-SQUARE \ v v v
  SAME-THREE
;

: CHECK-DIAGONALS ( -- boolean )
  A FIRST FETCH-SQUARE
  B SECOND FETCH-SQUARE
  C THIRD FETCH-SQUARE
  SAME-THREE \ X
  A THIRD FETCH-SQUARE
  B SECOND FETCH-SQUARE
  C FIRST FETCH-SQUARE
  SAME-THREE \ X Y
  OR ;

: CHECK-COLUMNS
  FIRST CHECK-COLUMN
  SECOND CHECK-COLUMN OR
  THIRD CHECK-COLUMN OR ;

: CHECK-ROWS
  A CHECK-ROW
  B CHECK-ROW OR
  C CHECK-ROW OR ;

: WON
  CHECK-COLUMNS CHECK-ROWS OR CHECK-DIAGONALS OR ;

INITIALIZE

: ALTERNATE
  ." ALTERNATE:" CR
  PLAYER @ 0 = IF ." OK" CR THEN
  TOGGLE
  PLAYER @ 1 = IF ." OK" CR THEN
  TOGGLE
  PLAYER @ 0 = IF ." OK" CR THEN ;

: .BOARD
  SIZE 0
  DO
    I . ." : "
    I INDEX-SQUARE @ EMIT CR
  LOOP ;

: INITIAL
  ." INITIAL:" CR
  .BOARD ;

: SETTING-SQUARES
  ." SETTING-SQUARE:" CR
  ." BEFORE:" CR .BOARD
  NAUGHT A FIRST !SQUARE
  CROSS C THIRD  !SQUARE
  ." AFTER:" CR .BOARD ;

: TEST
  ALTERNATE
  INITIAL
  SETTING-SQUARES
  ." SAME-THREE:" CR
  NAUGHT NAUGHT NAUGHT SAME-THREE IF ." OK" CR THEN
  CROSS CROSS CROSS SAME-THREE IF ." OK" CR THEN
  CROSS NAUGHT CROSS SAME-THREE INVERT IF ." OK" CR THEN
  ." CHECKING-COLUMNS:" CR
  NAUGHT A FIRST !SQUARE
  NAUGHT B FIRST !SQUARE
  NAUGHT C FIRST !SQUARE
  FIRST CHECK-COLUMN IF ." OK" CR THEN
  NAUGHT A FIRST !SQUARE
  CROSS  B FIRST !SQUARE
  NAUGHT C FIRST !SQUARE
  FIRST CHECK-COLUMN INVERT IF ." OK" CR THEN
  CROSS A FIRST !SQUARE
  CROSS B SECOND !SQUARE
  CROSS C THIRD !SQUARE
  CHECK-DIAGONALS IF ." OK" CR THEN
  WON IF ." OK" CR THEN
  BYE ;

TEST
