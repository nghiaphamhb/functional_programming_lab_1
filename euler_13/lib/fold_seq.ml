(* sequence generation by map *)
let generate_numbers x =
  let numbers_str : string list = x in
  List.map Z.of_string numbers_str

(* sum by fold/ lazy sequence *)
let sum_fold_10_digits y =
  y |> List.fold_left Z.add Z.zero |> Z.to_string |> fun s -> String.sub s 0 10

let sum_lq_10_digits y =
  y |> List.to_seq |> Seq.fold_left Z.add Z.zero |> Z.to_string |> fun s ->
  String.sub s 0 10

(* filter *)
let filtered_sum_fold z =
  let s = String.trim z in
  if String.length s = 10 then s
  else (
    Printf.eprintf "[ERROR]: [Fold] Take answer more than 10 digits\n";
    exit 2)

let filtered_sum_lq z =
  let s = String.trim z in
  if String.length s = 10 then s
  else (
    Printf.eprintf "[ERROR]: [Lazy sequence] Take answer more than 10 digits\n";
    exit 2)
