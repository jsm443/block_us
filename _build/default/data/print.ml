(*Prints an ANSITTerminal color c. For colors see github*)

let print_square (s : Board.square) =
  match s with
  | Empty ->
      ANSITerminal.print_string [ ANSITerminal.white ]
        ("  " ^ (124 |> Char.chr |> Char.escaped))
  | Orange ->
      ANSITerminal.print_string [ ANSITerminal.on_yellow ] "  ";
      ANSITerminal.print_string [ ANSITerminal.white ] "|"
  | Purple ->
      ANSITerminal.print_string [ ANSITerminal.on_magenta ] "  ";
      ANSITerminal.print_string [ ANSITerminal.white ] "|"
  | Row x ->
      if x < 10 then
        ANSITerminal.print_string [ ANSITerminal.white ]
          (string_of_int x ^ "  " ^ (124 |> Char.chr |> Char.escaped))
      else
        ANSITerminal.print_string [ ANSITerminal.white ]
          (string_of_int x ^ " " ^ (124 |> Char.chr |> Char.escaped))
  | Col x ->
      ANSITerminal.print_string [ ANSITerminal.white ]
        (Char.escaped x ^ "  ")
  | Space -> ANSITerminal.print_string [ ANSITerminal.white ] "    "

let print_row (row : Board.square array) =
  print_endline "";
  Array.map print_square row

let print_board (board : Board.square array array) =
  Array.map print_row board
