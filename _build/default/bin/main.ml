(**This will be our main game loop*)
open Data
exception Invalid

let get_piece_name (piece: Pieces.piece) =
  piece.name

let rec search (pieces:Pieces.piece list) (piece:string) = 
  match pieces with 
  | [] -> exit 0 (* GO BACK TO*)
  | h :: t -> if h.name = (piece|>int_of_string) then h else search t piece


let find_piece pname (cur_game:Players.game) : Pieces.piece=
  if cur_game.turn = 1 then search cur_game.player1.pieces pname else search cur_game.player2.pieces pname
let get_piece cur_game lst=
  match lst with
  | [] -> exit 0
  | h :: _ -> find_piece h cur_game

  let get_row (lst: string list) : int=
    match lst with
    | [] -> 0
    | _ :: s :: _ -> int_of_string s 
    | _ -> 0

    let get_col lst : char=
      match lst with
      | [] -> ' '
      | _ :: _ :: t :: _ -> t.[0]
      | _ -> ' '


  
  let take_turn cur_game command :Players.result=
  (*need to make sure command is valid aka piece exists in piece list*)  
  Players.move cur_game (get_piece cur_game command) (get_row command) (get_col command)

  let run_command cur_game command : Players.result=
    match command |> Command.parse with
    |Quit -> exit 0
    |Place phrase -> take_turn cur_game phrase
    |Malformed -> 
      print_string("invalid string");
      Invalid
    

  
    (*reads the new line and *)
let rec play_game (cur_game: Players.game) = 
  print_string("Make a move.  Enter \"place [piece]\" or \"quit\"");
  match read_line () with
  | exception End_of_file -> play_game cur_game
  | command -> match run_command cur_game command with
    |Valid game -> play_game(game)
    |Invalid -> play_game(cur_game)
  
let main () =
  ANSITerminal.print_string [ ANSITerminal.blue ]
    "\n\nWelcome to Blokus \n";
  print_endline "";
  play_game { board = Board.game_board; player1 = (Players.init_player "p1" Yellow); player2 = (Players.init_player "p2" Purple); turn = 1  }
  
(* Execute the game engine. *)
let () = main ()