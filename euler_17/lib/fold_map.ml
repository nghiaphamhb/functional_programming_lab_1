open Num_to_words

let sum_fold_map a b =
  List.init (b - a + 1) (fun i -> a + i)
  |> List.map letters |> List.fold_left ( + ) 0
