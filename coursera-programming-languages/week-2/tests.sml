(* function bindings *)

fun pow (x : int, y : int) = (* y >= 0 *)
  if y = 0
  then 1
  else x * pow(x, y - 1)

fun cube (x : int) =
  pow(x, 3)

val ans = cube(4)

(* pairs *)

fun swap (pr : int * bool) =
  (#2 pr, #1 pr)

fun sum_two_pairs (pr1 : int * int, pr2 : int * int) =
  (#1 pr1) + (#2 pr1) + (#1 pr2) + (#2 pr2)

fun div_mod (x : int, y : int) =
  (x div y, x mod y)

fun sort_pair (pr : int * int) =
  if (#1 pr) < (#2 pr)
  then pr
  else ((#2 pr), (#1 pr))

val s = swap((1, true))
val p = sum_two_pairs((1, 2), (3, 4))
val d = div_mod(10, 5)
val t = sort_pair((3,2))

(* lists *)

val empty_list = []
val list1 = [1, 2, 3]
val list2 = 1 :: [2, 3]

val e = null(empty_list)
val ne = null(list1)
val h = hd(list1)
val t = tl(list2)

fun sum_list (xs : int list) =
  if null xs
  then 0
  else (hd xs) + sum_list(tl xs)

fun countdown (x : int) =
  if x = 0
  then []
  else x :: countdown(x - 1)

fun append (xs : int list, ys : int list) =
  if null xs
  then ys
  else (hd xs) :: append(tl xs, ys)

val sl = sum_list([1, 2, 3, 4])
val c = countdown(5)
val a = append([1,2], [3,4])

fun sum_pair_list (xs : (int * int) list) =
  if null xs
  then 0
  else #1 (hd xs) + #2 (hd xs) + sum_pair_list(tl xs)

fun firsts (xs : (int * int) list) =
  if null xs
  then []
  else (#1 (hd xs)) :: (firsts(tl xs))

fun seconds (xs : (int * int) list) =
  if null xs
  then []
  else (#2 (hd xs)) :: (seconds(tl xs))

fun sum_pair_list2 (xs : (int * int) list) =
  (sum_list (firsts xs)) + (sum_list (seconds xs))

val sp = sum_pair_list([(1, 2), (3, 4), (5, 6)])
val f = firsts([(1, 2), (3, 4), (5, 6)])
val s2 = seconds([(1, 2), (3, 4), (5, 6)])
val sp2 = sum_pair_list2([(1, 2), (3, 4), (5, 6)]);

(* let expressions *)

let val x = 1
in
    (let val x = 2 in x + 1 end) + (let val y = x + 2 in y + 1 end)
end;

fun countup_from1 (x : int) =
  let fun count (from : int) =
	if from = x
	then x :: []
	else from :: count(from + 1)
  in
      count(1)
  end;

(* options *)

fun max (xs : int list) =
  if null xs
  then NONE
  else let
      fun max_nonempty (xs : int list) =
	if null (tl xs)
	then hd xs
	else let val tl_ans = max_nonempty(tl xs)
      in
	  if hd xs > tl_ans
	  then hd xs
	  else tl_ans
      end
  in
      SOME (max_nonempty xs)
  end

val cf = countup_from1(5)
val m0 = max([]);
val m1 = max([3, 5, 1, 6, 0]);

(* other expressions *)

val b1 = true andalso false
val b2 = true orelse false
val b3 = not false
val b4 = (false = true)
val b5 = (false <> true)
val i1 = 2 - 1
val i2 = ~1 (* negative number -1 *)
val i3 = (~1 = 0 - 1)
