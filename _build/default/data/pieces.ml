type point = {
  r : int;
  c : char;
}

type piece = {
  name : int;
  color : Board.square;
  coordinates : point -> point list;
  all_coords : (point -> point list) list;
}

let next_char (c : char) : char = c |> Char.code |> ( + ) 1 |> Char.chr
let prev_char (c : char) : char = c |> Char.code |> ( - ) 1 |> Char.chr

let p1 : (point -> point list) list =
  [
    (fun (start : point) -> [ { r = start.r; c = start.c } ]);
    (fun (start : point) -> [ { r = start.r; c = start.c } ]);
    (fun (start : point) -> [ { r = start.r; c = start.c } ]);
    (fun (start : point) -> [ { r = start.r; c = start.c } ]);
  ]

let p2 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [ { r = start.r; c = start.c }; { r = start.r + 1; c = start.c } ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [ { r = start.r; c = start.c }; { r = start.r + 1; c = start.c } ]);
  ]

let p3 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 2; c = start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = prev_char start.c };
        { r = start.r; c = prev_char (prev_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r - 1; c = start.c };
        { r = start.r - 2; c = start.c };
      ]);
  ]

let p4 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = 1 + start.r; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r - 1; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = 1 + start.r; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r; c = next_char start.c };
      ]);
  ]

let p5 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r - 1; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 2; c = start.c };
        { r = start.r + 2; c = prev_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = prev_char start.c };
        { r = start.r; c = prev_char (prev_char start.c) };
        { r = start.r; c = prev_char (prev_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r - 1; c = start.c };
        { r = start.r - 2; c = start.c };
        { r = start.r - 2; c = next_char start.c };
      ]);
  ]

let p6 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 1; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 1; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 1; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 1; c = next_char start.c };
      ]);
  ]

let p7 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 1; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 2; c = start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r + 1; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r - 2; c = next_char start.c };
      ]);
  ]

let p8 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r; c = next_char (next_char (next_char start.c)) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 2; c = next_char start.c };
        { r = start.r + 3; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r; c = next_char (next_char (next_char start.c)) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 2; c = next_char start.c };
        { r = start.r + 3; c = next_char start.c };
      ]);
  ]

let p9 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 2; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r - 1; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 2; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r - 1; c = next_char (next_char start.c) };
      ]);
  ]

let p10 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r + 1; c = start.c };
        { r = start.r - 1; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 2; c = next_char start.c };
        { r = start.r + 1; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r - 1; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 1; c = next_char (next_char start.c) };
      ]);
  ]

let p11 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r + 1; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r + 1; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r + 1; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r + 1; c = next_char start.c };
      ]);
  ]

let p12 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 2; c = start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r + 1; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 1; c = next_char (next_char start.c) };
      ]);
  ]

let p13 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 2; c = next_char start.c };
        { r = start.r + 2; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r - 1; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 1; c = next_char (next_char start.c) };
        { r = start.r + 2; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r - 1; c = next_char (next_char start.c) };
        { r = start.r - 2; c = next_char (next_char start.c) };
      ]);
  ]

let p14 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 1; c = next_char (next_char start.c) };
        { r = start.r + 2; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r - 2; c = next_char start.c };
        { r = start.r - 2; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 1; c = next_char (next_char start.c) };
        { r = start.r + 2; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r - 2; c = next_char start.c };
        { r = start.r - 2; c = next_char (next_char start.c) };
      ]);
  ]

let p15 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 2; c = start.c };
        { r = start.r + 2; c = next_char start.c };
        { r = start.r + 2; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 2; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 2; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r - 1; c = next_char (next_char start.c) };
        { r = start.r - 2; c = next_char (next_char start.c) };
      ]);
  ]

let p16 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r - 2; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 2; c = start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 1; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 2; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r - 1; c = next_char (next_char start.c) };
        { r = start.r + 1; c = next_char (next_char start.c) };
      ]);
  ]

let p17 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r; c = next_char (next_char (next_char start.c)) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 2; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r; c = next_char (next_char (next_char start.c)) };
        { r = start.r - 1; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 2; c = start.c };
        { r = start.r + 2; c = next_char start.c };
        { r = start.r + 3; c = start.c };
      ]);
  ]

let p18 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r + 1; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 2; c = start.c };
        { r = start.r + 2; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 1; c = next_char (next_char start.c) };
        { r = start.r; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 2; c = start.c };
        { r = start.r + 2; c = next_char start.c };
      ]);
  ]

let p19 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r - 1; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 2; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r - 1; c = next_char start.c };
        { r = start.r - 1; c = next_char (next_char start.c) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 2; c = next_char start.c };
      ]);
  ]

let p20 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r; c = next_char (next_char (next_char start.c)) };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r + 1; c = next_char start.c };
        { r = start.r + 2; c = next_char start.c };
        { r = start.r + 3; c = next_char start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r; c = next_char (next_char (next_char start.c)) };
        {
          r = start.r - 1;
          c = next_char (next_char (next_char start.c));
        };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 2; c = start.c };
        { r = start.r + 3; c = start.c };
        { r = start.r + 3; c = next_char start.c };
      ]);
  ]

let p21 : (point -> point list) list =
  [
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r; c = next_char (next_char (next_char start.c)) };
        {
          r = start.r;
          c = next_char (next_char (next_char (next_char start.c)));
        };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 2; c = start.c };
        { r = start.r + 3; c = start.c };
        { r = start.r + 4; c = start.c };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r; c = next_char start.c };
        { r = start.r; c = next_char (next_char start.c) };
        { r = start.r; c = next_char (next_char (next_char start.c)) };
        {
          r = start.r;
          c = next_char (next_char (next_char (next_char start.c)));
        };
      ]);
    (fun (start : point) ->
      [
        { r = start.r; c = start.c };
        { r = start.r + 1; c = start.c };
        { r = start.r + 2; c = start.c };
        { r = start.r + 3; c = start.c };
        { r = start.r + 4; c = start.c };
      ]);
  ]

let point_on_board point =
  point.r <= 14 && point.r >= 1
  && Char.code point.c - 64 <= 14
  && Char.code point.c - 64 >= 1

exception NotOnBoard

let place_tile
    (point : point)
    (p : piece)
    (board : Board.square array array) : unit =
  if point_on_board point then
    Board.set_board point.r point.c p.color board
  else raise NotOnBoard

let place (p : piece) (loc : point) (board : Board.square array array) =
  let rec cycle (cos : point list) =
    match cos with
    | [] -> ANSITerminal.print_string [ ANSITerminal.white ] ""
    | h :: t ->
        place_tile h p board;
        cycle t
  in
  cycle (p.coordinates loc);
  board
