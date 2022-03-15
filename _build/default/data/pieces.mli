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
val place : piece -> point -> unit