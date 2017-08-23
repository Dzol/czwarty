: ASSERT ( x y -- )
  2DUP
  = IF
    ." Yey!" 2DROP
  ELSE
    ." Ney: " . ." ≠ " .
  THEN CR ;
