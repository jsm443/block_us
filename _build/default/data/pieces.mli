type point = {
  r : int;
  c : char;
}

type piece = {
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
val place : piece -> point -> unit