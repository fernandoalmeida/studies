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
