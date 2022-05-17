type point = {
  r : int;
  c : char;
}
(** [point] represents the row and column coordinates on the board*)

type piece = {
  name : int;
  color : Board.square;
  coordinates : point -> point list;
  all_coords : (point -> point list) list;
}
(** [piece] represents the piece number (shape of the piece), its color,
    and its coordinates. All pieces below are defined by their leftmost
    box. If there are multiple left most boxes, then the top one is
    used.*)

exception NotOnBoard
(** Raised when an piece is placed outside of the board coordinates *)

val p1 : (point -> point list) list
(** [p1] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 1 would cover.
    [p1] is a single 1x1 square *)

val p2 : (point -> point list) list
(** [p2] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 2 would cover.
    [p2] is a 1x2 horizontal piece *)

val p3 : (point -> point list) list
(** [p3] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 3 would cover.
    [p3] is a 1x3 horizontal piece *)

val p4 : (point -> point list) list
(** [p4] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 4 would cover.
    [p4] is a top right corner 3-square piece *)

val p5 : (point -> point list) list
(** [p5] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 5 would cover.
    [p5] is an upside down T 4-square piece *)

val p6 : (point -> point list) list
(** [p6] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 6 would cover.
    [p6] is a 2x2 block piece *)

val p7 : (point -> point list) list
(** [p7] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 7 would cover.
    [p7] is an L piece using a 1x1 and 1x3 piece *)

val p8 : (point -> point list) list
(** [p8] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 8 would cover.
    [p8] is a 1x4 horizontal piece *)

val p9 : (point -> point list) list
(** [p9] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 9 would cover.
    [p9] is a 4 square squiggle piece. *)

val p10 : (point -> point list) list
(** [p10] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 10 would cover.
    [p10] is complicated, look for yourself. *)

val p11 : (point -> point list) list
(** [p11] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 11 would cover
    [p11] is a 5 square cross. *)

val p12 : (point -> point list) list
(** [p12] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 12 would cover
    [p12] is a 2x2 block with an additional 1 square extension. *)

val p13 : (point -> point list) list
(** [p13] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 13 would cover
    [p13] is a 5 square squiggle piece *)

val p14 : (point -> point list) list
(** [p14] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 14 would cover
    [p14] is another 5 square squiggle *)

val p15 : (point -> point list) list
(** [p15] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 15 would cover
    [p15] is a 5 square L piece *)

val p16 : (point -> point list) list
(** [p16] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 16 would cover
    [p16] is an upside-down 5 square T *)

val p17 : (point -> point list) list
(** [p17] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 17 would cover
    [p17] is a 1x4 horizontal piece with one square extended. *)

val p18 : (point -> point list) list
(** [p18] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 18 would cover
    [p18] is an upside down C piece *)

val p19 : (point -> point list) list
(** [p19] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 19 would cover
    [p19] is a reversed [p9] *)

val p20 : (point -> point list) list
(** [p20] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 20 would cover.
    [p20] is a top left corner 5-square L *)

val p21 : (point -> point list) list
(** [p21] is a function that given a starting point on the board, retuns
    list of coordinates on the board that piece number 21 would cover.
    [p21] is a 1x5 horizontal piece *)

val place :
  piece -> point -> Board.square array array -> Board.square array array
(** [place p loc b] updates and returns the the board with piece [p]
    placed at point [loc] on the current board [b]*)
