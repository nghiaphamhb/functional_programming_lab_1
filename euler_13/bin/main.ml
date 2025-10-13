(*function to take first 10 digits of number z.t*)
let first_10_digits n = (*string*)
  let first_ten n_str = String.sub n_str 0 10 in
  let n_str = Z.to_string n in
  first_ten n_str

(*sequence generation*)
let numbers = Seq_generation.numbers (*list of z.t*)

(* == First block : Begin ==*)
let sum_tail_recur =
  let rec loop acc xs =
    match xs with
    | []      -> acc
    | x :: tl -> loop (Z.add acc x) tl
  in
  loop Z.zero numbers

let answer_tail_recur = first_10_digits sum_tail_recur (*string*)

let() = Printf.printf "The first 10 digits of the sum are [Tail recursion]: \n%s\n" answer_tail_recur
(* == First block : End ==*)


(* == Second block : Begin ==*)
let sum_recur =
  let rec loop xs =
    match xs with
    | []      -> Z.zero
    | x :: tl -> Z.add x (loop tl)
  in
  loop numbers

let answer_recur = first_10_digits sum_recur (*string*)

let() = Printf.printf "The first 10 digits of the sum are [Recursion]: \n%s\n" answer_recur
(* == Second block : End ==*)


(* == Third block : Begin == *)
(* calculate sum *)
let sum_fold     = Fold.sum numbers
let sum_lazy_seq = Lazy_seq.sum numbers

(* take first 10 digits + validate by filter *)
let answer_fold =
  sum_fold |> first_10_digits |> Filter.ensure_len_eq10 "[Fold]"

let answer_lazy_seq =
  sum_lazy_seq |> first_10_digits |> Filter.ensure_len_eq10 "[Lazy sequence]"

(* output *)
let () =
  Printf.printf
    "The first 10 digits of the sum are [Fold]: \n%s\n\
     The first 10 digits of the sum are [Lazy sequence]: \n%s\n"
    answer_fold answer_lazy_seq
(* == Third block : End == *)
