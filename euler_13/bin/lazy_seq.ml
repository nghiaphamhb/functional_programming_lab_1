type 'a seq_node =
  | Nil (*end of sequence*)
  | Cons of 'a * (unit -> 'a seq_node)

(* impl seq_of_list *)
let rec seq_of_list lst () =
  match lst with [] -> Nil | x :: xs -> Cons (x, seq_of_list xs)

(* impl seq_fold_left  *)
let rec seq_fold_left f acc s =
  match s () with Nil -> acc | Cons (x, xs) -> seq_fold_left f (f acc x) xs

(* Tính tổng Z.t từ list *)
let sum numbers =
  let list_seq = seq_of_list numbers in
  seq_fold_left Z.add Z.zero list_seq
