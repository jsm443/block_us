type square =
  | Space
  | Empty
  | Yellow
  | Purple
  | Row of int
  | Col of char

exception Unimplemented

val empty : square list list

(* val empty_board : square array array *)
val get_empty_board : square list list -> square array array
val set_board : int -> char -> square -> square array array -> unit
val get_val : int -> char -> square array array -> square
