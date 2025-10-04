open Num_to_words

let sum_tail a b =
  let rec loop acc n = if n > b then acc else loop (acc + letters n) (n + 1) in
  loop 0 a
