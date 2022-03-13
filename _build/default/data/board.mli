type square =
  | Empty
  | Orange
  | Purple
  | Row of int
  | Col of char

exception Unimplemented

val get_board : square array array
val set_board : square array array
