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

fun only_capitals xs =
  List.filter (fn x => Char.isUpper(String.sub(x, 0))) xs

fun longest_string1 xs =
  foldl (fn (x, l) => if String.size x > String.size l then x else l) "" xs

fun longest_string2 xs =
  foldl (fn (x, l) => if String.size x >= String.size l then x else l) "" xs

fun longest_string_helper f xs =
  foldl (fn (x, l) => if f (String.size(x), String.size(l)) then x else l) "" xs

val longest_string3 = fn xs => longest_string_helper (fn (x, y) => x > y) xs

val longest_string4 = fn xs => longest_string_helper (fn (x, y) => x >= y) xs

val longest_capitalized = longest_string1 o only_capitals

val rev_string = implode o List.rev o explode

fun first_answer f xs =
  case List.find (fn x => isSome(f x)) xs of
      SOME x => x
    | NONE => raise NoAnswer

fun all_answers f xs =
  let fun aux (x, acc) =
	case f x of
            SOME lst1 => (case acc of
                              SOME lst2 => SOME(lst2 @ lst1)
                            | NONE => NONE)
	  | NONE => NONE
  in
      foldl aux (SOME []) xs
  end

fun count_wildcards p = g (fn () => 1) (fn x => 0) p

fun count_wild_and_variable_lengths p = g (fn () => 1) String.size p

fun count_some_var (s, p) = g (fn () => 0) (fn s2 => if s = s2 then 1 else 0) p

fun check_pat p =
  let fun select p =
	case p of
            Variable x         => [x]
	  | TupleP ps          => foldl (fn (p, acc) => (select p) @ acc) [] ps
	  | ConstructorP(_, p) => select p
	  | _                  => []

      fun uniq xs =
	not(List.exists (fn x => length(List.filter (fn y => x = y) xs) > 1) xs)
  in
      uniq (select p)
  end

fun match (v, p) =
    case (v, p) of
        (_, Wildcard) => SOME []
      | (x, Variable s) => SOME [(s, x)]
      | (Unit, UnitP) => SOME []
      | (Const i, ConstP j) => if i = j then SOME [] else NONE
      | (Tuple vs, TupleP ps) => if List.length vs = List.length ps
                                 then all_answers match (ListPair.zip(vs, ps))
                                 else NONE
      | (Constructor(s2, v), ConstructorP(s1, p)) => if s1 = s2
                                                     then match(v, p)
                                                     else NONE
      | (_, _) => NONE

fun first_match v ps =
    SOME (first_answer (fn p => match(v, p)) ps) handle NoAnswer => NONE
