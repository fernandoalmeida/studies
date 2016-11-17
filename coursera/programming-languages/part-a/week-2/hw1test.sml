(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw1_p1.sml";

val test11 = is_older ((1,2,3),(2,3,4)) = true
val test12 = is_older ((1,2,3),(1,3,4)) = true
val test13 = is_older ((1,2,3),(1,2,4)) = true
val test14 = is_older ((1,2,3),(1,2,3)) = false
val test15 = is_older ((2,3,4),(1,2,3)) = false
val test16 = is_older ((1,3,4),(1,2,3)) = false
val test17 = is_older ((1,2,4),(1,2,3)) = false

val test20 = number_in_month ([],2) = 0
val test21 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1
val test22 = number_in_month ([(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1)],2) = 3

val test30 = number_in_months ([],[2,3,4]) = 0
val test31 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3
val test32 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28),(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28),(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 9

val test40 = dates_in_month ([],2) = []
val test41 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val test42 = dates_in_month ([(2012,2,28),(2013,12,1),(2012,2,27),(2013,11,1),(2012,2,26),(2013,10,1)],2) = [(2012,2,28),(2012,2,27),(2012,2,26)]

val test50 = dates_in_months ([],[2,3,4]) = []
val test51 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
val test52 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28),(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2012,2,28),(2011,3,31),(2011,3,31),(2011,4,28),(2011,4,28)]

val test61 = get_nth (["hi", "there", "how", "are", "you"], 1) = "hi"
val test62 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"
val test63 = get_nth (["hi", "there", "how", "are", "you"], 5) = "you"

val test70 = date_to_string (2013, 1, 1) = "January 1, 2013"
val test71 = date_to_string (2013, 6, 1) = "June 1, 2013"
val test72 = date_to_string (2013, 12, 1) = "December 1, 2013"

val test80 = number_before_reaching_sum (1, [0,1,2,3,4,5]) = 1
val test81 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3
val test82 = number_before_reaching_sum (15, [1,2,3,4,5]) = 4

val test90 = what_month 1 = 1
val test91 = what_month 70 = 3
val test92 = what_month 365 = 12

val test100 = month_range (31, 30) = []
val test101 = month_range (31, 31) = [1]
val test102 = month_range (31, 34) = [1,2,2,2]

val test110 = oldest([]) = NONE
val test111 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
val test112 = oldest([(2012,2,28),(2011,3,31),(2011,2,27)]) = SOME (2011,2,27)
