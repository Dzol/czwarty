02 CONSTANT A1
03 CONSTANT A2
05 CONSTANT A3

07 CONSTANT B1
11 CONSTANT B2
13 CONSTANT B3

17 CONSTANT C1
19 CONSTANT C2
23 CONSTANT C3

VARIABLE PLAYER

VARIABLE NAUGHT
VARIABLE CROSS

TRUE PLAYER !

: INITIALIZE ( -- )
  1 NAUGHT !
  1 CROSS ! ;

: ZERO? ( # -- ? ) 0 = ;

: WIN? ( # # # -- ? )
  * * MOD ZERO? ;

: DIAGONAL? ( # -- ? )
  @ DUP
  A1 B2 C3 WIN?
  SWAP
  A3 B2 C1 WIN?
  OR ;

: HORIZONTAL? ( # -- ? )
  @ DUP DUP
  A1 A2 A3 WIN?
  ROT
  B1 B2 B3 WIN?
  ROT
  C1 C2 C3 WIN?
  OR OR ;

: VERTICAL?  ( # -- ? )
  @ DUP DUP
  A1 B1 C1 WIN?
  ROT
  A2 B2 C2 WIN?
  ROT
  A3 B3 C3 WIN?
  OR OR ;

: FINNISH? ( # -- ? )
  DUP DUP
  DIAGONAL?
  ROT
  HORIZONTAL?
  ROT
  VERTICAL?
  OR OR ;

: MOVE ( @ # -- ? )
  SWAP DUP @ ROT * SWAP ! ;

: .SQUARE ( # -- )
  DUP
  NAUGHT @ SWAP MOD 0 = IF
    ." O"
    DROP
  ELSE
    CROSS @ SWAP MOD 0 = IF
      ." X"
    ELSE
      ."  "
    THEN
  THEN ;

: A ( -- # # # ) A3 A2 A1 ;
: B ( -- # # # ) B3 B2 B1 ;
: C ( -- # # # ) C3 C2 C1 ;

: .ROW ( # # # -- )
  ." │ "
  .SQUARE
  ."  │ "
  .SQUARE
  ."  │ "
  .SQUARE
  ."  │"
  CR ;

: .TOP ( -- )
  ." ╭───┬───┬───╮" CR ;

: .MIDDLE ( -- )
  ." ├───┼───┼───┤" CR ;

: .BOTTOM ( -- )
  ." ╰───┴───┴───╯" CR ;

: .GRID ( -- )
  .TOP
  A .ROW
  .MIDDLE
  B .ROW
  .MIDDLE
  C .ROW
  .BOTTOM ;

: PLAY ( # -- )
  PLAYER @ IF
    NAUGHT SWAP MOVE
    NAUGHT FINNISH? IF
      ." Naught won!" CR
      INITIALIZE
    THEN
    FALSE PLAYER !
  ELSE
    CROSS SWAP MOVE
    CROSS FINNISH? IF
      ." Crosses won!" CR
      INITIALIZE
    THEN
    TRUE PLAYER !
  THEN
  CR .GRID ;

INITIALIZE

: TEST ( -- )

  NAUGHT A1 MOVE
  NAUGHT B2 MOVE
  NAUGHT C3 MOVE

  NAUGHT DIAGONAL? IF
    ." YEY!"
  ELSE
    ." NEY!"
  THEN CR

  CROSS DIAGONAL? IF
    ." NEY!"
  ELSE
    ." YEY!"
  THEN CR

  CROSS A1 MOVE
  CROSS A2 MOVE
  CROSS A3 MOVE

  CROSS HORIZONTAL? IF
    ." YEY!"
  ELSE
    ." NEY!"
  THEN CR

  NAUGHT VERTICAL? IF
    ." NEY!"
  ELSE
    ." YEY!"
  THEN CR
  CROSS VERTICAL? IF
    ." NEY!"
  ELSE
    ." YEY!"
  THEN CR

  1 NAUGHT !
  1 CROSS !

  CROSS A1 MOVE
  CROSS A3 MOVE
  NAUGHT B2 MOVE
  CROSS C1 MOVE
  CROSS C3 MOVE

  .GRID ;

TEST BYE
