let ones =
  [
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
  ]

let tens =
  [
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
  ]

let str_en_uk n =
  if n = 1000 then "one thousand"
  else
    let h = n / 100 and r = n mod 100 in
    let hundred_part =
      if h = 0 then ""
      else if r = 0 then List.nth ones h ^ " hundred"
      else List.nth ones h ^ " hundred and"
    in
    let last_part =
      if r = 0 then ""
      else if r < 20 then List.nth ones r
      else
        let t = r / 10 and o = r mod 10 in
        if o = 0 then List.nth tens t
        else List.nth tens t ^ "-" ^ List.nth ones o
    in
    String.concat " " (List.filter (( <> ) "") [ hundred_part; last_part ])

let letters_count s =
  let is_letter = function 'a' .. 'z' | 'A' .. 'Z' -> true | _ -> false in
  s |> String.to_seq |> Seq.filter is_letter |> List.of_seq |> List.length

let letters n = letters_count (str_en_uk n)
