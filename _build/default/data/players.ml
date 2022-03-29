open Pieces
(*exception Unimplemented*)

type player = {
  name : string;
  pieces : piece list;
}

type game = {
  board : Board.square array array;
  player1 : player;
  player2 : player;
  turn : int;
  used_coords : point list;
}

(* let used_coords : point list = [] *)

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
    { name = 10; color = col; coordinates = p10 };
    { name = 11; color = col; coordinates = p11 };
    { name = 12; color = col; coordinates = p12 };
    { name = 13; color = col; coordinates = p13 };
    { name = 14; color = col; coordinates = p14 };
    { name = 15; color = col; coordinates = p15 };
    { name = 16; color = col; coordinates = p16 };
    { name = 17; color = col; coordinates = p17 };
    { name = 18; color = col; coordinates = p18 };
    { name = 19; color = col; coordinates = p19 };
    { name = 20; color = col; coordinates = p20 };
    { name = 21; color = col; coordinates = p21 };
  ]

(*creates a new player with a name and its color*)
let init_player (n : string) (color : Board.square) : player =
  { name = n; pieces = init_pieces color }

let rec get_piece_names (lst : piece list) : string list =
  match lst with
  | [] -> []
  | h :: t -> string_of_int h.name :: get_piece_names t

let print_player_pieces (cur_game : game) : string list =
  if cur_game.turn = 1 then get_piece_names cur_game.player1.pieces
  else get_piece_names cur_game.player2.pieces

type result =
  | Valid of game
  | Invalid

(*let check_piece_in_list (pl : player) (tile: piece) = List.mem tile
  pl.pieces*)

(*exception Badcheck

  let handle_check_overlap (tile : piece) (boardin : Board.square array
  array) (loc : point) = let tester = Board.get_empty_board Board.empty
  in let tester = place tile loc tester in for row = -1 to 6 do for col
  = -1 to 6 do if boardin.(row + loc.r).(col) != Empty &&
  tester.(row).(col + Char.code loc.c) != Empty then raise Badcheck else
  () done done

  let check_overlap (tile : piece) (boardin : Board.square array array)
  (loc : point) = match handle_check_overlap tile boardin loc with |
  exception _ -> [] | _ -> []*)

(* (*Checks that the corners touch*) let check_corners (tile : piece)
   (board : Board.square array array) (loc : point) = raise
   Unimplemented

   (**Checks that the piece fits completely within the board*) let
   check_border (tile : piece) (board : Board.square array array)= raise
   Unimplemented *)

(**Checkts that the pice does not have illegal overlap with another of
   their own pice*)

let rec g_c n (plist : piece list) =
  match plist with
  | [] -> exit 0
  | h :: t -> if h.name = n then h.coordinates else g_c n t

let get_coordinates (n : int) (color : Board.square) :
    point -> point list =
  color |> init_pieces |> g_c n

let rec checkpieces (lst : piece list) (piecename : int) =
  match lst with
  | [] -> false
  | h :: t ->
      if h.name = piecename then true else checkpieces t piecename

let check_piece (cur_game : game) (name : string) =
  let piecename = int_of_string name in
  if cur_game.turn = 1 then
    checkpieces cur_game.player1.pieces piecename
  else checkpieces cur_game.player2.pieces piecename

let check_piece_in_list (cur_game : game) (tile : piece) =
  if cur_game.turn = 1 then List.mem tile cur_game.player1.pieces
  else if cur_game.turn = 2 then List.mem tile cur_game.player2.pieces
  else false

(*let check_square (s1 : Board.square) (s2 : Board.square) : bool =
  match (s1, s2) with | Empty, _ -> true | x, y -> x = y && (not (x =
  Yellow && y = Yellow)) && not (x = Purple && y = Purple)*)

let check_square (s1 : Board.square) (s2 : Board.square) : bool =
  match (s1, s2) with
  | Empty, _ -> true
  | x, Empty ->
      if x = Yellow || x = Purple || x = Empty then true else false
  | x, y ->
      x = y
      && (not (x = Yellow && y = Yellow))
      && not (x = Purple && y = Purple)

let cycle_row (b1 : Board.square array) (b2 : Board.square array) =
  Array.map2 check_square b1 b2

let is_true (b : bool) : bool = b
let row_true (b : bool array) = b |> Array.for_all is_true

let array_all_true (a : bool array array) : bool =
  a |> Array.for_all row_true

let is_overlap cur_board new_board =
  Array.map2 cycle_row cur_board new_board |> array_all_true

let check_overlap (cur_game : game) (tile : piece) (loc : point) : bool
    =
  is_overlap cur_game.board
    (Pieces.place tile loc (Board.get_empty_board Board.empty))

let valid_placement (current_game : game) (tile : piece) (loc : point) =
  check_overlap current_game tile loc
  && check_piece_in_list current_game tile
(*&& check_corners && check_border *)

(**Mutates the board and player 1 and player 2 piece arrays *)
let updated_game newboard p1 p2 turn c =
  {
    board = newboard;
    player1 = p1;
    player2 = p2;
    turn;
    used_coords = c;
  }

let pieces_equal p1 p2 = p1 != p2

let remove_tile_from_player (player : player) (p : piece) : player =
  {
    name = player.name;
    pieces = player.pieces |> List.filter (pieces_equal p);
  }

let nxt_turn cur_game = if cur_game.turn = 1 then 2 else 1

(*checks to see if the specific player made the mode, and if so, removes
  that pieces from its piece list. beware if player name is neither,
  there will be a problem!*)
let place_and_delete_tile (cur_game : game) (tile : piece) (loc : point)
    =
  if cur_game.turn = 1 then
    Valid
      (updated_game
         (Pieces.place tile loc cur_game.board)
         (remove_tile_from_player cur_game.player1 tile)
         cur_game.player2 (nxt_turn cur_game) cur_game.used_coords)
  else if cur_game.turn = 2 then
    Valid
      (updated_game
         (Pieces.place tile loc cur_game.board)
         cur_game.player1
         (remove_tile_from_player cur_game.player2 tile)
         (nxt_turn cur_game) cur_game.used_coords)
  else Invalid

let move (current_game : game) (tile : piece) (row : int) (col : char) =
  let loc = { r = row; c = col } in
  if valid_placement current_game tile loc then
    place_and_delete_tile current_game tile loc
  else Invalid

(* let updatecoords (tile : piece) (loc : point) = let rec uc coords =
   match coords with | [] -> () | h :: t -> used_coords <- h ::
   !used_coords; uc t in uc (tile.coordinates loc) *)

(* let updatecoords (tile : piece) (loc : point) cur_game = updated_game
   cur_game.board cur_game.player1 cur_game.player2 cur_game.turn
   (tile.coordinates loc @ cur_game.used_coords)

   let check_lap cur_game point = if List.mem cur_game.used_coords point
   then true else false *)
