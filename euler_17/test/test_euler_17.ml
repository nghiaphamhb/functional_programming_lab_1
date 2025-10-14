open OUnit2
open Euler_lib

let test_letters _ =
  assert_equal 23 (Num_to_words.letters 342);
  assert_equal 20 (Num_to_words.letters 115)

let test_sum_fold _ =
  let sum = Fold.sum_fold 1 5 in
  assert_equal 19 sum

let suite =
  "Euler17 Tests"
  >::: [ "letters" >:: test_letters; "sum_fold" >:: test_sum_fold ]

let () = run_test_tt_main suite
