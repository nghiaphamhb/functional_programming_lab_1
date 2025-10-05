# Bài thực hành số 1
## Project Euler số 13, số 17

- Học sinh: Pham Dang Trung Nghia
- Lớp: P3321
- ISU: 374806
- Ngôn ngữ hàm: OCaml

## Problem 13 
- Tên: Large Sum
- Miêu tả: https://projecteuler.net/problem=13
- Yêu cầu: Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.

### Cơ bản ý tưởng giải quyết 
Trong các giải pháp, chúng ta thực hiện cộng tất cả 100 số nguyên 50 chữ số. Mỗi số được lưu dưới dạng string và chuyển sang kiểu số nguyên lớn (Z.t trong OCaml) bằng cách sử dụng List.map. 
Dùng các phương pháp khác nhau để tính tổng tất cả các số đó. Cuối cùng, lấy 10 chữ số đầu của kết quả tổng và in ra.

### Module chứa data (numbers.ml)
```ocaml
let numbers_str =
  [
    (*list of string*)
    "37107287533902102798797998220837590246510135740250";
      (* ... *)
    "46376937677490009712648124896970078050417018260538"
  ]
```
### Hàm chính (main.ml)
Gọi ra các phương thức giải quyết và in ra kết quả thực thi chúng để so sánh  
```ocaml 
(*function*)
let first_10_digits n =
  let first_ten n_str = String.sub n_str 0 10 in
  let n_str = Z.to_string n in
  first_ten n_str

(*begin: map data*)
let numbers = List.map Z.of_string Numbers.numbers_str (*list of z.t*)

(*calculate sum*)
let sum_recur = Recursion.sum numbers (*z.t*)
let sum_tail_recur = Tail_recursion.sum numbers
let sum_fold = Fold.sum numbers
let sum_lazy_seq = Lazy_seq.sum numbers

(*take first 10 digist of sum*)
let answer_recur = first_10_digits sum_recur (*string*)
let answer_tail_recur = first_10_digits sum_tail_recur
let answer_fold = first_10_digits sum_fold
let answer_lazy_seq = first_10_digits sum_lazy_seq

(*output*)
let () =
  Printf.printf
    "The first 10 digits of the sum are:  \n\
     [1- Recursion| 2- Tail_recursion| 3- Fold| 4- Lazy sequence]:\n\n\
     [1] %s \n\
     [2] %s\n\
     [3] %s\n\
     [4] %s\n"
    answer_recur answer_tail_recur answer_fold answer_lazy_seq
```

### Giải quyết qua đệ quy (recursion.ml)
```ocaml
let sum list =
  let rec sum_recur list =
    match list with [] -> Z.zero | x :: xs -> Z.add x (sum_recur xs)
  in
  sum_recur list
```

### Giải quyết qua đệ quy đuôi (tail_recursion.ml)
```ocaml
let sum list =
  let rec sum_tail_recur acc list =
    match list with [] -> acc | x :: xs -> sum_tail_recur (Z.add acc x) xs
  in
  sum_tail_recur Z.zero list
```

### Giải quyết qua khối (fold.ml)
```ocaml
let sum list = List.fold_left Z.add Z.zero list
```

### Giải quyết qua lazy sequence (lazy_seq.ml)
```ocaml
type 'a seq_node =
  | Nil (*end of sequence*)
  | Cons of 'a * (unit -> 'a seq_node)

(* impl seq_of_list *)
let rec seq_of_list lst () =
  match lst with [] -> Nil | x :: xs -> Cons (x, seq_of_list xs)

(* impl seq_fold_left  *)
let rec seq_fold_left f acc s =
  match s () with Nil -> acc | Cons (x, xs) -> seq_fold_left f (f acc x) xs

let sum numbers =
  let list_seq = seq_of_list numbers in
  seq_fold_left Z.add Z.zero list_seq
```

### Giải quyết qua ngôn ngữ chỉ định (Java) 
```java
import java.math.BigInteger;

public class Euler13 {

    static String[] numbersStr = {
        "37107287533902102798797998220837590246510135740250",
        //...
        "53503534226472524250874054075591789781264330331690"
    };

    // calculate sum 
    public static BigInteger sumNumbers(String[] numbers) {
        BigInteger sum = BigInteger.ZERO;
        for (String numStr : numbers) {
            BigInteger num = new BigInteger(numStr);
            sum = sum.add(num);
        }
        return sum;
    }

    // take first 10 digits of sum
    public static String first10Digits(BigInteger sum) {
        String sumStr = sum.toString();
        return sumStr.substring(0, 10);
    }

    public static void main(String[] args) {
        BigInteger total = sumNumbers(numbersStr);
        String first10 = first10Digits(total);
        System.out.println("First 10 digits of sum: " + first10);
    }
}
```

### Kết quả thực thi
OCaml bash:
```bash
The first 10 digits of the sum are:
[1- Recursion| 2- Tail_recursion| 3- Fold| 4- Lazy sequence]:

[1] 5537376230
[2] 5537376230
[3] 5537376230
[4] 5537376230
```
Java console: 
```console
First 10 digits of sum: 5537376230

Process finished with exit code 0

```

## Problem 17 
- Tên: Number Letter Counts
- Miêu tả: If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total. Chi tiết hơn ở [đây](https://projecteuler.net/problem=17)
- Yêu cầu: If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?

### Cơ bản ý tưởng giải quyết 
Ý tưởng là chuyển từng số từ 1 đến 1000 thành chữ tiếng Anh, theo quy tắc Anh–Anh (có “and” cho số trăm, bỏ khoảng trắng và dấu gạch nối). 
Sau đó, tính số chữ cái của mỗi số. Có thể triển khai nhiều cách: đệ quy đuôi, đệ quy thường, map/fold hoặc lazy sequence, trong khi phần logic chuyển số sang chữ được tách riêng 
để tái sử dụng cho tất cả các phương pháp. 
Tổng cuối cùng là tổng số chữ cái của toàn bộ dãy 1–1000.

### Hàm chuyển số sang chữ (lib/num_to_words.ml)
```ocaml 
let ones =
  [|
    ""; "one"; "two"; "three"; "four"; "five"; "six"; "seven"; "eight"; "nine";
    "ten"; "eleven"; "twelve"; "thirteen"; "fourteen"; "fifteen"; "sixteen"; "seventeen"; "eighteen"; "nineteen";
  |]

let tens =
  [|
    ""; ""; "twenty"; "thirty"; "forty"; "fifty"; "sixty"; "seventy"; "eighty"; "ninety";
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
```

### Hàm chính (bin/main.ml)
Gọi ra các phương thức giải quyết và in ra kết quả thực thi chúng để so sánh  
```ocaml
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
```


### Giải quyết qua đệ quy (lib/recursion.ml)
```ocaml
open Num_to_words

let rec sum_recursive a b =
  if a > b then 0 else letters a + sum_recursive (a + 1) b
```

### Giải quyết qua đệ quy đuôi (lib/tail_recursion.ml)
```ocaml
open Num_to_words

let sum_tail a b =
  let rec loop acc n = if n > b then acc else loop (acc + letters n) (n + 1) in
  loop 0 a
```

### Giải quyết qua khối (lib/fold_map.ml)
```ocaml
open Num_to_words

let sum_fold_map a b =
  List.init (b - a + 1) (fun i -> a + i)
  |> List.map letters |> List.fold_left ( + ) 0
```

### Giải quyết qua lazy sequence (lib/lazy_seq.ml)
```ocaml
open Num_to_words

let sum_seq a b =
  let open Seq in
  let nums = unfold (fun n -> if n > b then None else Some (n, n + 1)) a in
  nums |> map letters |> fold_left ( + ) 0
```
### Hàm test (test/test_euler_17.ml)
```ocaml
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
```

### Giải quyết qua ngôn ngữ chỉ định (Java) 
```java
import java.util.stream.IntStream;

public class Euler17 {
    private static final String[] ONES = {
            "", "one","two","three","four","five","six","seven","eight","nine",
            "ten","eleven","twelve","thirteen","fourteen","fifteen",
            "sixteen","seventeen","eighteen","nineteen"
    };
    private static final String[] TENS = {
            "","","twenty","thirty","forty","fifty","sixty","seventy","eighty","ninety"
    };

    static String toWordsUK(int n) {
        if (n == 1000) return "one thousand";
        int h = n / 100;
        int r = n % 100;

        StringBuilder sb = new StringBuilder();
        if (h > 0) {
            sb.append(ONES[h]).append(" hundred");
            if (r != 0) sb.append(" and");
        }
        if (r > 0) {
            if (r < 20) {
                sb.append(" ").append(ONES[r]);
            } else {
                int t = r / 10, o = r % 10;
                if (o == 0) sb.append(" ").append(TENS[t]);
                else sb.append(" ").append(TENS[t]).append("-").append(ONES[o]);
            }
        }
        return sb.toString().trim();
    }

    static int lettersCount(String s) {
        int cnt = 0;
        for (char c : s.toCharArray()) {
            if (Character.isLetter(c)) cnt++;
        }
        return cnt;
    }

    static int letters(int n) {
        return lettersCount(toWordsUK(n));
    }

    public static void main(String[] args) {
        // tests
        if (letters(342) != 23 || letters(115) != 20) {
            throw new AssertionError("Examples failed");
        }
        int ans = IntStream.rangeClosed(1, 1000).map(Euler17::letters).sum();
        System.out.println("Answer: " + ans);
    }
}
```

### Kết quả thực thi
OCaml base:
```bash
[Tail Recursion ] Answer: 21124
[Recursion      ] Answer: 21124
[Fold/Map       ] Answer: 21124
[Lazy Seq       ] Answer: 21124
```
Java console: 
```console
Answer: 21124

Process finished with exit code 0
```

## **Kết luận**

Trong quá trình giải quyết các bài toán, tôi đã áp dụng một số kỹ thuật đặc trưng của ngôn ngữ hàm OCaml:

* **Đệ quy** – cả đệ quy thường và đệ quy đuôi – để hiện thực hóa các vòng lặp.
* **Pattern Matching** – để thực hiện các nhánh điều kiện, gán giá trị; áp dụng cho pattern và danh sách; v.v.

Ngoài ra, tôi còn thử một vài giải pháp khác từ sự tò mò, như sử dụng **map/fold**, **lazy sequence**. Qua đó nhận ra rằng việc tách module, tái sử dụng hàm, và làm việc với các collections trong OCaml rất tiện lợi.

Tóm lại, với một số bài toán, viết giải pháp bằng OCaml có thể tiện lợi hơn so với các ngôn ngữ lập trình mệnh lệnh truyền thống, nhưng với bài toán khác, lại ngược lại. 
Kết luận cuối cùng: ngôn ngữ hàm OCaml thật sự rất thú vị. 
