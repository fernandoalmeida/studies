fun is_older (a : int*int*int, b : int*int*int) =
	(#1 a < #1 b) orelse (#1 a = #1 b andalso (#2 a < #2 b orelse (#2 a = #2 b andalso #3 a < #3 b)))


fun number_in_month (dates : (int * int * int) list, month : int) =
    if null dates
    then 0
    else (if #2 (hd dates) = month then 1 else 0) + number_in_month(tl dates, month)


fun number_in_months (dates : (int * int * int) list, months : int list) =
    if null dates orelse null months
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months)


fun dates_in_month (dates : (int * int * int) list, month : int) =
    if null dates
    then []
    else
        let val date = hd dates
        in if #2 date = month
            then (hd dates) :: dates_in_month(tl dates, month)
            else dates_in_month(tl dates, month)
        end


fun dates_in_months (dates : (int * int * int) list, months : int list) =
    if null dates orelse null months
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)


fun get_nth (strings : string list, n : int) =
    if n = 1
    then hd strings
    else get_nth(tl strings, n-1)


val month_names = ["January", "February", "March", "April",
                   "May", "June", "July", "August", "September",
                   "October", "November", "December"]


fun date_to_string (date : int * int * int) =
    get_nth(month_names, #2 date) ^ " " ^ Int.toString(#2 date) ^ ", " ^ Int.toString(#1 date)


fun number_before_reaching_sum (sum : int, numbers : int list) =
    let fun count_to_sum (counter : int, approaching_sum : int, numbers : int list) =
        if approaching_sum >= sum
        then counter
        else count_to_sum(counter + 1, approaching_sum + hd numbers, tl numbers)
    in
        count_to_sum(0, 0, numbers) - 1
    end


val days_per_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]


fun what_month (day_in_year : int) =
    number_before_reaching_sum(day_in_year, days_per_month) + 1


fun month_range (day1 : int, day2 : int) =
    if day1 > day2
    then []
    else what_month(day1) :: month_range(day1+1, day2)


fun oldest (dates : (int * int * int) list) =
    if null dates
    then NONE
    else
        let
            val tl_date = oldest(tl dates)
        in
            if isSome tl_date andalso is_older(valOf tl_date, hd dates)
            then tl_date
            else SOME (hd dates)
        end
