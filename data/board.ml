exception Unimplemented

(*A data structure which creates the board*)
type square =
  | Space
  | Empty
  | Yellow
  | Purple
  | Row of int
  | Col of char

let get_empty_mini_board (board : square list list) =
  Array.map Array.of_list (Array.of_list board)

let empty_5x5 =
  [
    [ Empty; Space; Space; Space; Space; Space ];
    [ Empty; Space; Space; Space; Space; Space ];
    [ Empty; Space; Space; Space; Space; Space ];
    [ Empty; Space; Space; Space; Space; Space ];
    [ Empty; Space; Space; Space; Space; Space ];
    [ Empty; Space; Space; Space; Space; Space ];
  ]

let makecols n = if n = 0 then Space else Col (Char.chr (n + 64))
let makerow row_num n = if n = 0 then Row row_num else Empty

let get_empty_board n =
  [|
    Array.init n makecols;
    Array.init n (makerow 1);
    Array.init n (makerow 2);
    Array.init n (makerow 3);
    Array.init n (makerow 4);
    Array.init n (makerow 5);
    Array.init n (makerow 6);
    Array.init n (makerow 7);
    Array.init n (makerow 8);
    Array.init n (makerow 9);
    Array.init n (makerow 10);
    Array.init n (makerow 11);
    Array.init n (makerow 12);
    Array.init n (makerow 13);
    Array.init n (makerow 14);
  |]

let set_board
    (r : int)
    (c : char)
    (new_val : square)
    (board : square array array) =
  board.(r).(Char.code c - 64) <- new_val
