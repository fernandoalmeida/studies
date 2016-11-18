(* problem 1 *)

fun same_string (s1 : string, s2 : string) =
  s1 = s2

fun all_except_option (x : string, xs : string list) =
  case xs of
      [] => NONE
    | y :: ys =>
      if same_string(y, x)
      then SOME ys
      else
	  case all_except_option(x, ys) of
              NONE => NONE
            | SOME zs => SOME (y :: zs)

fun get_substitutions1 (xss : string list list, x : string) =
  case xss of
      [] => []
    | ys :: yss =>
      case all_except_option(x, ys) of
          NONE => get_substitutions1(yss, x)
        | SOME zs => zs @ get_substitutions1(yss, x)

fun get_substitutions2 (xss : string list list, x : string) =
  let
      fun aux (xss' : string list list, x' : string, xs : string list) =
	case xss' of
            [] => xs
          | ys :: yss =>
	    case all_except_option(x', ys) of
                NONE => aux(yss, x', xs)
              | SOME y => aux(yss, x', xs @ y)
  in
      aux(xss, x, [])
  end

fun similar_names (xss : string list list, name) =
  let
      val { first = f, middle = m, last = l } = name

      fun aux (xs : string list) =
	case xs of
            [] => []
          | x :: xs' => { first = x, middle = m, last = l } :: aux xs'
  in
      name :: aux(get_substitutions2(xss, f))
  end

(* problem 2 *)

datatype suit = Clubs | Diamonds | Hearts | Spades

datatype rank = Jack | Queen | King | Ace | Num of int

type card = suit * rank

datatype color = Red | Black

datatype move = Discard of card | Draw

exception IllegalMove

fun card_color (s : suit, _) =
  case s of
      (Spades | Clubs) => Black
    | (Diamonds | Hearts) => Red

fun card_value (_, r : rank) =
  case r of
      Num n => n
    | Ace => 11
    | (Jack | Queen | King) => 10

fun remove_card (cs : card list, c : card, e : exn) =
  case cs of
      [] => raise e
    | c' :: cs' => if (c' = c) then cs' else c :: remove_card(cs', c, e)

fun all_same_color (cs : card list) =
  case cs of
      [] => true
    | _ :: [] => true
    | x :: y :: xs => card_color x = card_color y andalso all_same_color(x::xs)

fun sum_cards (cs : card list) =
  let
      fun aux(cs : card list, sum : int) =
	case cs of
            [] => sum
          | c :: cs' => aux(cs', sum + card_value c)
  in
      aux(cs, 0)
  end

fun score (cs : card list, goal : int) =
  let
      val sum = sum_cards cs
      val preliminary = if sum > goal then 3 * (sum - goal) else goal - sum
  in
      if all_same_color cs then preliminary div 2 else preliminary
  end

fun officiate (cs : card list, ms : move list, goal : int) =
  let
      val e = IllegalMove
      fun aux (cs', ms', hs : card list) =
        case ms' of
            [] => score(hs, goal)
          | (Discard c) :: ms'' => aux(cs', ms'', remove_card(hs, c, e))
          | Draw :: ms'' =>
	    case cs' of
		[] => score(hs, goal)
              | c :: cs'' =>
		if sum_cards(c :: hs) > goal
		then score(c :: hs, goal)
		else aux(cs'', ms'', c :: hs)
  in
      aux(cs, ms, [])
  end
