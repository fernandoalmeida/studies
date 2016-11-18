(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

fun all_except_option (s: string, st_list : string list) = 
  let fun aux(st_list : string list) =
	case st_list of
	    [] => []
	 |  x::ys => if same_string(x,s) then aux(ys) else x::aux(ys)
  in let val res = aux(st_list)  
    in  if res = st_list then NONE  else SOME res
    end
  end
 	     
fun get_substitutions1 (st_list_list : string list list, s : string) = 
  case st_list_list of
      [] => []
    | x :: ys => case all_except_option(s, x) of
		     NONE => [] @ get_substitutions1 (ys, s)
		  |  SOME a => a @ get_substitutions1 (ys, s)
 
fun get_substitutions2 (st_list_list : string list list, s : string) = 
  let fun aux (st_list_list : string list list, acc : string list) =
	      case st_list_list of
		  [] => acc
		| x :: ys => case all_except_option(s,x) of
				 NONE =>  aux(ys,  acc)
			      |  SOME a => aux(ys,   acc @ a)
  in aux(st_list_list, [])
  end

fun similar_names (st_list_list :string list list, full_name :  {first : string, middle : string, last : string}) =
  let  fun first_name {first=x, middle=y, last=z} = x
       fun middle {first=x, middle=y, last=z} = y
       fun last {first=x, middle=y, last=z} = z
       val final = first_name(full_name) :: get_substitutions2(st_list_list, first_name(full_name))
       fun aux (final : string list) =
	 case final of
			 [] => []
			 | x::ys => {first=x,middle=middle(full_name),last=last(full_name)}::aux(ys)
  in aux(final)        
  end


(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

    
fun card_color (crd : card) =
  case crd of
      (Spades,_) => Black
    | (Clubs,_)  => Black
    | (Hearts,_) => Red
    | (Diamonds,_)  => Red

 fun card_value (crd : card) =
  case crd of
      (_,Num i) => i
    | (_, Jack)  => 10
    | (_, Queen) => 10
    | (_, King)  => 10
    | (_, Ace)  => 11


 fun remove_card (cs:card list,c:card,e:exn) =
 let fun aux(cs) =
   case cs of
       [] => []
    |   x::ys => if x=c then ys else x::aux(ys)
 in let val v = aux(cs)
    in if v=cs then raise e else v
    end
 end
  
 fun all_same_color (cs : card list) =
   case cs of
       []=>true
    |  x::[] => true
    |  x::y::ys => if card_color(x)=card_color(y) then all_same_color(y::ys)
		   else false

 fun sum_cards (cs : card list) =
   let fun aux(cs, acc) = case cs of
			 []=> acc
		       | x::ys =>  aux(ys, card_value(x)+acc)
   in aux(cs, 0)
   end
 
 fun score (hl : card list, goal : int) =		
   let val a = sum_cards(hl)-goal
       val prel = if a > 0 then 3*a else 0-a			 
  in  if all_same_color(hl) then prel div 2 else prel
   end
      
 fun officiate (cs : card list, ml : move list, goal : int) =
   let fun turn (hl : card list, cs : card list, ml : move list)=
	 case ml of
	     [] => score(hl, goal)
	   | (Discard c) ::ys => turn(remove_card(hl, c, IllegalMove),cs,ys)
	   | Draw :: ys => case cs of
			       [] => score(hl, goal)
			     | x::[] => score(x::hl, goal)
			     | x::cs => if sum_cards(x::hl)> goal then score(x::hl, goal) else turn (x::hl, cs, ys)  
   in
       turn([],cs, ml)
   end
