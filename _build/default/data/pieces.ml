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

(* Single square *)
let p1 (start : point) : point list = [ { r = start.r; c = start.c } ]

(* 2 horizontal squares *)
let p2 (start : point) : point list =
  [
    { r = start.r; c = start.c }; { r = start.r; c = next_char start.c };
  ]

(* 3 horizontal squares *)
let p3 (start : point) : point list =
  [
    { r = start.r; c = start.c }; 
    { r = start.r; c = next_char start.c };
    { r = start.r; c = next_char (next_char start.c) };
  ]

(* Corner 3 piece *)
let p4 (start : point) : point list =
  [
    { r = start.r; c = start.c }; 
    { r = start.r; c = next_char start.c };
    { r = 1 + start.r; c = next_char start.c};
  ]

(* Upside down T *)
let p5 (start : point) : point list =
  [
    { r = start.r; c = start.c }; 
    { r = start.r; c = next_char start.c };
    { r = start.r; c = next_char (next_char start.c) };
    { r = start.r - 1; c = next_char start.c}
   ]

(* 2 by 2 Block *)
let p6 (start : point) : point list =
  [
    { r = start.r; c = start.c }; 
    { r = start.r; c = next_char start.c };
    { r = start.r + 1; c = start.c };
    { r = start.r + 1; c = next_char start.c}
  ]

(* Long L *)
let p7 (start : point) : point list =
  [
    { r = start.r; c = start.c }; 
    { r = start.r + 1; c = start.c };
    { r = start.r + 1; c = next_char start.c};
    { r = start.r + 1; c = next_char (next_char start.c) };
   ]

(* 4 horizontal squares *)
let p8 (start : point) : point list =
  [
    { r = start.r; c = start.c }; 
    { r = start.r; c = next_char start.c };
    { r = start.r; c = next_char (next_char start.c)};
    { r = start.r; c = next_char (next_char (next_char start.c))};
  ]

(* Squiggle lol *)
let p9 (start : point) : point list =
  [
    { r = start.r; c = start.c }; 
    { r = start.r + 1; c = start.c };
    { r = start.r + 1; c = next_char start.c};
    { r = start.r + 2; c = next_char start.c};
  ]

(* Very complicated *)
let p10 (start : point) : point list =
  [
    { r = start.r; c = start.c }; 
    { r = start.r; c = next_char start.c };
    { r = start.r; c = next_char (next_char start.c) };
    { r = start.r + 1; c = start.c};
    { r = start.r - 1; c = next_char start.c};
  ]

(* Cross *)
let p11 (start : point) : point list =
  [
    { r = start.r; c = start.c }; 
    { r = start.r; c = next_char start.c };
    { r = start.r; c = next_char (next_char start.c) };
    { r = start.r - 1; c = next_char start.c};
    { r = start.r + 1; c = next_char start.c}
  ]

(* P *)
let p12 (start : point) : point list =
  [
    { r = start.r; c = start.c }; 
    { r = start.r; c = next_char start.c };
    { r = start.r + 1; c = start.c };
    { r = start.r + 1; c = next_char start.c};
    { r = start.r + 2; c = start.c}
  ]

(** Longer squiggle *)
let p13 (start : point) : point list =
  [
    { r = start.r; c = start.c }; 
    { r = start.r + 1; c = start.c };
    { r = start.r + 1; c = next_char start.c};
    { r = start.r + 2; c = next_char start.c};
    { r = start.r + 2; c = next_char (next_char start.c)};
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
