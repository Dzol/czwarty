INCLUDE test.4th
INCLUDE prng.4th

9 CONSTANT SIZE
SIZE CONSTANT MODULUS

: BUILD-HASH-TABLE
  CREATE SIZE CELLS ALLOT ;

BUILD-HASH-TABLE TELEPHONE-NUMBERS

\ 1024 TELEPHONE-NUMBERS 64 SET

: SET ( table key value -- )
  -ROT LCG + ! ;

: GET ( table key -- value )
  LCG + @ ;

: TEST
  TELEPHONE-NUMBERS 8 64 SET
  TELEPHONE-NUMBERS 8 GET 64 ASSERT ;

TEST
BYE

\ does of tn ( key -- slot )
\ set ( slot value -- ) 
