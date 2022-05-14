exception Unimplemented

(*A data structure which creates the board*)
(* open Yojson.Basic.Util *)

type square =
  | Space
  | Empty
  | Yellow
  | Purple
  | Row of int
  | Col of char

(*let get_empty_board json = json |> member "board" |> to_list |>
  List.map to_list*)

let get_empty_board (board : square list list) =
  Array.map Array.of_list (Array.of_list board)

let empty_5x5 =
  [
    [ Space; Empty; Empty; Empty; Empty; Empty ];
    [ Space; Empty; Empty; Empty; Empty; Empty ];
    [ Space; Empty; Empty; Empty; Empty; Empty ];
    [ Space; Empty; Empty; Empty; Empty; Empty ];
    [ Space; Empty; Empty; Empty; Empty; Empty ];
  ]

let empty =
  [
    [
      Space;
      Col 'A';
      Col 'B';
      Col 'C';
      Col 'D';
      Col 'E';
      Col 'F';
      Col 'G';
      Col 'H';
      Col 'I';
      Col 'J';
      Col 'K';
      Col 'L';
      Col 'M';
      Col 'N';
    ];
    [
      Row 1;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    ];
    [
      Row 2;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    ];
    [
      Row 3;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    ];
    [
      Row 4;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    ];
    [
      Row 5;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    ];
    [
      Row 6;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    ];
    [
      Row 7;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    ];
    [
      Row 8;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    ];
    [
      Row 9;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    ];
    [
      Row 10;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    ];
    [
      Row 11;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    ];
    [
      Row 12;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    ];
    [
      Row 13;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    ];
    [
      Row 14;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    ];
  ]

(*let empty_board = [| [| Space; Col 'A'; Col 'B'; Col 'C'; Col 'D'; Col
  'E'; Col 'F'; Col 'G'; Col 'H'; Col 'I'; Col 'J'; Col 'K'; Col 'L';
  Col 'M'; Col 'N'; |]; [| Row 1; Empty; Empty; Empty; Empty; Empty;
  Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; |]; [|
  Row 2; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
  Empty; Empty; Empty; Empty; Empty; |]; [| Row 3; Empty; Empty; Empty;
  Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
  Empty; |]; [| Row 4; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
  Empty; Empty; Empty; Empty; Empty; Empty; Empty; |]; [| Row 5; Empty;
  Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
  Empty; Empty; Empty; |]; [| Row 6; Empty; Empty; Empty; Empty; Empty;
  Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; |]; [|
  Row 7; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
  Empty; Empty; Empty; Empty; Empty; |]; [| Row 8; Empty; Empty; Empty;
  Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
  Empty; |]; [| Row 9; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
  Empty; Empty; Empty; Empty; Empty; Empty; Empty; |]; [| Row 10; Empty;
  Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
  Empty; Empty; Empty; |]; [| Row 11; Empty; Empty; Empty; Empty; Empty;
  Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; |]; [|
  Row 12; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
  Empty; Empty; Empty; Empty; Empty; |]; [| Row 13; Empty; Empty; Empty;
  Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
  Empty; |]; [| Row 14; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
  Empty; Empty; Empty; Empty; Empty; Empty; Empty; |]; |]*)

(*eventually this will check to make sure board is empty at this spot*)
(*set board should take in a point instead of r and c*)
let get_val (r : int) (c : char) (board : square array array) =
  board.(r).(Char.code c - 64)

let set_board
    (r : int)
    (c : char)
    (new_val : square)
    (board : square array array) =
  board.(r).(Char.code c - 64) <- new_val

(*testing with two L pieces*)
(*set_board 1 'B' Yellow; set_board 1 'C' Yellow; set_board 2 'C'
  Yellow; set_board 3 'C' Yellow; set_board 4 'C' Yellow; set_board 10
  'B' Purple; set_board 10 'C' Purple; set_board 11 'C' Purple;
  set_board 12 'C' Purple; set_board 13 'C' Purple*)
