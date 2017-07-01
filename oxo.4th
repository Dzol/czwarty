02 constant A1
03 constant A2
05 constant A3

07 constant B1
11 constant B2
13 constant B3

17 constant C1
19 constant C2
23 constant C3

variable NAUGHT
variable CROSS

1 NAUGHT !
1 CROSS !

: ZERO? 0 = ;

: DIAGONAL?
  @ DUP
  2 11 23 * * mod ZERO?
  SWAP
  5 11 17 * * mod ZERO?
  OR ;

: PLAY
  SWAP DUP @ ROT * SWAP ! ;

: TEST
  NAUGHT A1 PLAY
  NAUGHT B2 PLAY
  NAUGHT C3 PLAY

  NAUGHT DIAGONAL? IF ." YEY!" ELSE ." NEY!" THEN CR

  CROSS  DIAGONAL? IF ." NEY!" ELSE ." YEY!" THEN CR ;

TEST BYE
