let has_len_eq_10 s = (*boolean*)
  String.length (String.trim s) = 10

let ensure_len_eq10 label s = (*string*)
  if has_len_eq_10 s then s
  else (Printf.eprintf "[ERROR]: %s Take answer more than 10 digits\n" label; exit 2)
