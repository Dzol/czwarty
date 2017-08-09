3 CONSTANT SIZE

: SQUARE
  DUP * ;

VARIABLE WEIGHT SIZE SQUARE CELLS ALLOT

: GET-INDEX-NUMBER ( column row -- index# )
  SIZE * + ;

: GET-INDEX-ADDRESS  ( index# - index@ )
  CELLS WEIGHT  + ;

: ZERO?
  0 = ;

: .WEIGHT
  SIZE SQUARE 0 DO
    I 3 MOD ZERO? IF CR THEN
    I GET-INDEX-ADDRESS @ .
  LOOP ;

: INITIALIZE
  SIZE SQUARE 0 DO
    0 I GET-INDEX-ADDRESS !
  LOOP ;

: SET-WEIGHT ( column row value -- )
  -ROT GET-INDEX-NUMBER GET-INDEX-ADDRESS ! ;

: 3DUP ( P: x y z R: -- P: x y z x y z R: )
    DUP >R -ROT \ P: z x y R: z
    DUP >R -ROT \ P: y z x R: z y
    DUP >R -ROT \ P: x y z R: z y x
    R> R> R>    \ P: x y z x y z R:
;

INITIALIZE
1 1 6 SET-WEIGHT
0 1 3 SET-WEIGHT
1 0 3 SET-WEIGHT
.WEIGHT

: TEST-3DUP
    5 3 2 3DUP - - 4 = IF ." Yey!" CR THEN ;

TEST-3DUP

BYE
