open Alcotest
open Data
open Fold_seq

let expected = "5537376230"
let numbers : Z.t list = List.map Z.of_string numbers_str_list
let first10 s = String.sub s 0 10

let is_digits s =
  let ok = ref true in
  String.iter (fun c -> if c < '0' || c > '9' then ok := false) s;
  !ok

(* Re-implement 2 variants recursion *)
let tail_first10 () =
  let rec loop acc = function [] -> acc | x :: tl -> loop Z.(acc + x) tl in
  numbers |> loop Z.zero |> Z.to_string |> first10

let rec_first10 () =
  let rec loop = function [] -> Z.zero | x :: tl -> Z.(x + loop tl) in
  numbers |> loop |> Z.to_string |> first10

(* ===== Test cases ===== *)

let test_tail_rec () =
  check string "tail recursion gives expected 10 digits" expected
    (tail_first10 ());
  check int "length=10 (tail)" 10 (String.length (tail_first10 ()));
  check bool "digits only (tail)" true (is_digits (tail_first10 ()))

let test_plain_rec () =
  check string "plain recursion gives expected 10 digits" expected
    (rec_first10 ());
  check int "length=10 (rec)" 10 (String.length (rec_first10 ()));
  check bool "digits only (rec)" true (is_digits (rec_first10 ()))

let test_fold_and_lazy_from_module () =
  let fold10 = sum_fold_10_digits numbers in
  let lq10 = sum_lq_10_digits numbers in
  check string "fold gives expected 10 digits" expected fold10;
  check string "lazy-seq gives expected 10 digits" expected lq10;
  check int "length=10 (fold)" 10 (String.length fold10);
  check int "length=10 (lazy)" 10 (String.length lq10);
  check bool "digits only (fold)" true (is_digits fold10);
  check bool "digits only (lazy)" true (is_digits lq10)

let test_filtered_outputs () =
  let fold10 = sum_fold_10_digits numbers in
  let lq10 = sum_lq_10_digits numbers in
  let f_fold = filtered_sum_fold fold10 in
  let f_lq = filtered_sum_lq lq10 in
  check string "filtered fold equals fold10" fold10 f_fold;
  check string "filtered lazy equals lq10" lq10 f_lq;
  check int "length=10 (filtered fold)" 10 (String.length f_fold);
  check int "length=10 (filtered lazy)" 10 (String.length f_lq);
  check bool "digits only (filtered fold)" true (is_digits f_fold);
  check bool "digits only (filtered lazy)" true (is_digits f_lq)

let () =
  run "Project Euler 13 - tests"
    [
      ("tail recursion", [ test_case "tail_first10" `Quick test_tail_rec ]);
      ("plain recursion", [ test_case "rec_first10" `Quick test_plain_rec ]);
      ( "fold & lazy (module values)",
        [
          test_case "fold/lazy from module" `Quick
            test_fold_and_lazy_from_module;
        ] );
      ( "filtered variants",
        [ test_case "filtered fold/lazy" `Quick test_filtered_outputs ] );
    ]
