79 CONSTANT NAUGHT
88 CONSTANT CROSS

HEX 2500 DECIMAL CONSTANT LINE
HEX 2502 DECIMAL CONSTANT PIPE
HEX 252C DECIMAL CONSTANT TOP-WEDGE
HEX 2534 DECIMAL CONSTANT BOTTOM-WEDGE
HEX 251C DECIMAL CONSTANT LEFT-WEDGE
HEX 2524 DECIMAL CONSTANT RIGHT-WEDGE
HEX 253C DECIMAL CONSTANT PLUS
HEX 256D DECIMAL CONSTANT TOP-LEFT
HEX 256E DECIMAL CONSTANT TOP-RIGHT
HEX 256F DECIMAL CONSTANT BOTTOM-RIGHT
HEX 2570 DECIMAL CONSTANT BOTTOM-LEFT

10 CONSTANT NL

09 CONSTANT SIZE
32 CONSTANT EMPTY

\ ROW \
0 CONSTANT A
3 CONSTANT B
6 CONSTANT C

\ COLUMN \
0 CONSTANT FIRST
1 CONSTANT SECOND
2 CONSTANT THIRD

VARIABLE COUNT 8 COUNT !

VARIABLE PLAYER NAUGHT PLAYER !

VARIABLE BOARD SIZE CELLS ALLOT

: SQUARE
  CREATE
  , ,
  DOES>
    DUP
    1 CELLS +
    @ SWAP @ ;

A FIRST  SQUARE A1
A SECOND SQUARE A2
A THIRD  SQUARE A3

B FIRST  SQUARE B1
B SECOND SQUARE B2
B THIRD  SQUARE B3

C FIRST  SQUARE C1
C SECOND SQUARE C2
C THIRD  SQUARE C3

: .PLAYER
  PLAYER @ CR CROSS = IF ." CROSS" ELSE ." NAUGHT" THEN ;

: TOGGLE
  PLAYER @
  CROSS = IF NAUGHT ELSE CROSS THEN PLAYER ! ;

: INDEX-SQUARE  ( index# -- addr )
  CELLS
  BOARD
  + ;

: !SQUARE ( status row column -- )
  + INDEX-SQUARE ! ;

: INITIALIZE ( -- )
  3 0 DO
    3 0 DO
      EMPTY I 3 J * !SQUARE
    LOOP
  LOOP ;

: FETCH-SQUARE
  + INDEX-SQUARE @ ;

: SAME-THREE ( a b c -- boolean )
  + \  a b+c
  + \ a+b+c
  DUP \ X X
  CROSS \ X X CROSS
  3 \ X X CROSS 3
  * \ X X 3CROSS
  = \ X ?
  SWAP \ ? X
  NAUGHT 3 * \ ? X 3NAUGHT
  = \ 
  OR ;

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
  SAME-THREE ;

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
  SAME-THREE ;

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
  CHECK-COLUMNS  CHECK-ROWS  OR CHECK-DIAGONALS  OR ;

: 3LINE
  LINE DUP DUP ;

: SQUARE-CONTENTS ( -- 32 o|x 32 )
  32 COUNT @ INDEX-SQUARE @ 32 COUNT @ 1 - COUNT ! ;

: DRAW
  BOTTOM-RIGHT 3LINE BOTTOM-WEDGE 3LINE BOTTOM-WEDGE 3LINE BOTTOM-LEFT NL
  PIPE      SQUARE-CONTENTS     PIPE    SQUARE-CONTENTS     PIPE    SQUARE-CONTENTS    PIPE    NL
  RIGHT-WEDGE 3LINE PLUS 3LINE PLUS 3LINE LEFT-WEDGE     NL
  PIPE      SQUARE-CONTENTS     PIPE    SQUARE-CONTENTS     PIPE    SQUARE-CONTENTS    PIPE    NL
  RIGHT-WEDGE 3LINE PLUS 3LINE PLUS 3LINE LEFT-WEDGE     NL
  PIPE      SQUARE-CONTENTS     PIPE    SQUARE-CONTENTS     PIPE    SQUARE-CONTENTS    PIPE    NL
  TOP-RIGHT 3LINE TOP-WEDGE 3LINE TOP-WEDGE 3LINE TOP-LEFT NL
  14 7 * 0 DO XEMIT LOOP 8 COUNT ! ;

: PLAY ( row column -- )
  PLAYER @ -ROT !SQUARE DRAW WON IF .PLAYER 32 EMIT ." WON!" THEN TOGGLE ;

: ALTERNATE
  ." ALTERNATE:" CR
  PLAYER @ NAUGHT = IF ." OK" CR THEN
  TOGGLE
  PLAYER @ CROSS = IF ." OK" CR THEN
  TOGGLE
  PLAYER @ NAUGHT = IF ." OK" CR THEN ;

: INITIAL
  ." INITIAL:" CR
  DRAW ;

: SETTING-SQUARES
  ." SETTING-SQUARE:" CR
  ." BEFORE:" CR DRAW
  NAUGHT A FIRST !SQUARE
  CROSS C THIRD  !SQUARE
  ." AFTER:" CR DRAW ;

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
  WON IF ." OK" CR THEN ;

INITIALIZE
TEST
BYE
