open Data

(*Tail recursion*)
let () =
  let numbers : Z.t list = List.map Z.of_string numbers_str_list in
  let rec loop acc = function [] -> acc | x :: tl -> loop (Z.add acc x) tl in
  let sum = loop Z.zero numbers in
  Printf.printf "The first 10 digits of the sum are [Tail recursion]: \n%s\n"
    (String.sub (Z.to_string sum) 0 10)

(* Recursion *)
let () =
  let numbers : Z.t list = List.map Z.of_string numbers_str_list in
  let rec loop = function [] -> Z.zero | x :: tl -> Z.add x (loop tl) in
  let sum = loop numbers in
  Printf.printf "The first 10 digits of the sum are [Recursion]: \n%s\n"
    (String.sub (Z.to_string sum) 0 10)

(* == modular implementation == *)
open Fold_seq

(* sequence generation by map *)
let numbers : Z.t list = generate_numbers numbers_str_list

(* sum by fold/ lazy sequence *)
let sum_fold : string = sum_fold_10_digits numbers
let sum_lq : string = sum_lq_10_digits numbers

(* filter *)
let filtered_sum_fold : string = filtered_sum_fold sum_fold
let filtered_sum_lq : string = filtered_sum_lq sum_lq

(* output *)
let () =
  Printf.printf
    "The first 10 digits of the sum are [Fold]: \n\
     %s\n\
     The first 10 digits of the sum are [Lazy sequence]: \n\
     %s\n"
    filtered_sum_fold filtered_sum_lq
