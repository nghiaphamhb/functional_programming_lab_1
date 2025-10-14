open Num_to_words

let sum_letters_list xs = List.fold_left (fun acc x -> acc + letters x) 0 xs
