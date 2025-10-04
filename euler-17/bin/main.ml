open Euler_lib

let () =
  let a, b = (1, 1000) in
  let ans_tail = Tail_recursion.sum_tail a b in
  let ans_rec = Recursion.sum_recursive a b in
  let ans_fold = Fold_map.sum_fold_map a b in
  let ans_seq = try Lazy_seq.sum_seq a b with _ -> -1 in

  Printf.printf "[Tail Recursion ] Answer: %d\n" ans_tail;
  Printf.printf "[Recursion      ] Answer: %d\n" ans_rec;
  Printf.printf "[Fold/Map       ] Answer: %d\n" ans_fold;
  if ans_seq >= 0 then Printf.printf "[Lazy Seq       ] Answer: %d\n" ans_seq
  else Printf.printf "[Lazy Seq       ] (skipped - Seq not available)\n"
