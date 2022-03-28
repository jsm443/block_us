type object_phrase = string list

type command =
  | Place of object_phrase
  | Quit
  | Malformed

let nospaces str = if str = "" then false else true

let parse str =
  let trimmed = String.trim str in
  let totallist = String.split_on_char ' ' trimmed in
  let wordslist = List.filter nospaces totallist in
  match wordslist with
  | [] -> Malformed
  | [ "Quit" ]
  | [ "quit" ] ->
      Quit
  | "Place" :: lst
  | "place" :: lst ->
      if lst != [] then Place lst else Malformed
  | _ -> Malformed
