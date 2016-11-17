fun is_older (dx : (int * int * int), dy : (int * int * int)) =
  let
    val y1 = #1 dx
    val m1 = #2 dx
    val d1 = #3 dx
    val y2 = #1 dy
    val m2 = #2 dy
    val d2 = #3 dy
  in
    (y1 < y2)
    orelse (y1 = y2 andalso m1 < m2)
    orelse (y1 = y2 andalso m1 = m2 andalso d1 < d2)
  end

fun number_in_month (ds : (int * int * int) list, m : int) =
  if null ds
  then 0
  else
    (if #2 (hd ds) = m then 1 else 0) + number_in_month(tl ds, m)

fun number_in_months (ds : (int * int * int) list, ms : int list) =
  if null ms
  then 0
  else number_in_month(ds, hd ms) + number_in_months(ds, tl ms)

fun dates_in_month (ds : (int * int * int) list, m : int) =
  if null ds
  then []
  else
    (if #2 (hd ds) = m then [hd ds] else []) @ dates_in_month(tl ds, m)

fun dates_in_months (ds : (int * int * int) list, ms : int list) =
  if null ms
  then []
  else dates_in_month(ds, hd ms) @ dates_in_months(ds, tl ms)

fun get_nth (xs : string list, n : int) =
  if n = 1
  then hd xs
  else get_nth((tl xs), n - 1)

fun date_to_string (dx : (int * int * int)) =
  let
    val y = #1 dx
    val m = #2 dx
    val d = #3 dx
    val ms = [
      "January", "February", "March", "April", "May", "June", "July", "August",
      "September", "October", "November", "December"
    ]
  in
    get_nth(ms, m) ^ " " ^ Int.toString(d) ^ ", " ^ Int.toString(y)
  end

fun number_before_reaching_sum (sum : int, xs : int list) =
  if hd xs >= sum
  then 0
  else 1 + number_before_reaching_sum(sum - (hd xs), (tl xs))

fun what_month (x : int) =
  let
    val xs = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  in
    1 + number_before_reaching_sum(x, xs)
  end

fun month_range (dx : int, dy : int) =
  if dx > dy
  then []
  else what_month(dx) :: month_range(dx + 1, dy)

fun oldest (ds : (int * int * int) list) =
  if null ds
  then NONE
  else
    let
      val oldest' = oldest(tl ds)
    in
      if isSome oldest' andalso is_older((valOf oldest'), (hd ds))
      then oldest'
      else SOME (hd ds)
    end
