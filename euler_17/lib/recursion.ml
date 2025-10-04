open Num_to_words

let rec sum_recursive a b =
  if a > b then 0 else letters a + sum_recursive (a + 1) b
