open Pieces

type player = {
  name : string;
  pieces : piece list;
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
val move : game -> piece -> int -> char -> result