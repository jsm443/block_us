open Pieces
(*exception Unimplemented*)

type player = {
  name : string;
  pieces : piece list;
}
type game = {
  board: Board.square array array;
  player1: player;
  player2: player;
  turn : int
}
(* this should be replaced with json to piece list*)
(*Inializes an array with all pieces in type piece*)
let init_pieces (col : Board.square) : piece list =
  [
    { name = 1; color = col; coordinates = p1 };
    { name = 2; color = col; coordinates = p2 };
    { name = 3; color = col; coordinates = p3 };
    { name = 4; color = col; coordinates = p4 };
    { name = 5; color = col; coordinates = p5 };
    { name = 6; color = col; coordinates = p6 };
    { name = 7; color = col; coordinates = p7 };
    { name = 8; color = col; coordinates = p8 };
    { name = 9; color = col; coordinates = p9 };
    { name = 10;color = col; coordinates = p10 };
    { name = 11;color = col; coordinates = p11 };
    { name = 12;color = col; coordinates = p12 };
    { name = 13;color = col; coordinates = p13 };
    { name = 14;color = col; coordinates = p14 };
    { name = 15;color = col; coordinates = p15 };
    { name = 16;color = col; coordinates = p16 };
    { name = 17;color = col; coordinates = p17 };
    { name = 18;color = col; coordinates = p18 };
    { name = 19;color = col; coordinates = p19 };
    { name = 20;color = col; coordinates = p20 };
    { name = 21;color = col; coordinates = p21 };
  ]

(*creates a new player with a name and its color*)
let init_player (n : string) (color : Board.square) : player =
  { name = n; pieces = init_pieces color }

type result = 
| Valid of game
| Invalid

(*let check_piece_in_list (pl : player) (tile: piece) =
  List.mem tile pl.pieces*)
  


(*exception Badcheck*)

(**Checkts that the pice does not have illegal overlap with another of their own pice*)
(*let check_overlap (tile : piece) (boardin : Board.square array array) (loc : point) =
  let tester = (*Board.get_empty_board*)Board.game_board in
    let tester = place tile loc tester in 
    for row = 0 to 7 do
      for  col = 0 to 7 do
          if (boardin.(row).(col) != Empty) && (tester.(row).(col) != Empty)
            then raise Badcheck else ()
  

(**Checks that the corners touch*)
let check_corners (tile : piece) (board : Board.square array array) (loc : point) = 
  raise Unimplemented

(**Checks that the piece fits completely within the board*)
let check_border (tile : piece) (board : Board.square array array)= 
  raise Unimplemented
*)
 let valid_placement (*(current_game:game) (tile: piece) (loc:point) *)=  
 false (*check_piece_in_list && check_corners && check_border && check_overlap *)


  (**Mutates the board and player 1 and player 2 piece arrays *)
let updated_game newboard p1 p2 turn=
  {board= newboard;
  player1 = p1;
  player2 = p2;
  turn = turn
  }

  let pieces_equal p1 p2 =
    p1!=p2
  let remove_tile_from_player (player:player) (p:piece) : player =
    {
      name = player.name;
      pieces = player.pieces |> List.filter (pieces_equal p)
    }
let nxt_turn cur_game =
  if cur_game.turn = 1 then 2 else 1
(*checks to see if the specific player made the mode, and if so, removes that 
  pieces from its piece list. beware if player name is neither,
    there will be a problem!*)
let place_and_delete_tile (cur_game:game) (tile: piece) (loc:point)= 
  if (cur_game.turn = 1) then Valid (updated_game (Pieces.place tile loc cur_game.board) (remove_tile_from_player cur_game.player1 tile) cur_game.player2 (nxt_turn cur_game))
  else if (cur_game.turn = 2) then Valid (updated_game(Pieces.place tile loc cur_game.board) cur_game.player1 (remove_tile_from_player cur_game.player2 tile) (nxt_turn cur_game))
  else Invalid

let move  (current_game:game) (tile: piece) (row:int) (col:char) = 
  let loc = {r = row; c = col} in 
  if (valid_placement (*current_game tile loc*)) 
    then (place_and_delete_tile  current_game tile loc)
else Invalid
