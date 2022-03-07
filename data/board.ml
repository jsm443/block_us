(**A data structure which creates the board*)

type box = int (* Int is filler. GUI needs to be implemented here *)

type fill =
  | Orange of box
  | Purple of box

type square =
  | Empty
  | Filled of fill

let board =
  [|
    [|
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    |];
    [|
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    |];
    [|
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    |];
    [|
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    |];
    [|
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    |];
    [|
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    |];
    [|
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    |];
    [|
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    |];
    [|
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    |];
    [|
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    |];
    [|
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    |];
    [|
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    |];
    [|
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    |];
    [|
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
      Empty;
    |];
  |]