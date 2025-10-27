open Euler_lib
open Num_to_words

let () =
  assert (letters 342 = 23);
  assert (letters 115 = 20);
  assert (List.fold_left (fun acc n -> acc + letters n) 0 [ 1; 2; 3; 4; 5 ] = 19);
  Printf.printf "✅ All Project Euler 17 tests passed!\n"
