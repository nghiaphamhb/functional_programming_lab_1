let sum list =
  let rec sum_tail_recur acc list =
    match list with [] -> acc | x :: xs -> sum_tail_recur (Z.add acc x) xs
  in
  sum_tail_recur Z.zero list
