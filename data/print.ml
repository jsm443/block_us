(*Prints an ANSITTerminal color c. For colors see github*)

let print_square (s : Board.square) =
  match s with
  | Empty ->
      ANSITerminal.print_string [ ANSITerminal.white ]
        (124 |> Char.chr |> Char.escaped)
  | Orange ->
      ANSITerminal.print_string [ ANSITerminal.yellow ]
        (124 |> Char.chr |> Char.escaped)
  | Purple ->
      ANSITerminal.print_string
        [ ANSITerminal.magenta ]
        (254 |> Char.chr |> Char.escaped)
  | Row x ->
      ANSITerminal.print_string [ ANSITerminal.black ] (string_of_int x)
  | Col x ->
      ANSITerminal.print_string [ ANSITerminal.black ] (Char.escaped x)

let print_row (row : Board.square array) =
  print_endline "";
  Array.map print_square row

let print_board (board : Board.square array array) =
  Array.map print_row board
