INCLUDE test.4th

\     +---+---+    +---+---+
\     |   |   |    |   |   |
\ *-->|   | ------>|   | -------> SENTINEL
\     +---+---+    +---+---+
\ HEAD
\ addr
\ ...
\ node value
\ next addr
\ ...

\ |   1
\ | 
\     2

: PAIR-CREATE ( -- @ )
    HERE 2 CELLS ALLOT ;

: PAIR-VALUE ( @ -- element )
    @ ;

: PAIR-NEXT ( @ -- next@ )
    1 CELLS + @ ;

: PAIR-SET-VALUE ( @ element -- )
    SWAP ! ;

: PAIR-SET-NEXT ( @ next@ -- )
\    SWAP 1 CELLS + .S ." IN PAIR SET NEXT" CR ! ;
    1 CELLS + .S ." IN PAIR SET NEXT" CR ! ;

VARIABLE HEAD

: TEST
    0                  \ 0
    .S CR
    10 0 DO            \ 0
	.S CR
	PAIR-CREATE    \ 0 A
	.S ." AFTER PAIR CREATE" CR
	I 9 = IF
	    DUP .S CR HEAD ! THEN
	.S ." AFTER SETTING HEAD IF FIRST ROUND " CR
	DUP            \ 0 A A
	.S CR
	I              \ 0 A A I
	.S ." I IS TOP OF STACK " CR
	PAIR-SET-VALUE \ 0 A
	.S ." AFTER PAIR SET VALUE " CR
	TUCK           \ A 0 A
	.S CR
	PAIR-SET-NEXT  \ A
	.S ." AFTER PAIR SET NEXT " CR
    LOOP ;

\ 1: val nxt

\ 1: I   nxt

\ 1: I   0

\ 1: I   0
\ 2: val nxt

\ 1: I   0
\ 2: I2  nxt

\ 1: I   0
\ 2: I2  nxt

    
\ PAIR-CREATE DUP DUP 5 PAIR-SET-VALUE PAIR-VALUE . PAIR-NEXT .
