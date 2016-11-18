(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
  s1 = s2

(* EXERCISE 1 *)

(* Could not figure this one out w/ @*)
           
fun all_except_option (in_string, in_stringlist) =
  let fun acclist(current, past) =
        case current of
            [] => NONE
          | x::x' => if same_string(in_string, x)
                     then SOME(past @ x')
                     else acclist(x', x :: past)
  in
      acclist(in_stringlist, [])
  end

fun get_substitutions1 (strings_list, s) =
  case strings_list of
      [] => []
    | x::x' => case all_except_option(s, x) of
                   NONE => get_substitutions1(x', s)
                | SOME z => z @ get_substitutions1(x', s)

fun get_substitutions2 (xs, s) =
  let fun aux(xs, acc) =
        case xs of
            [] => acc 
          | x::xs' => case all_except_option(s, x) of
                          NONE => aux(xs', acc)
                        | SOME z => aux(xs', z @ acc) 
  in
      aux(xs, [])
  end

fun similar_names (xs, name) =
  let val {first=first, middle=mid, last=l} = name (* basically destructuring *)
      fun get_names_list sub_xs =
        case sub_xs of
            [] => []
          | x::x' => {first=x, middle=mid, last=l}::get_names_list(x')
  in
      name::get_names_list(get_substitutions1(xs, first))
  end


(* EXERCISE 2 *)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

fun card_color (suit, rank) =
  case suit of
      Clubs => Black
    | Diamonds => Red
    | Hearts => Red
    | Spades => Black 

fun card_value (suit, rank) =
  case rank of
      Jack => 10
    | Queen => 10
    | King => 10
    | Ace => 11
    | Num i => i

fun remove_card (cs, c, e) =
  case cs of
      [] => raise e (* raise exception if it's not found basically *) 
    | xs::xs' => if xs = c then xs'
                 else
                     xs::remove_card(xs', c, e)

                                    
fun all_same_color (cs) =
  case cs of
      [] => true  (* return true on the empty list or raise exception? *)
   |   _ :: [] => true (* return true for length 1 list *) 
   | first::(second::rest) => card_color(first) = card_color(second) andalso all_same_color(second::rest)

fun sum_cards (cs) =
  let fun acc (xs, sums) =
        case xs of
            [] => sums
          | xs::xs' => acc(xs', card_value(xs) + sums)
  in
      acc(cs, 0)
  end

fun score (xs, goal) =
  let val sum = sum_cards(xs)
      fun prelim_score(sum) =
        if sum > goal then 3 * (sum - goal)
        else goal - sum
  in
      case all_same_color(xs) of
          true => prelim_score(sum) div 2
        | false => prelim_score(sum)
  end

      
