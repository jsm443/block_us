type square =
  | Empty
  | Orange
  | Purple
  | Row of int
  | Col of char

exception Unimplemented

val board : square array array
val set : int -> char -> square -> unit
