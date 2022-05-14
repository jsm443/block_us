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

(**Handles when a player types the "Done" command. Either returns the
   game in a GameOver state if both players are done or returns the game
   with it being the other players move.*)
let handle_done (cur_game : Players.game) =
  if
    (cur_game.turn = 1 && cur_game.player2.is_done)
    || (cur_game.turn = 2 && cur_game.player1.is_done)
  then Players.GameOver cur_game
  else if cur_game.turn = 1 then
    Valid
      {
        board = cur_game.board;
        player1 =
          {
            name = cur_game.player1.name;
            pieces = cur_game.player1.pieces;
            used_coords = cur_game.player1.used_coords;
            is_done = true;
          };
        player2 = cur_game.player2;
        turn = 2;
      }
  else
    Valid
      {
        board = cur_game.board;
        player1 = cur_game.player2;
        player2 =
          {
            name = cur_game.player2.name;
            pieces = cur_game.player2.pieces;
            used_coords = cur_game.player2.used_coords;
            is_done = true;
          };
        turn = 1;
      }

let handle_print_piece (p : string) (cur_game : Players.game) =
  match Players.print_piece p cur_game with
  | exception _ -> Players.Invalid
  | _ -> Players.Valid cur_game

let run_command cur_game command : Players.result =
  match command |> Command.parse with
  | Quit ->
      print_endline "Goodbye!";
      exit 0
  | Place phrase -> take_turn cur_game phrase
  | Done -> handle_done cur_game
  | See p -> handle_print_piece p cur_game
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
    print_endline
      ". Enter \"place [piece] [row] [column]\" or \"quit\" or \"done\"")
  else (
    ANSITerminal.print_string
      [ ANSITerminal.magenta ]
      ("player " ^ string_of_int cur_game.turn);
    print_endline
      ". Enter \"place [piece] [row] [column]\" or \"quit\" or \"done\"")

let is_first_move (cur_game : Players.game) =
  if List.length cur_game.player1.used_coords < 1 then true
  else if List.length cur_game.player2.used_coords < 1 then true
  else false

let rec play_game (cur_game : Players.game) =
  print_cur_board cur_game;
  print_string "Make a move ";
  print_player cur_game;
  if is_first_move cur_game then
    print_endline "This is your first move. You must start in a corner."
  else print_string "";
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
          play_game cur_game
      | GameOver game ->
          print_endline
            ("The game is over, " ^ Players.get_score game ^ ".");
          exit 0)

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