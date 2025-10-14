let in_range_1_1000 n = n >= 1 && n <= 1000
let keep_valid_ints_list = List.filter in_range_1_1000
let keep_valid_ints_seq = Seq.filter in_range_1_1000
