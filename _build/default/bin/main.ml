open Data
(**This will be our main game loop*)

exception Invalid

let get_piece_name (piece : Pieces.piece) = piece.name

let rec search (pieces : Pieces.piece list) (piece : string) =
  match pieces with
  | [] -> exit 0 (* GO BACK TO*)
  | h :: t ->
      if h.name = (piece |> int_of_string) then h else search t piece

let find_piece pname (cur_game : Players.game) : Pieces.piece =
  if cur_game.turn = 1 then search cur_game.player1.pieces pname
  else search cur_game.player2.pieces pname

let get_piece cur_game lst =
  match lst with
  | [] -> exit 0
  | h :: _ -> find_piece h cur_game

let check_int s =
  let int = try int_of_string s with Failure _ -> 0 in
  int

let get_row (lst : string list) : int =
  match lst with
  | [] -> 0
  | _ :: s :: _ -> check_int s
  | _ -> 0

let get_col lst : char =
  match lst with
  | [] -> ' '
  | _ :: _ :: t :: _ -> Char.uppercase_ascii t.[0]
  | _ -> ' '

let take_turn cur_game command : Players.result =
  (*need to make sure command is valid aka piece exists in piece list*)
  (*print_string (String.concat ", " (command));*)
  if Players.check_piece cur_game (List.hd command) then
    Players.move cur_game
      (get_piece cur_game command)
      (get_row command) (get_col command)
  else Invalid

let run_command cur_game command : Players.result =
  match command |> Command.parse with
  | Quit ->
      print_endline "Goodbye!";
      exit 0
  | Place phrase -> take_turn cur_game phrase
  | Malformed ->
      print_string "invalid string";
      Invalid

let print_cur_board (cur_game : Players.game) =
  match Print.print_board cur_game.board with
  | _ ->
      print_endline "";
      print_endline ""

let print_player (cur_game : Players.game) =
  if cur_game.turn = 1 then (
    ANSITerminal.print_string [ ANSITerminal.yellow ]
      ("player " ^ string_of_int cur_game.turn);
    print_endline ". Enter \"place [piece] [row] [column]\" or \"quit\"")
  else (
    ANSITerminal.print_string
      [ ANSITerminal.magenta ]
      ("player " ^ string_of_int cur_game.turn);
    print_endline ". Enter \"place [piece] [row] [column]\" or \"quit\"")

(*reads the new line and *)
let rec play_game (cur_game : Players.game) =
  print_cur_board cur_game;
  print_string "Make a move ";
  print_player cur_game;
  print_endline "Your available pieces:";
  print_string
    (String.concat ", " (Players.print_player_pieces cur_game));
  print_endline "";
  print_string ">";
  match read_line () with
  | exception End_of_file -> play_game cur_game
  | command -> (
      match run_command cur_game command with
      | Valid game -> play_game game
      | Invalid ->
          print_endline "";
          print_endline "";
          print_endline "";
          ANSITerminal.print_string [ ANSITerminal.red ]
            "Invalid Input. Try again!";
          play_game cur_game)

let main () =
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\nWelcome to Blokus \n";
  print_endline "";
  play_game
    {
      board = Board.get_empty_board Board.empty;
      player1 = Players.init_player "p1" Yellow;
      player2 = Players.init_player "p2" Purple;
      turn = 1;
    }

(* Execute the game engine. *)
let () = main ()