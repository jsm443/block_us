type square =
  | Space
  | Empty
  | Orange
  | Purple
  | Row of int
  | Col of char

exception Unimplemented

val board : square array array
val set_board : int -> char -> square -> unit
