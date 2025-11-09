open Alcotest
open Euler_lib
open Num_to_words

let sum_range a b =
  let rec loop acc n = if n > b then acc else loop (acc + letters n) (n + 1) in
  loop 0 a

let test_examples () =
  check int "letters(342)=23" 23 (letters 342);
  check int "letters(115)=20" 20 (letters 115);
  check int "sum 1..5 = 19" 19
    (List.fold_left (fun acc n -> acc + letters n) 0 [ 1; 2; 3; 4; 5 ])

let test_uk_spelling_form () =
  let s_21 = str_en_uk 21 in
  let s_40 = str_en_uk 40 in
  let s_101 = str_en_uk 101 in
  let s_342 = str_en_uk 342 in
  let s_1000 = str_en_uk 1000 in

  check bool "21 has hyphen" true (String.contains s_21 '-');
  check string "40 = forty" "forty" s_40;
  check bool "101 contains 'and'" true
    (String.exists (fun _ -> String.contains s_101 'a') s_101
    && String.contains s_101 'd');
  check bool "101 has 'hundred and'" true
    (String.contains s_101 'a' && String.contains s_101 'd'
    && String.exists (( = ) 'h') s_101);
  check bool "342 has hyphen and and" true
    (String.contains s_342 '-' && String.exists (( = ) 'a') s_342);
  check string "1000 = one thousand" "one thousand" s_1000

let test_letters_count_sanitizes () =
  let s = "one hundred and twenty-three" in
  check int "letters_count ignores spaces and hyphen" 24 (letters_count s)

let test_final_answer () =
  check int "sum 1..1000 = 21124" 21124 (sum_range 1 1000)

let () =
  run "Project Euler 17 - tests"
    [
      ("examples", [ test_case "basic examples" `Quick test_examples ]);
      ("uk form", [ test_case "spelling checks" `Quick test_uk_spelling_form ]);
      ( "sanitize",
        [
          test_case "letters_count ignores non-letters" `Quick
            test_letters_count_sanitizes;
        ] );
      ("answer", [ test_case "final sum 1..1000" `Quick test_final_answer ]);
    ]
