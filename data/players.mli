open Pieces

type player = {
  name : string;
  pieces : piece list;
  used_coords : point list;
  is_done : bool;
}
(** [player] represents each person by their color, their list of
    available pieces, the pieces they have used and whether their turn
    is done *)

type game = {
  board : Board.square array array;
  player1 : player;
  player2 : player;
  turn : int;
}
(** [game] represents the state of the game by the board, each player in
    the game, and whose turn it is *)

type result =
  | Valid of game
  | GameOver of game
  | Invalid
      (** [result] represents the state of the game by whether there was
          a valid move and game should continue or whether the game ends
          or whether something occured that was invalid *)

val init_player : string -> Board.square -> player
(**[init_player name color] initializes a new [player] with [name], all
   of the possible pieces with their [color], no used coordinates and
   not being done with their turn*)

val print_player_pieces : game -> string list
(** [print_player_pieces game] lists all of the piece names of the
    available pieces left of the player whose turn it is according to
    the [game]*)

val check_overlapping_pieces : game -> piece -> point -> bool
(** [check_overlapping_pieces game piece loc] returns [true] if the
    [piece] at location [loc] is overlapped with an existing piece on
    the board. Otherise returns [false]. *)

val valid_placement : game -> piece -> point -> bool
(** [check_placement game piece loc] returns [true] if the [piece] at
    location [loc] is a valid placement on the board, considering all of
    the rules of the game. Otherwise returns [false]. *)

val check_piece_in_list : game -> piece -> bool
(** [check_piece_in_list game piece] returns [true] if the [piece] is
    the piece list of the player whos current turn it is in, and
    therefore is still available to be used. Otherwise returns [false]. *)

val move : game -> piece -> int -> char -> result
(** [move game piece row col] returns a [Valid game] with [piece] moved
    to the position specified by [row] and [col] if this is a valid
    placement according to the game's rules. Otherwise will return
    [Invalid] or a [GameOver game] if this is the last move. *)

val get_coordinates : int -> Board.square -> point -> point list
(**[get_coordinates piecename square] returns function that takes in a
   starting point of a piece and returns the full list of coordinates
   that piece takes up on the board -------NOT SURE IF THIS IS
   CORRECT--------*)

val check_piece : game -> string -> bool
(**NOT SURE IF WE EVER ACTUALLY USE THIS FUNCTION--- WE SHOULD COMMENT
   OUT IF NOT*)

val get_score : game -> string
(**[get_score game] Returns a statement containing the score of each
   player.*)

val print_piece : string -> game -> unit array array
(**[print_piece piece game] Prints a single piece on a 5x5 grid*)