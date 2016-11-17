fun is_older ( a : int * int * int, b : int * int * int ) =
  let
    val ao = ( #1 a ) * 365 + ( #2 a ) * 30 + ( #3 a )
    val bo = ( #1 b ) * 365 + ( #2 b ) * 30 + ( #3 b )
  in
    if ao < bo
    then true
    else false
  end


fun number_in_month ( datel : ( int * int * int ) list, month ) =
  let
    fun is_equal ( x : int * int * int ) =
      if ( #2 ( x ) ) = month
      then 1
      else 0

    fun sum ( sub_datel : ( int * int * int ) list ) =
      if null sub_datel
      then 0
      else is_equal ( hd sub_datel ) + sum ( tl sub_datel )
  in
    sum ( datel )
  end


fun number_in_months ( datel : ( int * int * int ) list, monthl : int list ) =
  if null monthl
  then 0
  else number_in_month ( datel, hd monthl ) + number_in_months ( datel, tl monthl )


fun dates_in_month ( datel : ( int * int * int ) list, month : int ) =
      if null sub_datel
      then []
      else if ( #2 ( hd sub_datel ) ) = month
      then ( hd sub_datel ) :: dates_in_month ( tl sub_datel, month )
      else dates_in_month ( tl sub_datel, month )


fun dates_in_months ( datel : ( int * int * int ) list, monthl : int list ) =
  if null monthl
  then []
  else dates_in_month ( datel, hd monthl ) @ dates_in_months ( datel, tl monthl )


fun get_nth ( strl : string list, index : int ) =
  if index = 1
  then hd strl
  else get_nth ( tl strl, index - 1 )


fun date_to_string ( year : int, month : int, day : int ) =
  let
    val e_monthl = [ "January", "February", "March", "April",
    "May", "June", "July", "August", "September", "October", "November", "December" ]
  in
    get_nth ( e_monthl, month ) ^ " " ^ Int.toString ( day ) ^ ", " ^ Int.toString ( year )
  end


fun number_before_reaching_sum ( sum_num : int, numl : int list ) =
  let
    fun sum ( sub_numl : int list, last_sum : int, flag : int ) =
      if null sub_numl orelse last_sum + hd sub_numl >= sum_num
      then flag
      else sum ( tl sub_numl, last_sum + ( hd sub_numl ), flag + 1 )
  in
    sum ( numl, 0, 0 )
  end


fun what_month ( day : int ) =
  let
    val month_holds = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]
  in
    number_before_reaching_sum ( day, month_holds ) + 1
  end


fun month_range ( day1 : int, day2 : int ) =
  if day1 > day2
  then []
  else
    what_month ( day1 ) :: month_range ( day1 + 1, day2 )


fun oldest ( datel : ( int * int * int ) list ) =
  let
    fun find_oldest ( datel : ( int * int * int ) list ) =
      if null ( tl datel )
      then hd datel
      else
        let
          val temp = find_oldest ( tl datel )
        in
          if is_older ( hd datel, temp )
          then hd datel
          else temp
        end
  in
    if null datel
    then NONE
    else SOME ( find_oldest ( datel ) )
  end
