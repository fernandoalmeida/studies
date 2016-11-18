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

val only_capitals = List.filter (fn s=> Char.isUpper(String.sub(s,0)))

val longest_string1 = List.foldl (fn (x, y) => if String.size x > String.size y then x else y) ""

val longest_string2 = List.foldl (fn (x, y) => if String.size x < String.size y then y else x) ""

fun longest_string_helper f slist = List.foldl f "" slist

val longest_string3 = longest_string_helper (fn (x, y) => if String.size x > String.size y then x else y)

val longest_string4 = longest_string_helper (fn (x, y) => if String.size x < String.size y then y else x)

val longest_capitalized = longest_string1 o only_capitals

val rev_string = String.implode o rev o String.explode 

fun first_answer f alist = case List.foldl (fn (x, y) => case y of SOME _ => y
								| NONE => case f x of SOME v => SOME v
										   | NONE => y) NONE alist of SOME v => v
												      | NONE => raise NoAnswer

fun all_answers f alist = List.foldl (fn(x, y) => case y of NONE => NONE 
							| SOME lst => case f x of NONE => NONE 
									     | SOME v => SOME (lst@v)) (SOME []) alist

val count_wildcards = g (fn ()=>1 ) (fn _ => 0)

val count_wild_and_variable_lengths = g (fn ()=>1) (fn x=>String.size(x))

(* more elegrant way?? *)
val count_some_var = (fn (s, pat) => (g (fn () => 0) (fn x=>if x = s then 1 else 0)) pat)

fun patternToList pat = case pat of 
	    Wildcard          => []
	  | Variable x        => [x]
	  | TupleP ps         => (List.foldl (fn (p,i) => patternToList(p) @ i)  [] ps)
	  | ConstructorP(_,p) => patternToList p
	  | _                 => []

(* more elegant way?? *)
fun distincted lst = List.foldl (fn (x, y) => y andalso List.length(List.filter (fn e => e = x) lst)=1) true lst

val check_pat = distincted o patternToList


(* Tuple match should have same num.. *)
fun match (valu, pattern) = case (valu, pattern) of (_, Wildcard) => SOME []
						 | (_, Variable s) => SOME [(s, valu)]
						 | (Unit, UnitP) => SOME []
						 | (Const x, ConstP y) => if x=y then SOME [] else NONE
						 | (Tuple vlist, TupleP plist) => if List.length vlist = List.length plist then all_answers (fn (v, p) => match(v, p)) (ListPair.zip(vlist, plist)) else NONE
						 | (Constructor (s2, v), ConstructorP (s1, p)) => if s1=s2 then match(v, p) else NONE
						 | _ => NONE

fun first_match valu plist = SOME (first_answer (fn p => match(valu, p)) plist) handle NoAnswer => NONE


