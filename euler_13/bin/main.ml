(*function*)
let first_10_digits n =
  (*string*)
  let first_ten n_str = String.sub n_str 0 10 in
  let n_str = Z.to_string n in
  first_ten n_str

(*begin: map data*)
let numbers = List.map Z.of_string Numbers.numbers_str (*list of z.t*)

(*calculate sum*)
let sum_recur = Recursion.sum numbers (*z.t*)
let sum_tail_recur = Tail_recursion.sum numbers
let sum_fold = Fold.sum numbers
let sum_lazy_seq = Lazy_seq.sum numbers

(*take first 10 digist of sum*)
let answer_recur = first_10_digits sum_recur (*string*)
let answer_tail_recur = first_10_digits sum_tail_recur
let answer_fold = first_10_digits sum_fold
let answer_lazy_seq = first_10_digits sum_lazy_seq

(*output*)
let () =
  Printf.printf
    "The first 10 digits of the sum are:  \n\
     [1- Recursion| 2- Tail_recursion| 3- Fold| 4- Lazy sequence]:\n\n\
     [1] %s \n\
     [2] %s\n\
     [3] %s\n\
     [4] %s\n"
    answer_recur answer_tail_recur answer_fold answer_lazy_seq
