let ones =
  [|
    "";
    "one";
    "two";
    "three";
    "four";
    "five";
    "six";
    "seven";
    "eight";
    "nine";
    "ten";
    "eleven";
    "twelve";
    "thirteen";
    "fourteen";
    "fifteen";
    "sixteen";
    "seventeen";
    "eighteen";
    "nineteen";
  |]

let tens =
  [|
    "";
    "";
    "twenty";
    "thirty";
    "forty";
    "fifty";
    "sixty";
    "seventy";
    "eighty";
    "ninety";
  |]

let str_en_uk n =
  if n = 1000 then "one thousand"
  else
    let h = n / 100 in
    let r = n mod 100 in
    let hundred_part =
      if h = 0 then ""
      else if r = 0 then ones.(h) ^ " hundred"
      else ones.(h) ^ " hundred and"
    in
    let last_part =
      if r = 0 then ""
      else if r < 20 then ones.(r)
      else
        let t = r / 10 and o = r mod 10 in
        if o = 0 then tens.(t) else tens.(t) ^ "-" ^ ones.(o)
    in
    String.trim
      (String.concat " "
         (List.filter (fun s -> s <> "") [ hundred_part; last_part ]))

let letters_count s =
  let is_letter = function 'a' .. 'z' | 'A' .. 'Z' -> true | _ -> false in
  s |> String.to_seq |> Seq.filter is_letter |> List.of_seq |> List.length

let letters n = letters_count (str_en_uk n)
