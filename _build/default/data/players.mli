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

(** [result] represents the state of the game by whether there was a
    valid move and game should continue or whether the game ends or
    whether something occured that was invalid *)

val init_pieces : Board.square -> piece list
(**[init_pieces color] initializes a list of 21 pieces for each player
   according to their [color]*)

val init_player : string -> Board.square -> player
(**[init_player name color] initializes a new [player] with [name], all
   of the possible pieces with their [color], no used coordinates and
   not being done with their turn*)

val check_corners : point list -> game -> bool
(** [check_corners] returns [true] if the current piece attempting to be
    placed is touching the corner of a previously placed piece of the
    same player, else returns [false] *)

val print_player_pieces : game -> string list
(** [print_player_pieces game] lists all of the piece names of the
    available pieces left of the player whose turn it is according to
    the [game]*)

val check_piece : game -> string -> bool
(** [check_piece game piecename] returns [true] if the [piecename] is
    the piece list of the player whos current turn it is in, and
    therefore is still available to be used. Otherwise returns [false]. *)

val get_coordinates : int -> Board.square -> point -> point list
(** [get_coordinates piecename color] returns a function that given a
    starting position, outputs the list of coordinates of a given piece
    if it is a valid piece in the current player's piece list. *)

val check_not_overlapping_pieces : game -> piece -> point -> bool
(** [check_not_overlapping_pieces game piece loc] returns [true] if the
    [piece] at location [loc] is not overlapped with an existing piece
    on the board. Otherise returns [false]. *)

val valid_placement : game -> piece -> point -> bool
(** [check_placement game piece loc] returns [true] if the [piece] at
    location [loc] is a valid placement on the board, considering all of
    the rules of the game. Otherwise returns [false]. *)

val check_piece_in_list : game -> piece -> bool
(** [check_piece_in_list game piece] returns [true] if the [piece] is
    the piece list of the player whos current turn it is in, and
    therefore is still available to be used. Otherwise returns [false]. *)

val borders_to_check : point list -> point list -> point list
(** [borders_to_check piececoords lst game] Returns the list that
    contains all of the coordinates of the piece with all of the
    coordinates of its borders *)

val check_not_on_board : piece -> point -> bool
(** [check_not_on_board piece loc] Checks if [piece] starting at spot
    [point] is a valid position within the confines of the board space.
    Returns [true] if valid. Otherwise returns [false]. *)

val move : game -> piece -> int -> char -> result
(** [move game piece row col] returns a [Valid game] with [piece] moved
    to the position specified by [row] and [col] if this is a valid
    placement according to the game's rules. Otherwise will return
    [Invalid] or a [GameOver game] if this is the last move. *)

val get_score : game -> string
(**[get_score game] Returns a statement containing the score of each
   player according to their score in the [game].*)

val print_piece : string -> game -> unit array array
(**[print_piece piece game] Prints a single piece on a 5x5 grid*)

val is_valid_first_move : game -> piece -> point -> bool
(** [is_valid_first_move game piece pont] Returns [true] if the first
    piece is valid (placed in a corner) or [false] if not valid*)

val get_piece_coordinates : piece -> point -> point list
(** [get_piece_coordinates piece pont] Returns coordinates of the full
    [piece] with the starting position as [point]*)

val rotate_piece : game -> piece -> int -> player
(** [rotate_piece cur_game piece rotation] returns a new player with the
    selected piece rotated 90 degrees clockwise*)
