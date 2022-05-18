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
(** [p1] is a list of functions that will return the coordinates of
    piece 1. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p1] is a
    single 1x1 square *)

val p2 : (point -> point list) list
(** [p2] is a list of functions that will return the coordinates of
    piece 2. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p2] is a 1x2
    horizontal piece *)

val p3 : (point -> point list) list
(** [p3] is a list of functions that will return the coordinates of
    piece 3. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p3] is a 1x3
    horizontal piece *)

val p4 : (point -> point list) list
(** [p4] is a list of functions that will return the coordinates of
    piece 4. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p4] is a top
    right corner 3-square piece *)

val p5 : (point -> point list) list
(** [p5] is a list of functions that will return the coordinates of
    piece 5. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p5] is an
    upside down T 4-square piece *)

val p6 : (point -> point list) list
(** [p6] is a list of functions that will return the coordinates of
    piece 6. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p6] is a 2x2
    block piece *)

val p7 : (point -> point list) list
(** [p7] is a list of functions that will return the coordinates of
    piece 7. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p7] is an L
    piece using a 1x1 and 1x3 piece *)

val p8 : (point -> point list) list
(** [p8] is a list of functions that will return the coordinates of
    piece 8. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p8] is a 1x4
    horizontal piece *)

val p9 : (point -> point list) list
(** [p9] is a list of functions that will return the coordinates of
    piece 9. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p9] is a 4
    square squiggle piece. *)

val p10 : (point -> point list) list
(** [p10] is a list of functions that will return the coordinates of
    piece 10. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p10] is
    complicated, look for yourself. *)

val p11 : (point -> point list) list
(** [p11] is a list of functions that will return the coordinates of
    piece 11. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p11] is a 5
    square cross. *)

val p12 : (point -> point list) list
(** [p12] is a list of functions that will return the coordinates of
    piece 12. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p12] is a 2x2
    block with an additional 1 square extension. *)

val p13 : (point -> point list) list
(** [p13] is a list of functions that will return the coordinates of
    piece 13. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations.[p13] is a 5
    square squiggle piece *)

val p14 : (point -> point list) list
(** [p14] is a list of functions that will return the coordinates of
    piece 14. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations.[p14] is another
    5 square squiggle *)

val p15 : (point -> point list) list
(** [p15] is a list of functions that will return the coordinates of
    piece 15. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations.[p15] is a 5
    square L piece *)

val p16 : (point -> point list) list
(** [p16] is a list of functions that will return the coordinates of
    piece 16. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations.[p16] is an
    upside-down 5 square T *)

val p17 : (point -> point list) list
(** [p17] is a list of functions that will return the coordinates of
    piece 17. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p17] is a 1x4
    horizontal piece with one square extended. *)

val p18 : (point -> point list) list
(** [p18] is a list of functions that will return the coordinates of
    piece 18. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations.[p18] is an
    upside down C piece *)

val p19 : (point -> point list) list
(** [p19] is a list of functions that will return the coordinates of
    piece 19. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p19] is a
    reversed [p9] *)

val p20 : (point -> point list) list
(** [p20] is a list of functions that will return the coordinates of
    piece 20. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p20] is a top
    left corner 5-square L *)

val p21 : (point -> point list) list
(** [p21] is a list of functions that will return the coordinates of
    piece 21. Given a starting point on the board, each function will
    generate the coordinates for one of the 4 rotations. [p21] is a 1x5
    horizontal piece *)

val place :
  piece -> point -> Board.square array array -> Board.square array array
(** [place p loc b] updates and returns the the board with piece [p]
    placed at point [loc] on the current board [b]*)
