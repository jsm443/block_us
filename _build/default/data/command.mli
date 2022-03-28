type object_phrase = string list

type command =
  | Place of object_phrase
  | Quit
  | Malformed

val parse : string -> command