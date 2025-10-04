open Num_to_words

let sum_seq a b =
  let open Seq in
  let nums = unfold (fun n -> if n > b then None else Some (n, n + 1)) a in
  nums |> map letters |> fold_left ( + ) 0
