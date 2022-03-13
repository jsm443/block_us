let pr_color c = ANSITerminal.print_string [ c ]
(**Prints an ANSITTerminal color c.  For colors see github*)
let pr_y = pr_color ANSITerminal.yellow

let print_square (s : Board.square) =
  match s with
  | Test -> "Test"
  | Row x -> string_of_int x
  | Col x -> Char.escaped x
  | Empty -> "|empty"
  | Orange -> "|Orange"
  | Purple -> "|Purple"
  

let print_row (row_num : int) (row : Board.square array)  =
  
  Array.map print_square row

let  print_board (board : Board.square array array) =
Array.map print_row board
