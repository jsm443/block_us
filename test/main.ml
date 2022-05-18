open OUnit2
open Data
open Board
open Pieces
open Players

(* ADD THIS: The test plan does not explain which parts of the system
   were automatically tested by OUnit vs. manually tested. -1: The test
   plan does not explain what modules were tested by OUnit and how test
   cases were developed (black box, glass box, randomized, etc.).

   In our testing, we focus heavily on testing the placement checks
   because this is the main feature of our game, making sure pieces are
   placed correctly and according to the game rules. The correctness of
   our game is reliant on whether or not any potential move is a valid
   placement. So, we heavily tested our check functions in players.ml,
   which include check_not_on_board, check_corners, check_borders,
   check_not_on_board, check_not_overlapping_pieces, and
   check_piece_in_list return the proper results through example games
   we created. We wanted to test all of these function individually to
   understand which of the checks was failing if a placement wasn't
   working, and we tested valid_placement too in order to make sure it
   was properly calling the checks. We also included test cases to check
   our commands to ensure the user side was working as well. Further, we
   included test cases for getting piece coordinates to make sure our
   pieces were constructed correctly. Test cases were developed using
   both black and glass box testing. When using glass box testing, we
   looked at the actual code for our checks and tested different paths
   in our code. For example, when testing check valid first move, we
   look and saw that there was an if statement so we chose to test the 2
   possible branches, whether you try to piece first piece on a corner
   or not. We also implemented black box testing by making test cases
   based off of edge cases in the specification. For example, when
   checking overlapping pieces, we wanted to check the case when not
   overlapping, overlapping with piece of same color, and overlapping
   with piece of other player's color. We followed the same logic of
   glass box and black box testing for more complicated functions in
   order to find any errors. So, our test suite demonstrates correctness
   of our program because by looking at both the code and specification
   we were able to test all of the edge cases and make sure our tests
   were comprehensive. *)

let empty_board = get_empty_board 15

let board_test (name : string) (exp_out : Board.square array array) :
    test =
  name >:: fun _ ->
  (*assert_equal (print_board exp_out) ((print_board board))*)
  assert_equal exp_out empty_board

let board_tests = [ board_test "Print Board" empty_board ]

let valid_placement_test
    (name : string)
    (expected_output : bool)
    (cur_game : Players.game)
    (tile : Pieces.piece)
    (loc : Pieces.point) =
  name >:: fun _ ->
  assert_equal expected_output
    (Players.valid_placement cur_game tile loc)

let overlap_test
    (name : string)
    (expected_output : bool)
    (cur_game : Players.game)
    (tile : Pieces.piece)
    (loc : Pieces.point) =
  name >:: fun _ ->
  assert_equal expected_output
    (Players.check_not_overlapping_pieces cur_game tile loc)

let piece_in_list_test
    (name : string)
    (expected_output : bool)
    (cur_game : Players.game)
    (tile : Pieces.piece) =
  name >:: fun _ ->
  assert_equal expected_output
    (Players.check_piece_in_list cur_game tile)

let check_not_on_board_test
    (name : string)
    (expected_output : bool)
    (tile : Pieces.piece)
    (loc : Pieces.point) =
  name >:: fun _ ->
  assert_equal expected_output (Players.check_not_on_board tile loc)

let check_corners_test
    (name : string)
    (expected_output : bool)
    (coords : point list)
    (cur_game : Players.game) =
  name >:: fun _ ->
  assert_equal expected_output (Players.check_corners coords cur_game)

let is_valid_first_move_test
    (name : string)
    (expected_output : bool)
    (cur_game : Players.game)
    (tile : Pieces.piece)
    (loc : Pieces.point) =
  name >:: fun _ ->
  assert_equal expected_output
    (Players.is_valid_first_move cur_game tile loc)

let is_valid_command
    (name : string)
    (exp_out : string)
    (command : string) =
  name >:: fun _ ->
  assert_equal exp_out
    (match Command.parse command with
    | Place _ -> "Place"
    | Quit -> "Quit"
    | Done -> "Done"
    | See _ -> "See"
    | Malformed -> "Malformed"
    | Score -> "Score"
    | Rotate _ -> "Rotate")

let get_piece_coordinates_test
    (name : string)
    (expected_output : Pieces.point list)
    (tile : Pieces.piece)
    (loc : Pieces.point) =
  name >:: fun _ ->
  assert_equal expected_output (Players.get_piece_coordinates tile loc)

let empty_board_game_turn1 =
  Players.
    {
      board = empty_board;
      player1 = Players.init_player "p1" Yellow;
      player2 = Players.init_player "p2" Purple;
      turn = 1;
    }

let borders_to_check_test
    (name : string)
    (expected_output : Pieces.point list)
    (coords : Pieces.point list)
    (checking : Pieces.point list) =
  name >:: fun _ ->
  assert_equal expected_output
    (Players.borders_to_check coords checking)

let empty_board_game_turn2 =
  Players.
    {
      board = empty_board;
      player1 = Players.init_player "p1" Yellow;
      player2 = Players.init_player "p2" Purple;
      turn = 2;
    }

let get_piece (piece : int) (color : Board.square) =
  try List.nth (init_pieces color) (piece - 1)
  with _ -> raise (Failure "something is wrong with nth")

(*Used to place pieces on test boards. Pass it a [game] which is the
  current game, where a move is peing added,[piece] the number value of
  the piece to add, the [row] abd [col] *)
let make_move (game : game) (piece : int) (row : int) (col : char) :
    game =
  let color = if game.turn = 1 then Board.Yellow else Board.Purple in
  match move game (get_piece piece color) row col with
  | Valid g -> g
  | Invalid -> raise (Failure "invalid\n   move")
  | _ -> raise (Failure "end game")

let one_piece_board =
  make_move
    {
      board = empty_board;
      player1 = Players.init_player "p1" Yellow;
      player2 = Players.init_player "p2" Purple;
      turn = 1;
    }
    2 1 'A'

let two_piecer = make_move one_piece_board 3 14 'L'
let three_piecer = make_move two_piecer 3 2 'C'
let four_piecer = make_move three_piecer 6 12 'J'

let borders_to_check_tests =
  [
    borders_to_check_test
      "(Test 1) checking bordering coordinates of one point who \
       borders the edges"
      [
        { r = 2; c = 'C' };
        { r = 1; c = 'B' };
        { r = 2; c = 'A' };
        { r = 3; c = 'B' };
      ]
      [ { r = 2; c = 'B' } ]
      [];
    borders_to_check_test
      "(Test 2) checking bordering coordinates of one point in the \
       middle of the board"
      [
        { r = 5; c = 'E' };
        { r = 4; c = 'D' };
        { r = 5; c = 'C' };
        { r = 6; c = 'D' };
      ]
      [ { r = 5; c = 'D' } ]
      [];
  ]

let valid_first_move_tests =
  [
    is_valid_first_move_test
      "(Test 1) first piece not placed in corner, player 1" false
      empty_board_game_turn1
      {
        name = 2;
        color = Yellow;
        coordinates = List.nth Pieces.p1 0;
        all_coords = Pieces.p1;
      }
      { r = 10; c = 'G' };
    is_valid_first_move_test
      "(Test 2) first piece placed in corner, player 1" true
      empty_board_game_turn1
      {
        name = 2;
        color = Yellow;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 1; c = 'A' };
    is_valid_first_move_test
      "(Test 3) first piece not placed in corner, player 2" false
      empty_board_game_turn1
      {
        name = 2;
        color = Purple;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 5; c = 'D' };
    is_valid_first_move_test
      "(Test 4) first piece placed in corner, player 2" true
      empty_board_game_turn1
      {
        name = 1;
        color = Purple;
        coordinates = List.nth Pieces.p1 0;
        all_coords = Pieces.p1;
      }
      { r = 14; c = 'N' };
  ]

let check_not_on_board_tests =
  [
    check_not_on_board_test
      "(Test 1) testing first piece placed, no pieces on board, place \
       piece within board, player 1"
      true
      {
        name = 2;
        color = Yellow;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 10; c = 'G' };
    check_not_on_board_test
      "(Test 2) placing piece on empty board, half falling off the \
       board, player 1"
      false
      {
        name = 2;
        color = Yellow;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 14; c = 'N' };
    check_not_on_board_test
      "(Test 3) placing piece fully off of the board, player 1" false
      {
        name = 2;
        color = Yellow;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 16; c = 'G' };
    check_not_on_board_test
      "(Test 4) testing first piece placed, no pieces on board, place \
       piece within board, player 2"
      true
      {
        name = 2;
        color = Purple;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 10; c = 'G' };
    check_not_on_board_test
      "(Test 5) placing piece on empty board, half falling off the \
       board, player 2"
      false
      {
        name = 2;
        color = Purple;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 14; c = 'N' };
    check_not_on_board_test
      "(Test 6) placing piece fully off of the board" false
      {
        name = 2;
        color = Purple;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 16; c = 'G' };
  ]

let get_piece_coordinates_tests =
  [
    get_piece_coordinates_test
      "(Test 1) checking coordinate list of piece 1 placed in position \
       1 A"
      [ { r = 1; c = 'A' } ]
      {
        name = 1;
        color = Yellow;
        coordinates = List.nth Pieces.p1 0;
        all_coords = Pieces.p1;
      }
      { r = 1; c = 'A' };
    get_piece_coordinates_test
      "(Test 2) checking coordinate list of yellow piece 2 placed in \
       position 1 B"
      [ { r = 1; c = 'B' }; { r = 1; c = 'C' } ]
      {
        name = 2;
        color = Yellow;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 1; c = 'B' };
    get_piece_coordinates_test
      "(Test 3) checking coordinate list of purple piece 2 placed in \
       position 1 B"
      [ { r = 1; c = 'B' }; { r = 1; c = 'C' } ]
      {
        name = 2;
        color = Purple;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 1; c = 'B' };
    get_piece_coordinates_test
      "(Test 4) checking coordinate list of purple piece 1 placed in \
       position 1 B"
      [ { r = 1; c = 'B' } ]
      {
        name = 1;
        color = Purple;
        coordinates = List.nth Pieces.p1 0;
        all_coords = Pieces.p1;
      }
      { r = 1; c = 'B' };
  ]

let check_corners_tests =
  [
    check_corners_test
      "(Test 1) checking corners when piece is placed on empty board"
      false
      (Players.get_piece_coordinates
         {
           name = 2;
           color = Yellow;
           coordinates = List.nth Pieces.p2 0;
           all_coords = Pieces.p2;
         }
         { r = 10; c = 'G' })
      empty_board_game_turn1;
    check_corners_test
      "(Test 2) checking corners when piece is placed on non-empty \
       board and not touching corners to any piece"
      false
      (Players.get_piece_coordinates
         {
           name = 2;
           color = Yellow;
           coordinates = List.nth Pieces.p2 0;
           all_coords = Pieces.p2;
         }
         { r = 10; c = 'G' })
      one_piece_board;
    check_corners_test
      "(Test 3) checking corners when piece is placed on non-empty \
       board and corners touch its own colored piece"
      false
      (Players.get_piece_coordinates
         {
           name = 1;
           color = Yellow;
           coordinates = List.nth Pieces.p1 0;
           all_coords = Pieces.p1;
         }
         { r = 2; c = 'C' })
      one_piece_board;
    check_corners_test
      "(Test 4) checking corners when piece is placed on non-empty \
       board and its corners touch a different players piece but not \
       your own"
      false
      (Players.get_piece_coordinates
         {
           name = 1;
           color = Purple;
           coordinates = List.nth Pieces.p1 0;
           all_coords = Pieces.p1;
         }
         { r = 2; c = 'C' })
      one_piece_board;
    check_corners_test
      "(Test 5) checking corners when piece is placed touching corners \
       to a border, and not a piece"
      false
      (Players.get_piece_coordinates
         {
           name = 1;
           color = Purple;
           coordinates = List.nth Pieces.p1 0;
           all_coords = Pieces.p1;
         }
         { r = 14; c = 'A' })
      one_piece_board;
    check_corners_test
      "(Test 6) checking corners when piece is placed touching a piece \
       of the same color, but not touching on the corners"
      false
      (Players.get_piece_coordinates
         {
           name = 1;
           color = Purple;
           coordinates = List.nth Pieces.p1 0;
           all_coords = Pieces.p1;
         }
         { r = 2; c = 'B' })
      one_piece_board;
  ]

let overlap_tests =
  [
    overlap_test
      "(Test 1) check overlap of first player placing piece on empty \
       board "
      true empty_board_game_turn1
      {
        name = 2;
        color = Yellow;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 10; c = 'G' };
    overlap_test
      "(Test 2) check overlap of second player placing piece on empty \
       board "
      true empty_board_game_turn1
      {
        name = 2;
        color = Purple;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 10; c = 'G' };
    overlap_test
      "(Test 3) check overlap of placing non-overlapped piece on a \
       non-empty board"
      true one_piece_board
      {
        name = 2;
        color = Yellow;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 10; c = 'G' };
    overlap_test
      "(Test 4) check overlap of placing piece overlapping your own \
       piece"
      true one_piece_board
      {
        name = 7;
        color = Yellow;
        coordinates = List.nth Pieces.p7 0;
        all_coords = Pieces.p7;
      }
      { r = 2; c = 'B' };
    overlap_test
      "(Test 5) check overlap of placing piece overlapping other \
       players piece"
      true one_piece_board
      {
        name = 7;
        color = Purple;
        coordinates = List.nth Pieces.p7 0;
        all_coords = Pieces.p7;
      }
      { r = 2; c = 'B' };
  ]

let piece_in_list_tests =
  [
    piece_in_list_test "(Test 1) check empty list returns true" true
      empty_board_game_turn1
      {
        name = 2;
        color = Yellow;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      };
    piece_in_list_test "(Test 2) check one piece returns false" false
      one_piece_board
      {
        name = 2;
        color = Yellow;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      };
    piece_in_list_test
      "(Test 3) checking if piece is in your list after you placed \
       the  piece"
      false four_piecer
      {
        name = 6;
        color = Purple;
        coordinates = List.nth Pieces.p6 0;
        all_coords = Pieces.p6;
      };
    piece_in_list_test
      "(Test 4) checking if piece is in your list after the other\n\
      \       player placed the piece" true four_piecer
      {
        name = 6;
        color = Yellow;
        coordinates = List.nth Pieces.p6 0;
        all_coords = Pieces.p6;
      };
    piece_in_list_test
      "(Test 5) Checking a piece is still in your list after another  \
       player places the  same number"
      false three_piecer
      {
        name = 3;
        color = Yellow;
        coordinates = List.nth Pieces.p3 0;
        all_coords = Pieces.p3;
      };
  ]

let valid_placement_tests =
  [
    valid_placement_test
      "(Test 1) player 1 places piece on empty board when its not \
       their turn"
      false empty_board_game_turn2
      {
        name = 2;
        color = Yellow;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 10; c = 'G' };
    valid_placement_test
      "(Test 2) player 1 places piece on empty board when its their \
       turn, but not in corner"
      false empty_board_game_turn1
      {
        name = 2;
        color = Yellow;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 10; c = 'G' };
    valid_placement_test
      "(Test 3) player 2 places piece on empty board " false
      empty_board_game_turn1
      {
        name = 3;
        color = Purple;
        coordinates = List.nth Pieces.p3 0;
        all_coords = Pieces.p3;
      }
      { r = 4; c = 'F' };
    valid_placement_test
      "(Test4) valid placement, player 1 places piece on a non-empty \
       board, not touching corners"
      false one_piece_board
      {
        name = 3;
        color = Yellow;
        coordinates = List.nth Pieces.p3 0;
        all_coords = Pieces.p3;
      }
      { r = 11; c = 'J' };
    valid_placement_test
      "(Test5) valid placement, player 1 places piece on a non-empty \
       board, touching corners"
      false one_piece_board
      {
        name = 1;
        color = Yellow;
        coordinates = List.nth Pieces.p1 0;
        all_coords = Pieces.p1;
      }
      { r = 2; c = 'C' };
    valid_placement_test
      "(Test6) valid placement, player 1 tries to place that is not in \
       their piece list/already on the board"
      false one_piece_board
      {
        name = 2;
        color = Yellow;
        coordinates = List.nth Pieces.p2 0;
        all_coords = Pieces.p2;
      }
      { r = 1; c = 'A' };
    valid_placement_test
      "(Test7) valid placement, placing piece when it is not your turn"
      false one_piece_board
      {
        name = 3;
        color = Purple;
        coordinates = List.nth Pieces.p3 0;
        all_coords = Pieces.p3;
      }
      { r = 9; c = 'C' };
  ]

let command_tests =
  [
    is_valid_command "Test Place uppercase letter" "Place" "place 3 3 A";
    is_valid_command "Test place lowercase letter" "Place"
      "place 3\n       3 c";
    is_valid_command "Test invalid place input" "Malformed" "place";
    is_valid_command "Test Quit" "Quit" "Quit";
    is_valid_command "Test Quit lowercase" "Quit" "quit";
    is_valid_command "Test Done uppercase" "Done" "Done";
    is_valid_command "Test done lowercase" "Done" "done";
    is_valid_command "Test See uppercase " "See" "See 2";
    is_valid_command "Test see lower case" "See" "see 3";
    is_valid_command "Test See malformed" "Malformed" "See";
    is_valid_command "Test Score uppercase" "Score" "Score";
    is_valid_command "Test Score lowercase" "Score" "score";
    is_valid_command "Test Score malformed" "Malformed" "scire";
  ]

let suite =
  "test suite for A2"
  >::: List.flatten
         [
           board_tests;
           valid_placement_tests;
           check_corners_tests;
           piece_in_list_tests;
           borders_to_check_tests;
           valid_first_move_tests;
           overlap_tests;
           command_tests;
           get_piece_coordinates_tests;
           check_not_on_board_tests;
         ]

let _ = run_test_tt_main suite