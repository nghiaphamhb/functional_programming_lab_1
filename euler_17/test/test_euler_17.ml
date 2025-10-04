open OUnit2
open Euler_lib

let test_letters _ =
  assert_equal 23 (Num_to_words.letters 342);
  assert_equal 20 (Num_to_words.letters 115)

let test_sum_fold_map _ =
  let sum = Fold_map.sum_fold_map 1 5 in
  assert_equal 19 sum

let suite =
  "Euler17 Tests"
  >::: [ "letters" >:: test_letters; "sum_fold_map" >:: test_sum_fold_map ]

let () = run_test_tt_main suite
