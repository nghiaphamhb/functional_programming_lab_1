open Euler_lib
open Printf

let a, b = (1, 1000)

(* == First block : Begin == *)
let sum_tail a b =
  let open Num_to_words in
  let rec loop acc n = if n > b then acc else loop (acc + letters n) (n + 1) in
  loop 0 a

let ans_tail = sum_tail a b
let () = printf "Answer [Tail Recursion ]: %d\n" ans_tail
(* == First block : End == *)

(* == Second block : Begin == *)
let rec sum_recursive a b =
  let open Num_to_words in
  if a > b then 0 else letters a + sum_recursive (a + 1) b

let ans_rec = sum_recursive a b
let () = printf "Answer [Recursion      ]: %d\n" ans_rec
(* == Second block : End == *)

(* == Third block : Begin == *)
let numbers_list =
  Seq_generation.ints_list_map a b |> Filter.keep_valid_ints_list

let numbers_seq = Seq_generation.ints_seq_map a b |> Filter.keep_valid_ints_seq
let ans_fold = Fold.sum_letters_list numbers_list
let ans_seq = Lazy_seq.sum_letters_seq numbers_seq
let () = printf "Answer [Fold/Reduce    ]: %d\n" ans_fold
let () = printf "Answer [Lazy Seq       ]: %d\n" ans_seq
(* == Third block : End == *)
