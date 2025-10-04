let sum list =
  let rec sum_recur list =
    match list with [] -> Z.zero | x :: xs -> Z.add x (sum_recur xs)
  in
  sum_recur list
