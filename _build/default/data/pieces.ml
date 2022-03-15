type point = {
  r : int;
  c : char;
}

type piece = {
  color : Board.square;
  coordinates : point -> point list;
}

let next_char (c : char) : char = c |> Char.code |> ( + ) 1 |> Char.chr

(*previous char is below*)
(*let previous_char (c : char) : char = c |> Char.code |> ( - ) 1 |>
  Char.chr *)

let p1 (start : point) : point list = [ { r = start.r; c = start.c } ]

let p2 (start : point) : point list =
  [
    { r = start.r; c = start.c }; { r = start.r; c = next_char start.c };
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
