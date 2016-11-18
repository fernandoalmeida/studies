(* Dan Grossman, CSE341 Winter 2013, HW3 Provided Code *)

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

          (* to help calculate pattern type points, f1 is for wildcard, f2 is
          * for variable *)
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
val only_capitals = List.filter (fn s => Char.isUpper(String.sub (s, 0)) )
val longest_string1 = List.foldl (fn (a, b) => if (String.size b) >= (String.size a) then b else a) "";
val longest_string2 = List.foldl (fn (a, b) => if (String.size b) > (String.size a) then b else a) "";

fun longest_string_helper pre initial_string string_list =
  case string_list of
       [] => initial_string
     | x::rest => if pre (String.size x, String.size initial_string)
                  then longest_string_helper pre x rest
                  else longest_string_helper pre initial_string rest

val longest_string3 = longest_string_helper (fn (a, b) => a>b) ""
val longest_string4 = longest_string_helper (fn (a, b) => a>=b) ""

val longest_capitalized = longest_string3 o only_capitals

val rev_string = String.implode o List.rev o String.explode

fun first_answer f a_list =
  case a_list of
       [] => raise NoAnswer
     | a::al2 => case (f a) of
                      NONE => first_answer f al2
                    | SOME v => v

fun all_answers f a_list =
let
  fun helper (a_list, accu) =
    case a_list of
         [] => SOME []
       | a::al2 => case f a of
                        NONE => NONE
                      | SOME bl =>
                          let
                            val new_accu = case accu of
                                                NONE => bl
                                              | SOME bl1 => bl1 @ bl
                          in
                            helper (al2, SOME new_accu )
                          end
in
    helper(a_list, NONE)
end

fun count_wildcards p = g (fn(e) => 1) (fn(e) => 0) p

fun count_wild_and_variable_lengths p = (g (fn(e) => 1) (fn(e) => 0) p) + (g
  (fn(e) => 0) (fn(e) => String.size e) p)

fun count_some_var (str, p) = g (fn(e) => 0) (fn(e) => if str = e then 1 else 0)
  p

fun check_pat p =
let fun generate_variable_string_list (p) =
	case p of
	    Variable x        => [x]
	  | TupleP ps         => List.foldl (fn (p, accu) => accu @
      generate_variable_string_list(p)) [] ps
	 | ConstructorP (s, cp) => generate_variable_string_list(cp)
	  | _                 => []
    fun is_duplicate (string_list: string list) =
      case string_list of
           [] => false
         | s:: sl2 => List.exists (fn (e) => (s=e)) sl2 orelse is_duplicate (sl2)
in
  not (is_duplicate(generate_variable_string_list(p)))
end

fun match (valu, pattern) =
  case pattern of
       Wildcard => SOME []
     | UnitP => (case valu of
                     Unit => SOME []
                   | _ => NONE)
     | ConstP i => (case valu of
                     Const v => if (i = v) then SOME [] else NONE
                   | _ => NONE)
     | Variable s => SOME [(s, valu)]
     | ConstructorP (s1, p) => (case valu of
                     Constructor (s2, v) => if (s1 = s2) then match (v, p) else NONE
                   | _ => NONE)
     | TupleP ps => case valu of
                         Tuple vs => if (List.length ps = List.length vs) then
                           all_answers match (ListPair.zip (vs, ps)) else NONE
                       | _ => NONE

fun first_match valu p_list =
  SOME (first_answer (fn (p) => match (valu, p)) p_list) handle NoAnswer => NONE

fun typecheck_patterns (datatype_constructor_list, p_list) =
let
  fun extract_value_from_option_list (option_list) =
    case option_list of
         [] => SOME []
       | h::rest => case h of
                         NONE => NONE
                       | SOME value =>
                           let val rest_list_option =
                           extract_value_from_option_list(rest)
                           in
                             case rest_list_option of
                                  NONE => NONE
                                | SOME rest_list => SOME (value::rest_list)
                           end

  fun generate_lenient_type(type_pair) =
  let
    fun type_pair_list_check (type_pair_list) =
      case type_pair_list of
           [] => SOME []
         | pair::rest_pairs =>
             let val result = generate_lenient_type(pair)
             in
               case result of
                    NONE => NONE
                  | SOME t => let val rest_result = type_pair_list_check (rest_pairs)
                              in
                                case rest_result of
                                     NONE => NONE
                                   | SOME l => SOME (t::l)
                              end

             end
  in
    case type_pair of
         (Anything,t2) => SOME t2
       | (t1, Anything) => SOME t1
       | (UnitT, UnitT) => SOME UnitT
       | (IntT, IntT) => SOME IntT
       | (Datatype name1, Datatype name2) => if name1 = name2 then SOME (Datatype name1) else NONE
       | (TupleT type_list1, TupleT type_list2) => (if (List.length type_list1) <>
         (List.length type_list2) then NONE else
           let val result = type_pair_list_check (ListPair.zip (type_list1, type_list2))
           in
           case result of
                NONE => NONE
              | SOME type_list => SOME (TupleT type_list)
           end
           )
       | _ => NONE
  end


  fun pattern_to_type datatype_constructor_list p =

    case p of
           Wildcard => SOME Anything
         | UnitP => SOME UnitT
         | ConstP i => SOME IntT
         | Variable s => SOME Anything
         | ConstructorP (s1, cp) =>
             let
               val construct = List.find (fn (constructor_name, _, _) =>
               constructor_name = s1) datatype_constructor_list
             in
               case construct of
                    NONE => NONE
                  | SOME (constructor_name, datetype_name, argument_type) =>
                      let
                        val converted_type_option = pattern_to_type datatype_constructor_list cp
                      in
                        case converted_type_option of
                             NONE => NONE
                           | SOME converted_type =>
                               let val lenient_result =
                               generate_lenient_type(argument_type, converted_type)
                               in
                                 case lenient_result of
                                      NONE => NONE
                                    | SOME lenient_type => SOME (Datatype datetype_name)
                               end

                      end
             end
         | TupleP ps =>
             let
               val types_option = extract_value_from_option_list(List.map (pattern_to_type
               datatype_constructor_list) ps)
             in
               case types_option of
                    NONE => NONE
                  | SOME types => SOME(TupleT types)
             end

in
  case p_list of
       [] => NONE
     | _ => List.foldl (fn (current, last_value) =>
         case last_value of
              NONE => NONE
            | SOME before_type =>
                let
                  val current_type_option = pattern_to_type datatype_constructor_list current
                in
                  case current_type_option of
                       NONE => NONE
                     | SOME current_type => generate_lenient_type(before_type, current_type)
                end
         )
         (SOME Anything) p_list
end
