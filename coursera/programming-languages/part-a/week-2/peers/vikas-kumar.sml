fun is_older(dt1 : int * int * int, dt2 : int * int * int) =
let

  val year1 = #1 dt1
  val month1 = #2 dt1
  val day1 = #3 dt1

  val year2 = #1 dt2
  val month2 = #2 dt2
  val day2 = #3 dt2

  fun is_older_day() =
    day1 < day2

  fun is_older_month() =
    if month1 = month2
    then is_older_day()
    else month1 < month2

in

  if year1 = year2
  then is_older_month()
  else year1 < year2

end

fun number_in_month(dates : (int * int * int) list, month : int) =
let
  fun hd_in_month() =
    if #2(hd(dates)) = month
    then 1
    else 0

in
  if null dates
  then 0
  else hd_in_month() + number_in_month(tl dates, month)

end

fun number_in_months(dates : (int * int * int) list, months : int list) =
  if null months
  then 0
  else number_in_month(dates, hd months) + number_in_months(dates, tl months)

fun dates_in_month(dates : (int * int * int) list, month : int) =
  if null dates
  then nil
  else
    if #2(hd(dates)) = month
    then hd dates :: dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)

fun dates_in_months(dates : (int * int * int) list, months : int list) =
  if null months
  then nil
  else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth(strs : string list, n : int) =
  if n = 1
  then hd strs
  else get_nth(tl strs, n - 1)

fun date_to_string(date : (int * int * int)) =
let
  val month_to_string = ["January", "February", "March", "April", "May",
    "June", "July", "August", "September", "October", "November", "December"]

in
  get_nth(month_to_string, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)

end

fun number_before_reaching_sum(sum : int, numbers : int list) =
  if hd numbers >= sum
  then 0
  else 1 + number_before_reaching_sum(sum - hd numbers, tl numbers)

fun what_month(day : int) =
let
  val days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

in
  number_before_reaching_sum(day, days_in_month) + 1
end

fun month_range(day1 : int, day2 : int) =
  if day1 > day2
  then nil
  else what_month(day1) :: month_range(day1 + 1, day2)

fun oldest(dates : (int * int * int) list) =
  if null dates
  then NONE
  else
    let
      fun nonempty_oldest(dates : (int * int * int) list) =
        if null (tl dates)
        then hd dates
        else
          let
            val tl_oldest = nonempty_oldest(tl dates)

          in
            if is_older(tl_oldest, hd dates)
            then tl_oldest
            else hd dates

          end

    in
      SOME (nonempty_oldest dates)
    end

fun unique(months : int list) =
  if null months
  then nil

  else if null (tl months)
  then months

  else
    let fun remove(month : int, months : int list) =
    if null months
    then nil
    else if month = hd months
    then remove(month, tl months)
    else (hd months) :: remove(month, tl months)

    in
      (hd months) :: unique(remove(hd months, tl months))
    end

fun number_in_months_challenge(dates : (int * int * int) list, months : int list) =
  number_in_months(dates, unique(months))

fun dates_in_months_challenge(dates : (int * int * int) list, months : int list) =
  dates_in_months(dates, unique(months))

fun reasonable_date(date : (int * int * int)) =
let
  val year = #1 date
  val month = #2 date
  val day = #3 date

  fun reasonable_year() =
    year > 0

  fun reasonable_month() =
    1 <= month andalso month <= 12

  fun reasonable_day() =
  let
    val days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    val max_days_wo_leap = List.nth(days_in_month, month - 1)
    val max_days =
      if month = 2
      then
        if year mod 400 = 0
        then 29
        else if year mod 4 = 0 andalso year mod 100 <> 0
        then 29
        else 28
      else max_days_wo_leap
  in
    1 <= day andalso day <= max_days
  end

in
  reasonable_year() andalso reasonable_month() andalso reasonable_day()
end
