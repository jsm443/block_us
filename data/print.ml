
let pr_color c = ANSITerminal.print_string [c]

let print_square (s:square) =
  match s with
  |Empty -> 
  |Orange ->
  |Purple -> 


let rec print_row (row:square array)=
match row with
| [] -> []
| h::t -> print_square h print_row tail


let rec print_board (board : square array array) =
    match board with
      | [] -> []
      | h :: t -> print_row h print_board t
