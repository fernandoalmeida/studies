(* thanks to squiter for the test cases :) *)

(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "peers/lee-chen.sml";

val test1 = only_capitals ["A","B","C"] = ["A","B","C"]
val test1a = only_capitals ["Ab","Bb","Cb"] = ["Ab","Bb","Cb"]
val test1b = only_capitals ["Ab","bB","Cb"] = ["Ab","Cb"]

val test2 = longest_string1 ["A","bc","C"] = "bc"
val test2a = longest_string1 [] = ""
val test2b = longest_string1 ["A","bc","C", "cd"] = "bc"
val test2c = longest_string1 ["A","bc","C", "cdc", "cdb"] = "cdc"

val test3 = longest_string2 ["A","bc","C"] = "bc"
val test3a = longest_string2 [] = ""
val test3b = longest_string2 ["A","bc","C", "cd"] = "cd"
val test3c = longest_string2 ["A","bc","C", "cdc", "cdb"] = "cdb"

val test4a = longest_string3 ["A","bc","C"] = "bc"
val test4aa = longest_string3 [] = ""
val test4ab = longest_string3 ["A","bc","C", "cd"] = "bc"
val test4ac = longest_string3 ["A","bc","C", "cdc", "cdb"] = "cdc"

val test4b = longest_string4 ["A","B","C"] = "C"
val test4ba = longest_string4 [] = ""
val test4bb = longest_string4 ["A","bc","C", "cd"] = "cd"
val test4bc = longest_string4 ["A","bc","C", "cdc", "cdb"] = "cdb"

val test5 = longest_capitalized ["A","bc","c"] = "A"
val test5a = longest_capitalized [] = ""
val test5b = longest_capitalized ["A","bc","C", "cd"] = "A"
val test5c = longest_capitalized ["A","bc","C", "cdc", "cdb"] = "A"

val test61 = rev_string "" = ""
val test62 = rev_string "abc" = "cba"

val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
val test7b = first_answer (fn x => if x = "x" then SOME x else NONE) ["z", "x", "a"] = "x"

val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test8a = all_answers (fn x => if x = 1 then SOME [x] else NONE) [] = SOME []
val test8b = all_answers (fn x => if x = 1 then SOME [x] else NONE) [1] = SOME [1]
val test8c = all_answers (fn x => if x = 1 then SOME [x] else NONE) [1,1,1] = SOME [1,1,1]
val test8d = all_answers (fn x => if x = 1 then SOME [x] else NONE) [1,2,1] = NONE

val test9a = count_wildcards Wildcard = 1
val test9aa = count_wildcards (TupleP [Wildcard, Wildcard, (ConstP 0)]) = 2
val test9ac = count_wildcards(ConstructorP("Test", TupleP [Variable "a", Wildcard])) = 1

val test9b = count_wild_and_variable_lengths (Variable("a")) = 1
val test9ba = count_wild_and_variable_lengths (TupleP [Variable("a"), Wildcard]) = 2

val test9c = count_some_var ("x", Variable("x")) = 1
val test9ca = count_some_var ("x", (TupleP [Variable("x"), Wildcard, Variable("x")])) = 2

val test10 = check_pat (Variable("x")) = true
val test10b = check_pat (TupleP [Variable("x"), Variable("y")]) = true
val test10c = check_pat (TupleP [Variable("x"), Variable("y"), Wildcard]) = true
val test10d = check_pat (TupleP [Variable("x"), Variable("x"), Wildcard]) = false
val test10e = check_pat (ConstructorP ("hi",TupleP[Variable "x",Variable "x"])) = false
val test10f = check_pat (ConstructorP ("hi",TupleP[Variable "x",ConstructorP ("yo",TupleP[Variable "x",UnitP])])) = false

val test11 = match (Const(1), UnitP) = NONE
val test11a = match (Const(1), Variable("x")) = SOME[("x", Const(1))]
val test11b = match (Const(1), ConstP(5)) = NONE
val test11c = match (Const(1), ConstP(1)) = SOME[]
val test11d = match (Const(1), Wildcard) = SOME[]
val test11e = match (Unit, UnitP) = SOME[]
val test11f = match (Unit, Wildcard) = SOME[]
val test11h = match (Const(1), UnitP) = NONE;
val test11h = match (Const 1, Variable "a") = SOME [("a", Const 1)];
val test11i = match (Tuple([Const 1]), TupleP([Variable "a"])) = SOME [("a", Const 1)];
val test11j = match (Constructor("a", Tuple([Const 1])), ConstructorP("a", TupleP([Variable "a"]))) = SOME [("a", Const 1)];

val test12 = first_match Unit [UnitP] = SOME []
(* val test12 = first_match (Unit [UnitP]) = SOME [] *)
(* val test12a = first_match (Unit [ConstP(1),ConstP(15)]) = NONE *)
(* val test12b = first_match (Unit [ConstP(1),Variable("x")]) = SOME [("x",Unit)] *)
(* val test12c = first_match (Unit [ConstP(1),Variable("x"),Wildcard]) = SOME [("x",Unit)] *)
(* val test12d = first_match (Unit [ConstP(1),Variable("x"),Variable("y")]) = SOME [("x",Unit)] *)
