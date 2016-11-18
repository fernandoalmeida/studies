(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

fun only_capitals(words) = List.filter (fn word => Char.isUpper(String.sub(word, 0))) words

fun longest_string1(words) = List.foldl (fn (x1, x2) => if (String.size(x1) > String.size(x2)) then x1 else x2) "" words

fun longest_string2(words) = List.foldl (fn (x1, x2) => if (String.size(x1) >= String.size(x2)) then x1 else x2) "" words

fun longest_string_helper f words = List.foldl (fn (word1, word2) => if f(word1, word2) then word1 else word2) "" words 

val longest_string3 = longest_string_helper (fn (x1, x2) => String.size(x1) > String.size(x2))

val longest_string4 = longest_string_helper (fn (x1, x2) => String.size(x1) >= String.size(x2))

val longest_capitalized = longest_string1 o only_capitals

val rev_string = String.implode o List.rev o String.explode

fun first_answer f words = case List.filter(fn x => case x of NONE => false | _ => true) (List.map (fn x => f(x)) words) of
				[] => raise NoAnswer
				| SOME(x) :: xs => x

fun all_answers f words = List.foldl (fn (x1, x2) => case x1 of NONE => NONE
						     | SOME(list1) => (case x2 of NONE => NONE
				            			      | SOME(list2) => SOME(list2 @ list1))) 
				(SOME []) (List.map (fn x => f(x)) words)
fun count_wildcards(pattern) = g (fn ()=> 1) (fn p2 => 0) pattern
fun count_wild_and_variable_lengths(pattern) = g (fn ()=> 1) (fn (p2) =>  String.size(p2)) pattern
fun count_some_var(word, pattern) = g (fn () => 0) (fn p2 => if word = p2 then 1 else 0) pattern

fun check_pat(pattern) = 
    	let
		fun find_variables(curr_pattern) = 
		        case curr_pattern of
		          Variable x        => [x]
		          | TupleP ps         => List.foldl (fn (x1, x2) => (find_variables x1 @ x2)) [] ps
		          | ConstructorP(_,p) => find_variables p
		          | _                 => [] 
     	in
		let 
			val variables = find_variables(pattern)
		in
			if List.null variables then true else List.exists (fn(x) => (List.foldl(fn (x1, x2) => if x1 = x then x2 + 1 else x2) 0 variables) = 1) variables
		end
	end

fun match(valu, pattern) = case pattern of
				Wildcard => SOME []
				| UnitP => (case valu of
						Unit => SOME []
						| _ => NONE)
				| ConstP(x) => (case valu of
						Const(xi) => if x = xi then SOME [] else NONE
						| _ => NONE)
				| ConstructorP((name, pattern)) => (case valu of
									Constructor((v_name, v_valu)) => if name = v_name then match(v_valu, pattern) else NONE
									| _ => NONE)
				| Variable(name) => SOME[(name, valu)]
				| TupleP(patterns_list) => (case valu of
								Tuple(valu_list) => all_answers (fn (in_valu, in_pattern)=> match(in_valu, in_pattern)) (ListPair.zipEq(valu_list, patterns_list))
								| _ => NONE)
				handle _ => NONE

fun first_match value patterns = SOME (first_answer (fn(in_pattern)=> match(value, in_pattern)) patterns)
					handle NoAnswer => NONE
