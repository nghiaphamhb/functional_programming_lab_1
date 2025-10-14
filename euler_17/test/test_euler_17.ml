open OUnit2
open Euler_lib
open Num_to_words

let pp_int = string_of_int

let test_letters _ =
  assert_equal ~printer:pp_int 23 (letters 342);
  assert_equal ~printer:pp_int 20 (letters 115)

let test_sum_list_1_5 _ =
  let xs = Seq_generation.ints_list_map 1 5 |> Filter.keep_valid_ints_list in
  let sum = Fold.sum_letters_list xs in
  assert_equal ~printer:pp_int 19 sum

let test_sum_seq_1_5 _ =
  let s = Seq_generation.ints_seq_map 1 5 |> Filter.keep_valid_ints_seq in
  let sum = Lazy_seq.sum_letters_seq s in
  assert_equal ~printer:pp_int 19 sum

let suite =
  "Euler17 Tests"
  >::: [
         "letters_342_115" >:: test_letters;
         "sum_list_1_5" >:: test_sum_list_1_5;
         "sum_seq_1_5" >:: test_sum_seq_1_5;
       ]

let () = run_test_tt_main suite
