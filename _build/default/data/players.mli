open Pieces

type player = {
  name : string;
  pieces : piece list;
  used_coords : point list;
}

type game = {
  board : Board.square array array;
  player1 : player;
  player2 : player;
  turn : int;
}

type result =
  | Valid of game
  | Invalid

val init_player : string -> Board.square -> player
val print_player_pieces : game -> string list

val check_overlap : game -> piece -> point -> bool
(**Checks if a piece is overlapped with an existing piece on the board.
   Returns true if so false if not.*)

val valid_placement : game -> piece -> point -> bool
(**Checks to ensure that the placement is valid on the board.*)

val check_piece_in_list : game -> piece -> bool
(**Checks to ensure that the player has the piece in their list*)

val move : game -> piece -> int -> char -> result
(**Takes a piece and attempts to place it. Runs a few checks and returns
   a Valid game or Invalid*)

val get_coordinates : int -> Board.square -> point -> point list
val check_piece : game -> string -> bool
