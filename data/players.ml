open Pieces

type player = {
  name : string;
  pieces : piece list;
  used_coords : point list;
  is_done : bool;
}

type game = {
  board : Board.square array array;
  player1 : player;
  player2 : player;
  turn : int;
}

let init_pieces (col : Board.square) : piece list =
  [
    {   
      name = 1; color = col; coordinates = List.nth p1 0; all_coords = p1;
    };
    {
      name = 2; color = col; coordinates = List.nth p2 0; all_coords = p2;
    };
    { 
      name = 3; color = col; coordinates = List.nth p3 0; all_coords = p3;
    };
    {
      name = 4; color = col; coordinates = List.nth p4 0; all_coords = p4;
    };
    {
      name = 5; color = col; coordinates = List.nth p5 0; all_coords = p5;
    };
    {
      name = 6; color = col; coordinates = List.nth p6 0; all_coords = p6;
    };
    { 
      name = 7; color = col; coordinates = List.nth p7 0; all_coords = p7;
    };
    { 
      name = 8; color = col; coordinates = List.nth p8 0; all_coords = p8;
    };
    {
      name = 9; color = col; coordinates = List.nth p9 0; all_coords = p9;
    };
    {
      name = 10; color = col; coordinates = List.nth p10 0; all_coords = p10;
    };
    {
      name = 11; color = col; coordinates = List.nth p11 0; all_coords = p11;
    };
    {
      name = 12; color = col; coordinates = List.nth p12 0; all_coords = p12;
    };
    {
      name = 13; color = col; coordinates = List.nth p13 0; all_coords = p13;
    };
    { 
      name = 14; color = col; coordinates = List.nth p14 0; all_coords = p14;
    };
    { 
      name = 15; color = col; coordinates = List.nth p15 0; all_coords = p15;
    };
    { 
      name = 16; color = col; coordinates = List.nth p16 0; all_coords = p16;
    };
    { 
      name = 17; color = col; coordinates = List.nth p17 0; all_coords = p17;
    };
    { 
      name = 18; color = col; coordinates = List.nth p18 0; all_coords = p18;
    };
    { 
      name = 19; color = col; coordinates = List.nth p19 0; all_coords = p19;
    };
    { 
      name = 20; color = col; coordinates = List.nth p20 0; all_coords = p20;
    };
    {  
      name = 21; color = col; coordinates = List.nth p21 0; all_coords = p21;
    };
  ] [@@ocamlformat "disable=true"]

let init_player (n : string) (color : Board.square) : player =
  {
    name = n;
    pieces = init_pieces color;
    used_coords = [];
    is_done = false;
  }

let rec get_piece_names (lst : piece list) : string list =
  match lst with
  | [] -> []
  | h :: t -> string_of_int h.name :: get_piece_names t

let print_player_pieces (cur_game : game) : string list =
  if cur_game.turn = 1 then get_piece_names cur_game.player1.pieces
  else get_piece_names cur_game.player2.pieces

type result =
  | Valid of game
  | GameOver of game
  | Invalid

let updated_game newboard p1 p2 turn =
  { board = newboard; player1 = p1; player2 = p2; turn }

let get_piece_coordinates (tile : piece) (loc : point) =
  tile.coordinates loc

let updatecoords (tile : piece) (loc : point) (cur_game : game) =
  if cur_game.turn = 1 then
    get_piece_coordinates tile loc @ cur_game.player1.used_coords
  else get_piece_coordinates tile loc @ cur_game.player2.used_coords

let rec borders_to_check
    (piece_coords : point list)
    (to_check : point list) : point list =
  match piece_coords with
  | h :: t ->
      borders_to_check t
        (let borders = [] in
         let p1 = { r = h.r + 1; c = h.c } in
         let p2 = { r = h.r; c = char_of_int (int_of_char h.c - 1) } in
         let p3 = { r = h.r - 1; c = h.c } in
         let p4 = { r = h.r; c = char_of_int (int_of_char h.c + 1) } in
         let first =
           if List.mem p1 to_check then borders else p1 :: borders
         in
         let second =
           if List.mem p1 to_check then borders else p2 :: first
         in
         let third =
           if List.mem p1 to_check then borders else p3 :: second
         in
         let fourth =
           if List.mem p1 to_check then borders else p4 :: third
         in
         fourth @ to_check)
  | [] -> to_check

let rec corners_to_check
    (piece_coords : point list)
    (to_check : point list) : point list =
  match piece_coords with
  | h :: t ->
      corners_to_check t
        (let corners = [] in
         let p1 =
           { r = h.r + 1; c = char_of_int (int_of_char h.c + 1) }
         in
         let p2 =
           { r = h.r + 1; c = char_of_int (int_of_char h.c - 1) }
         in
         let p3 =
           { r = h.r - 1; c = char_of_int (int_of_char h.c - 1) }
         in
         let p4 =
           { r = h.r - 1; c = char_of_int (int_of_char h.c + 1) }
         in
         let first =
           if List.mem p1 to_check then corners else p1 :: corners
         in
         let second =
           if List.mem p1 to_check then corners else p2 :: first
         in
         let third =
           if List.mem p1 to_check then corners else p3 :: second
         in
         let fourth =
           if List.mem p1 to_check then corners else p4 :: third
         in
         fourth @ to_check)
  | [] -> to_check

let get_player_coords game =
  if game.turn = 1 then game.player1.used_coords
  else game.player2.used_coords

let rec check_corners (to_check : point list) (game : game) : bool =
  match to_check with
  | h :: t ->
      if List.exists (fun x -> x = h) (get_player_coords game) then true
      else check_corners t game
  | [] -> false

let rec check_borders (to_check : point list) (game : game) : bool =
  match to_check with
  | h :: t ->
      if List.exists (fun x -> x = h) (get_player_coords game) then
        false
      else check_borders t game
  | [] -> true

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

let check_not_overlapping_pieces
    (current_game : game)
    (tile : piece)
    (loc : point) : bool =
  is_overlap current_game.board
    (Pieces.place tile loc (Board.get_empty_board 15))

let check_not_on_board (tile : piece) (loc : point) =
  match Pieces.place tile loc (Board.get_empty_board 15) with
  | exception _ -> false
  | _ -> true

let is_first_turn (cur_game : game) =
  if
    List.length cur_game.player1.used_coords >= 1
    && cur_game.player2.is_done
  then false
  else if
    List.length cur_game.player2.used_coords >= 1
    && cur_game.player1.is_done
  then false
  else if List.length (get_player_coords cur_game) < 1 then true
  else false

let is_a_corner (point : point) : bool =
  (point.c = 'A' && point.r = 1)
  || (point.c = 'N' && point.r = 1)
  || (point.c = 'A' && point.r = 14)
  || (point.c = 'N' && point.r = 14)

let is_valid_first_move
    (current_game : game)
    (tile : piece)
    (loc : point) : bool =
  let coords = tile.coordinates loc in
  if is_first_turn current_game then List.exists is_a_corner coords
  else true

let valid_placement (current_game : game) (tile : piece) (loc : point) =
  check_not_on_board tile loc
  && (if not (is_first_turn current_game) then
      check_corners
        (corners_to_check (get_piece_coordinates tile loc) [])
        current_game
     else is_valid_first_move current_game tile loc)
  && check_borders
       (borders_to_check (get_piece_coordinates tile loc) [])
       current_game
  && check_not_on_board tile loc
  && check_not_overlapping_pieces current_game tile loc
  && check_piece_in_list current_game tile

let pieces_equal p1 p2 = p1 != p2

let remove_tile_from_player
    (player : player)
    (p : piece)
    (loc : point)
    (cur_game : game) : player =
  {
    name = player.name;
    pieces = player.pieces |> List.filter (pieces_equal p);
    used_coords = updatecoords p loc cur_game;
    is_done = false;
  }

let nxt_turn cur_game =
  if cur_game.turn = 1 && cur_game.player2.is_done = false then 2
  else if cur_game.turn = 1 && cur_game.player2.is_done = true then 1
  else if cur_game.turn = 2 && cur_game.player1.is_done = false then 1
  else 2

let place_and_delete_tile (cur_game : game) (tile : piece) (loc : point)
    =
  if cur_game.turn = 1 then
    Valid
      (updated_game
         (Pieces.place tile loc cur_game.board)
         (remove_tile_from_player cur_game.player1 tile loc cur_game)
         cur_game.player2 (nxt_turn cur_game))
  else if cur_game.turn = 2 then
    Valid
      (updated_game
         (Pieces.place tile loc cur_game.board)
         cur_game.player1
         (remove_tile_from_player cur_game.player2 tile loc cur_game)
         (nxt_turn cur_game))
  else Invalid

let move (current_game : game) (tile : piece) (row : int) (col : char) =
  let loc = { r = row; c = col } in
  if valid_placement current_game tile loc then
    place_and_delete_tile current_game tile loc
  else Invalid

exception NotInPieceList

let print_p (p : piece) =
  let rec pp loc =
    let x = Board.get_empty_mini_board Board.empty_5x5 in
    match place p loc x with
    | exception NotOnBoard -> pp { r = loc.r + 1; c = loc.c }
    | _ -> Print.print_5x5 x
  in
  pp { r = 0; c = 'A' }

let print_piece (piece_name : string) (cur_game : game) =
  let rec find_p (p_list : piece list) =
    match p_list with
    | h :: t ->
        if h.name = int_of_string piece_name then print_p h
        else find_p t
    | [] -> raise NotInPieceList
  in
  if cur_game.turn = 1 then find_p cur_game.player1.pieces
  else find_p cur_game.player2.pieces

let get_player_score (player : player) : int =
  89 - List.length player.used_coords

let get_score (game : game) : string =
  let p1_score = get_player_score game.player1 in
  let p2_score = get_player_score game.player2 in
  let win_statement =
    if p1_score < p2_score then "Player 1 wins! "
    else if p2_score < p1_score then "Player 2 Wins! "
    else "It's a tie! "
  in
  win_statement ^ "Player 1's score is " ^ string_of_int p1_score
  ^ ". Player 2's score is " ^ string_of_int p2_score

let rec replace_piece list pos (new_piece : piece) : piece list =
  match list with
  | [] -> list
  | h :: t ->
      if pos = 0 then new_piece :: replace_piece t (pos - 1) new_piece
      else h :: replace_piece t (pos - 1) new_piece

let rec find (p : piece) (list : piece list) =
  match list with
  | [] -> raise NotInPieceList
  | h :: t -> if p.name = h.name then 0 else 1 + find p t

let find_piece_location_in_list (cur_game : game) (p : piece) =
  if cur_game.turn = 1 then find p cur_game.player1.pieces
  else if cur_game.turn = 2 then find p cur_game.player2.pieces
  else raise NotInPieceList

let get_new_coords (p : piece) (rotation : int) =
  {
    name = p.name;
    color = p.color;
    coordinates = List.nth p.all_coords (rotation mod 4);
    all_coords = p.all_coords;
  }

let rotate_piece (cur_game : game) (p : piece) (rotation : int) : player
    =
  if cur_game.turn = 1 && check_piece_in_list cur_game p then
    {
      name = cur_game.player1.name;
      pieces =
        replace_piece cur_game.player1.pieces
          (find_piece_location_in_list cur_game p)
          (get_new_coords p rotation);
      used_coords = cur_game.player1.used_coords;
      is_done = cur_game.player1.is_done;
    }
  else if cur_game.turn = 2 && check_piece_in_list cur_game p then
    {
      name = cur_game.player2.name;
      pieces =
        replace_piece cur_game.player2.pieces
          (find_piece_location_in_list cur_game p)
          (get_new_coords p rotation);
      used_coords = cur_game.player2.used_coords;
      is_done = cur_game.player2.is_done;
    }
  else raise NotInPieceList
