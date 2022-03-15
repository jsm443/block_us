open OUnit2
open Data
open Print
open Board
open Pieces
let piece1 = {color = Yellow; coordinates = p1};;
let piece2 = {color = Yellow; coordinates = p2};;
let piece3 = {color = Purple; coordinates = p3};;
let piece4 = {color = Purple; coordinates = p4};;
let piece5 = {color = Yellow; coordinates = p5};;
let piece6 = {color = Purple; coordinates = p6};;
let piece7 = {color = Yellow; coordinates = p7};;
let piece8 = {color = Purple; coordinates = p8};;
let piece9 = {color = Yellow; coordinates = p9};;
let piece10 = {color = Yellow; coordinates = p10};;

place piece1 { r = 5; c = 'F' };;
place piece2 { r = 7; c = 'A' };;
place piece3 { r = 10; c = 'I' };;
place piece4 { r = 12; c = 'F' };;
place piece5 { r = 3; c = 'K' };;
place piece6 {r = 3; c = 'I' };;
place piece7 { r = 12; c = 'L' };;
place piece8 { r = 10; c = 'A' };;
place piece9 { r = 1; c = 'B' };;
place piece10 { r = 7; c = 'K' };;

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