open OUnit2
open Data
open Print
open Board
open Pieces
let piece1 = {color = Orange; coordinates = p1};;
let piece2 = {color = Orange; coordinates = p2};;

place piece1 { r = 5; c = 'F' };;
place piece2 { r = 7; c = 'A' }

let board_test (name: string) (exp_out: Board.square array array) : test =
  name >:: fun _ ->
    assert_equal (print_board exp_out) ((print_board board))
    
let board_tests = 
  [board_test "Print Board" (board)]

let board_tests2 = 
    []

let suite =
  "test suite for A2"
  >::: List.flatten [ board_tests; board_tests2]

let _ = run_test_tt_main suite