type square =
  | Space
  | Empty
  | Yellow
  | Purple
  | Row of int
  | Col of char

exception Unimplemented

val game_board : square array array
val set_board : int -> char -> square -> square array array -> unit
