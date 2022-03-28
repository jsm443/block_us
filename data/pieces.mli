type point = {
  r : int;
  c : char;
}

type piece = {
  name : int;
  color : Board.square;
  coordinates : point -> point list;
}

val p1 : point -> point list
val p2 : point -> point list
val p3 : point -> point list
val p4 : point -> point list
val p5 : point -> point list
val p6 : point -> point list
val p7 : point -> point list
val p8 : point -> point list
val p9 : point -> point list
val p10 : point -> point list
val p11 : point -> point list
val p12 : point -> point list
val p13 : point -> point list
val p14 : point -> point list
val p15 : point -> point list
val p16 : point -> point list
val p17 : point -> point list
val p18 : point -> point list
val p19 : point -> point list
val p20 : point -> point list
val p21 : point -> point list

val place :
  piece -> point -> Board.square array array -> Board.square array array
