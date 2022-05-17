type object_phrase = string list

type command =
  | Place of object_phrase
  | Quit
  | Done
  | See of string
  | Score
  | Rotate of object_phrase
  | Malformed

let nospaces str = if str = "" then false else true

let parse str =
  let trimmed = String.trim str in
  let totallist = String.split_on_char ' ' trimmed in
  let wordslist = List.filter nospaces totallist in
  match wordslist with
  | [] -> Malformed
  | [ "Quit" ] | [ "quit" ] -> Quit
  | [ "Done" ] | [ "done" ] -> Done
  | [ "Score" ] | [ "score" ] -> Score
  | "See" :: lst | "see" :: lst ->
      if List.length lst = 1 then See (List.hd lst) else Malformed
  | "Place" :: lst | "place" :: lst ->
      if lst != [] then Place lst else Malformed
  | "Rotate" :: lst | "rotate" :: lst ->
      if List.length lst = 2 then Rotate lst else Malformed
  | _ -> Malformed
