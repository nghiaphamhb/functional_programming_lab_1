# Лабораторная работа 1
## Проект Эйлера №13, №17

- Студент: Фам Данг Чунг Нгиа
- Группа: P3321
- ИСУ: 374806
- Функциональный язык: OCaml

## Проблема №13 
- Название: Large Sum
- Описание: https://projecteuler.net/problem=13
- Задание: Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.

### Основная идея решения 
В рамках решения мы выполняем суммирование всех 100 целых чисел по 50 цифр. Каждое число хранится в виде строки и преобразуется в тип больших целых чисел (`Z.t` в OCaml) с помощью `List.map`.
Для вычисления суммы используются разные подходы. В конце берутся первые 10 цифр полученной суммы и выводятся на экран.

#### Вводные данные
```ocaml
(* lib/data.ml *)
let numbers_str_list =
  [
    (*list of string*)
    "37107287533902102798797998220837590246510135740250";
    (*...*)
    "91942213363574161572522430563301811072406154908250";
  ]
```

### 1. Решение через хвостовую рекурсию 
```ocaml
(* bin/main.ml *)
open Data

let () =
  let numbers : Z.t list = List.map Z.of_string numbers_str_list in
  let rec loop acc = function [] -> acc | x :: tl -> loop (Z.add acc x) tl in
  let sum = loop Z.zero numbers in
  Printf.printf "The first 10 digits of the sum are [Tail recursion]: \n%s\n"
    (String.sub (Z.to_string sum) 0 10)
```

### 2. Решение через рекурсию 
```ocaml
(* bin/main.ml *)
open Data

let () =
  let numbers : Z.t list = List.map Z.of_string numbers_str_list in
  let rec loop = function [] -> Z.zero | x :: tl -> Z.add x (loop tl) in
  let sum = loop numbers in
  Printf.printf "The first 10 digits of the sum are [Recursion]: \n%s\n"
    (String.sub (Z.to_string sum) 0 10)
```
### 3. Решение через модульность
#### 3.1. Модуль генерации последовательности 
```ocaml
(* lib/fold_seq.ml*)
let generate_numbers x =
  let numbers_str : string list = x in
  List.map Z.of_string numbers_str

(* bin/main.ml *)
open Fold_seq
let numbers : Z.t list = generate_numbers numbers_str_list
```

#### 3.2. Модуль вычисления с помощью fold 
```ocaml
(* lib/fold_seq.ml*)
let sum_fold_10_digits y =
  y |> List.fold_left Z.add Z.zero |> Z.to_string |> fun s -> String.sub s 0 10

(* bin/main.ml *)
open Fold_seq
let sum_fold : string = sum_fold_10_digits numbers
```

#### 3.3 Модуль вычисления с помощью ленивых коллекций
```ocaml
(* lib/fold_seq.ml*)
let sum_lq_10_digits y =
  y |> List.to_seq |> Seq.fold_left Z.add Z.zero |> Z.to_string |> fun s ->
  String.sub s 0 10

(* bin/main.ml *)
open Fold_seq
let sum_lq : string = sum_lq_10_digits numbers
```

#### 3.4. Модуля фильтра 
```ocaml
(* lib/fold_seq.ml*)
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

(* bin/main.ml *)
open Fold_seq
let filtered_sum_fold : string = filtered_sum_fold sum_fold
let filtered_sum_lq : string = filtered_sum_lq sum_lq
```

#### 3.5. Вывод результатов модулей
```ocaml
(* bin/main.ml *)
let () =
  Printf.printf
    "The first 10 digits of the sum are [Fold]: \n\
     %s\n\
     The first 10 digits of the sum are [Lazy sequence]: \n\
     %s\n"
    filtered_sum_fold filtered_sum_lq
```
### 4. Решение через императивный язык (Java) 
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

#### 5. Результаты выполнения
OCaml bash:
```bash
The first 10 digits of the sum are [Tail recursion]:
5537376230
The first 10 digits of the sum are [Recursion]:
5537376230
The first 10 digits of the sum are [Fold]:
5537376230
The first 10 digits of the sum are [Lazy sequence]:
5537376230
```
Java console: 
```console
First 10 digits of sum: 5537376230

Process finished with exit code 0

```


### 6. Вывод результатов тестов
```bash
{Project Euler 13 - tests}
  Testing `Project Euler 13 - tests'.
  This run has ID `D0AOKX0N'.
  
    [OK]          tail recursion                       0   tail_first10.
    [OK]          plain recursion                      0   rec_first10.
    [OK]          fold & lazy (module values)          0   fold/lazy from module.
    [OK]          filtered variants                    0   filtered fold/lazy.
  
  Full test results in `~/work/functional_programming_lab_1/functional_programming_lab_1/euler_13/_build/default/test/_build/_tests/Project Euler 13 - tests'.
  Test Successful in 0.000s. 4 tests run.
```

## Проблема №17 
- Название: Number Letter Counts
- Описание: If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total. Подробнее [здесь](https://projecteuler.net/problem=17)
- Задание: If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?

### Основная идея решения 
Идея заключается в том, чтобы преобразовать каждое число от 1 до 1000 в английские слова по правилам британского английского (с «and» для сотен, без пробелов и дефисов).
Затем вычисляется количество букв в каждом числе. Решение можно реализовать разными способами: хвостовая рекурсия, обычная рекурсия, map/fold или ленивые последовательности, 
при этом логика преобразования числа в слова вынесена в отдельный модуль для повторного использования во всех методах.
Итоговая сумма — это общее количество букв для всего диапазона от 1 до 1000.


### 0. Функция переключения цифр на буквы (lib/num_to_words.ml)
```ocaml 
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
```

### 1. Решение через хвостовую рекурсию 
```ocaml
open Printf
open Num_to_words

let () =
  let a, b = (1, 1000) in
  let rec loop acc n = if n > b then acc else loop (acc + letters n) (n + 1) in
  let ans_tail = loop 0 a in
  Printf.printf "Answer [Tail Recursion ]: %d\n" ans_tail
```


### 2. Решение через рекурсию 
```ocaml
open Printf
open Num_to_words

let () =
  let a, b = (1, 1000) in
  let rec sum_recursive a b =
    if a > b then 0 else letters a + sum_recursive (a + 1) b
  in
  let ans_rec = sum_recursive a b in
  Printf.printf "Answer [Recursion      ]: %d\n" ans_rec
```

### 3. Решение через модульность
#### 3.1. Модуля генерации последовательности 
```ocaml
open Printf
open Num_to_words

let list =
  let a, b = (1, 1000) in
  if a > b then []
  else List.init (b - a + 1) Fun.id |> List.map (fun i -> a + i)

let seq =
  let a, b = (1, 1000) in
  if a > b then Seq.empty
  else
    Seq.unfold (fun i -> if i > b - a then None else Some (i, i + 1)) 0
    |> Seq.map (fun i -> a + i)
```

#### 3.2. Модуля фильтра
```ocaml
let filtered_list = List.filter (fun n -> n >= 1 && n <= 1000) list
let filtered_seq = Seq.filter (fun n -> n >= 1 && n <= 1000) seq
```

#### 3.3. Модуль вычисления с помощью fold
```ocaml
let ans_fold = List.fold_left (fun acc x -> acc + letters x) 0 filtered_list
```

#### 3.4. Модуль вычисления с помощью ленивых коллекций 
```ocaml
let ans_seq = Seq.fold_left (fun acc x -> acc + letters x) 0 filtered_seq
```
#### 3.5. Вывод результатов модулей
```ocaml
(* bin/main.ml *)
let () = printf "Answer [Fold/Reduce    ]: %d\n" ans_fold
let () = printf "Answer [Lazy Seq       ]: %d\n" ans_seq
```

### 4. Решение через императивный язык (Java) 
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

### 5. Результаты выполнения
OCaml base:
```bash
Answer [Tail Recursion ]: 21124
Answer [Recursion      ]: 21124
Answer [Fold/Reduce    ]: 21124
Answer [Lazy Seq       ]: 21124
```
Java console: 
```console
Answer: 21124

Process finished with exit code 0
```

### 6. Вывод результатов тестов
```bash
{Project Euler 17 - tests}
  Testing `Project Euler 17 - tests'.
  This run has ID `UGJKCMJ3'.
  
    [OK]          examples          0   basic examples.
    [OK]          uk form           0   spelling checks.
    [OK]          sanitize          0   letters_count ignores non-letters.
    [OK]          answer            0   final sum 1..1000.
  
  Full test results in `~/work/functional_programming_lab_1/functional_programming_lab_1/euler_17/_build/default/test/_build/_tests/Project Euler 17 - tests'.
  Test Successful in 0.001s. 4 tests run.
```

## Выводы
В процессе решения задач я применял некоторые характерные техники функционального языка OCaml:

- **Рекурсия** – как обычная, так и хвостовая – для реализации циклов.
- **Pattern Matching** – для ветвлений, присваивания значений; применяется к шаблонам и спискам и т.д.

Кроме того, я попробовал несколько решений из любопытства, например, с использованием **map/fold**, **ленивых последовательностей (lazy sequence)**. Это позволило осознать, что разделение на модули, повторное использование функций и работа с коллекциями в OCaml очень удобны.

В итоге, для некоторых задач решение на OCaml может быть удобнее, чем на традиционных императивных языках, а для других задач – наоборот.
Вывод: функциональный язык OCaml действительно очень интересен.

