(** [square] represents each piece on the board and whether it is a
    space, an empty tile, yellow, purple, or represents the border by a
    row number or column character *)
type square =
  | Space
  | Empty
  | Yellow
  | Purple
  | Row of int
  | Col of char

exception Unimplemented
(** Raised for functions that have not been implemented yet. *)

val get_empty_board : int -> square array array
(**[get_empty_board size] generates a square array array with an empty
   board of size n*)

val empty_5x5 : square list list
(**[empty] is an array representing the empty state of the mini board to
   help display a single piece*)

(* val empty_board : square array array *)

val get_empty_mini_board : square list list -> square array array
(**[get_empty_mini_board b] converts the board from a square list list
   to a square array array*)

val set_board : int -> char -> square -> square array array -> unit
(** [set_board row col square board] updates the square on the board of
    position (row, col) with the new square type *)
