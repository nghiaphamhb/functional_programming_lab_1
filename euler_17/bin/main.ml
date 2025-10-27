open Euler_lib
open Printf
open Num_to_words

(* Tail Recursion *)
let () =
  let a, b = (1, 1000) in
  let rec loop acc n = if n > b then acc else loop (acc + letters n) (n + 1) in
  let ans_tail = loop 0 a in
  Printf.printf "Answer [Tail Recursion ]: %d\n" ans_tail

(* Recursion *)
let () =
  let a, b = (1, 1000) in
  let rec sum_recursive a b =
    if a > b then 0 else letters a + sum_recursive (a + 1) b
  in
  let ans_rec = sum_recursive a b in
  Printf.printf "Answer [Recursion      ]: %d\n" ans_rec

(* == Modules ==*)
(* Sequences generation by map *)
let list =
  let a, b = (1, 1000) in
  if a > b then []
  else List.init (b - a + 1) Fun.id |> List.map (fun i -> a + i)

let seq =
  let a, b = (1, 1000) in
  if a > b then Seq.empty
  else
    Seq.unfold (fun i -> if i > b - a then None else Some (i, i + 1)) 0
    |> Seq.map (fun i -> a + i)

(* filters *)
let filtered_list = List.filter (fun n -> n >= 1 && n <= 1000) list
let filtered_seq = Seq.filter (fun n -> n >= 1 && n <= 1000) seq

(* fold/seq *)
let ans_fold = List.fold_left (fun acc x -> acc + letters x) 0 filtered_list
let ans_seq = Seq.fold_left (fun acc x -> acc + letters x) 0 filtered_seq

(* output *)
let () = printf "Answer [Fold/Reduce    ]: %d\n" ans_fold
let () = printf "Answer [Lazy Seq       ]: %d\n" ans_seq
