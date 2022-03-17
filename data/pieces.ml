type point = {
  r : int;
  c : char;
}

type piece = {
  color : Board.square;
  coordinates : point -> point list;
}

let next_char (c : char) : char = c |> Char.code |> ( + ) 1 |> Char.chr

(*let previous_char (c : char) : char = c |> Char.code |> ( - ) 1 |>
  Char.chr *)

(* All pieces are defined by their leftmost box. If there are multiple
   left most boxes, then the top one is used.*)

(* Single square Piece 1*)
let p1 (start : point) : point list = [ { r = start.r; c = start.c } ]

(* 2 horizontal squares Piece 2*)
let p2 (start : point) : point list =
  [
    { r = start.r; c = start.c }; { r = start.r; c = next_char start.c };
  ]

(* 3 horizontal squares Piece 3*)
let p3 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r; c = next_char start.c };
    { r = start.r; c = next_char (next_char start.c) };
  ]

(* Corner 3 piece Piece 4*)
let p4 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r; c = next_char start.c };
    { r = 1 + start.r; c = next_char start.c };
  ]

(* Upside down T Piece 7*)
let p5 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r; c = next_char start.c };
    { r = start.r; c = next_char (next_char start.c) };
    { r = start.r - 1; c = next_char start.c };
  ]

(* 2 by 2 Block Piece 8*)
let p6 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r; c = next_char start.c };
    { r = start.r + 1; c = start.c };
    { r = start.r + 1; c = next_char start.c };
  ]

(* Long L Piece 6*)
let p7 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r + 1; c = start.c };
    { r = start.r + 1; c = next_char start.c };
    { r = start.r + 1; c = next_char (next_char start.c) };
  ]

(* 4 horizontal squares Piece 5*)
let p8 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r; c = next_char start.c };
    { r = start.r; c = next_char (next_char start.c) };
    { r = start.r; c = next_char (next_char (next_char start.c)) };
  ]

(* Squiggle lol Piece 9*)
let p9 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r + 1; c = start.c };
    { r = start.r + 1; c = next_char start.c };
    { r = start.r + 2; c = next_char start.c };
  ]

(* Very complicated Piece 20*)
let p10 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r; c = next_char start.c };
    { r = start.r; c = next_char (next_char start.c) };
    { r = start.r + 1; c = start.c };
    { r = start.r - 1; c = next_char start.c };
  ]

(* Cross Piece 21*)
let p11 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r; c = next_char start.c };
    { r = start.r; c = next_char (next_char start.c) };
    { r = start.r - 1; c = next_char start.c };
    { r = start.r + 1; c = next_char start.c };
  ]

(* P Piece 13*)
let p12 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r; c = next_char start.c };
    { r = start.r + 1; c = start.c };
    { r = start.r + 1; c = next_char start.c };
    { r = start.r + 2; c = start.c };
  ]

(**Longer squiggle Piece 18*)
let p13 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r + 1; c = start.c };
    { r = start.r + 1; c = next_char start.c };
    { r = start.r + 2; c = next_char start.c };
    { r = start.r + 2; c = next_char (next_char start.c) };
  ]

(**Z Piece 19*)
let p14 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r + 1; c = start.c };
    { r = start.r + 1; c = next_char start.c };
    { r = start.r + 1; c = next_char (next_char start.c) };
    { r = start.r + 2; c = next_char (next_char start.c) };
  ]

(**5 block L Piece 17*)
let p15 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r + 1; c = start.c };
    { r = start.r + 2; c = start.c };
    { r = start.r + 2; c = next_char start.c };
    { r = start.r + 2; c = next_char (next_char start.c) };
  ]

(**5 block T Piece 16*)
let p16 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r; c = next_char start.c };
    { r = start.r - 1; c = next_char start.c };
    { r = start.r - 2; c = next_char start.c };
    { r = start.r; c = next_char (next_char start.c) };
  ]

(**Line with block shooting off Piece 15*)
let p17 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r; c = next_char start.c };
    { r = start.r + 1; c = next_char start.c };
    { r = start.r; c = next_char (next_char start.c) };
    { r = start.r; c = next_char (next_char (next_char start.c)) };
  ]

(** C shaped Piece Piece 14*)
let p18 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r; c = next_char start.c };
    { r = start.r + 1; c = start.c };
    { r = start.r; c = next_char (next_char start.c) };
    { r = start.r + 1; c = next_char (next_char start.c) };
  ]

(**5 long squiggly Piece 12*)
let p19 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r; c = next_char start.c };
    { r = start.r - 1; c = next_char start.c };
    { r = start.r - 1; c = next_char (next_char start.c) };
    { r = start.r - 1; c = next_char (next_char start.c) };
  ]

(**5 block L Piece 11*)
let p20 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r + 1; c = start.c };
    { r = start.r; c = next_char start.c };
    { r = start.r; c = next_char (next_char start.c) };
    { r = start.r; c = next_char (next_char (next_char start.c)) };
  ]

(**5 block line Piece 10*)
let p21 (start : point) : point list =
  [
    { r = start.r; c = start.c };
    { r = start.r + 1; c = start.c };
    { r = start.r + 2; c = start.c };
    { r = start.r + 3; c = start.c };
    { r = start.r + 4; c = start.c };
  ]

let place_tile (point : point) (p : piece) : unit =
  Board.set_board point.r point.c p.color

let place (p : piece) (loc : point) : unit =
  let rec cycle (cos : point list) =
    match cos with
    | [] -> ANSITerminal.print_string [ ANSITerminal.white ] ""
    | h :: t ->
        place_tile h p;
        cycle t
  in
  cycle (p.coordinates loc)
