let ints_list_map a b =
  if a > b then []
  else List.init (b - a + 1) Fun.id |> List.map (fun i -> a + i)

let ints_seq_map a b =
  if a > b then Seq.empty
  else
    Seq.unfold (fun i -> if i > b - a then None else Some (i, i + 1)) 0
    |> Seq.map (fun i -> a + i)
