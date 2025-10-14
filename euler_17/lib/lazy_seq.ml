open Num_to_words

let sum_letters_seq s = Seq.fold_left (fun acc n -> acc + letters n) 0 s
