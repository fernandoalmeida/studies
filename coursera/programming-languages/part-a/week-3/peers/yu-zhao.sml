(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* 1. This problem involves using first-name substitutions to come up with alternate names.
    For example, Fredrick William Smith could also be Fred William Smith or Freddie William Smith.
    Only part (d) is specifically about this, but the other problems are helpful.
  *)
(* (a) Write a function all_except_option, which takes a string and a string list.
    Return NONE if the string is not in the list,
    else return SOME lst where lst is identical to the argument list except the string is not in it.
    You may assume the string is in the list at most once.
    Use same_string, provided to you, to compare strings.
    Sample solution is around 8 lines.
  *)
fun all_except_option (str, lst) =
  let
    fun get_lst(l, exist) =
      case l of
          [] => ([], exist)
        | h::t =>
            if same_string(h, str)
            then (t, true)
            else
              let
                val (tl, ex) = get_lst(t, exist)
              in
                (h::tl, ex)
              end
  in
    case lst of
        [] => NONE
      | _ =>
        let
          val (l, e) = get_lst(lst, false)
        in
          if e
          then SOME l
          else NONE
        end
  end

(* (b) Write a function get_substitutions1, which takes
    a string list list (a list of list of strings, the substitutions) and
    a string s and returns a string list.

    The result has all the strings that are in some list in substitutions that also has s,
    but s itself should not be in the result.

    Example:
     get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred")
     (* answer: ["Fredrick","Freddie","F"] *)

    Assume each list in substitutions has no repeats.
    The result will have repeats if s and another string are both in more than one list in substitutions.

    Example:
     get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff")
     (* answer: ["Jeffrey","Geoff","Jeffrey"] *)

     Use part (a) and ML’s list-append (@) but no other helper functions.
     Sample solution is around 6 lines.
  *)
fun get_substitutions1 (sll, s) =
  case sll of
      [] => []
    | sl::sls =>
      let
        val lst = all_except_option (s, sl)
      in
        case lst of
            NONE => get_substitutions1 (sls, s)
          | a => (valOf a) @ (get_substitutions1 (sls, s))
      end

(* (c) Write a function get_substitutions2,
    which is like get_substitutions1 except it uses a tail-recursive local helper function.
  *)
fun get_substitutions2 (sll, s) =
  let
    fun helper (acc, sls) =
      case sls of
          [] => acc
        | h::t =>
          let
            val l = all_except_option (s, h)
          in
            case l of
                NONE => helper (acc, t)
              | a => helper ((acc @ (valOf a)), t)
          end
  in
    helper([], sll)
  end

(* (d) Write a function similar_names,
    which takes
      a string list list of substitutions (as in parts (b) and (c)) and
      a full name of type {first:string,middle:string,last:string} and
      returns a list of full names (type {first:string,middle:string,last:string} list).

    The result is all the full names you can produce by substituting for the first name (and only the first name)
    using substitutions and parts (b) or (c).

    The answer should begin with the original name (then have 0 or more other names).

    Example:
     similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"})
     (* answer: [{first="Fred", last="Smith", middle="W"},
                 {first="Fredrick", last="Smith", middle="W"},
                 {first="Freddie", last="Smith", middle="W"},
                 {first="F", last="Smith", middle="W"}] *)

    Do not eliminate duplicates from the answer.
    Hint: Use a local helper function. Sample solution is around 10 lines.
  *)
fun similar_names (sll, { first = f ,middle = m ,last = l }) =
  let
    val names = get_substitutions2 (sll, f)
    fun get_name_list (acc, ns) =
      case ns of
          [] => acc
        | h :: t => get_name_list (acc @ [{ first = h, last = l, middle = m }], t)
  in
    get_name_list ([{ first = f ,middle = m ,last = l }], names)
  end


(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove

(* put your solutions for problem 2 here *)

(* 2. This problem involves a solitaire card game invented just for this question.
    You will write a program that tracks the progress of a game;
    writing a game player is a challenge problem.
    You can do parts (a)–(e) before understanding the game if you wish.

    A game is played with a card-list and a goal.
    The player has a list of held-cards, initially empty.
    The player makes a move by either drawing,
      which means removing the first card in the card-list from the card-list and adding it to the held-cards,
    or discarding, which means choosing one of the held-cards to remove.

    The game ends either when the player chooses to make no more moves or
      when the sum of the values of the held-cards is greater than the goal.

    The objective is to end the game with a low score (0 is best).

    Scoring works as follows:
      Let sum be the sum of the values of the held-cards.

      If sum is greater than goal, the preliminary score is three times (sum - goal),
      else the preliminary score is (goal - sum).

      The score is the preliminary score unless all the held-cards are the same color,
      in which case the score is the preliminary score divided by 2
      (and rounded down as usual with integer division; use ML’s div operator).
  *)

(* (a) Write a function card_color,
    which takes a card and returns its color
      (spades and clubs are black, diamonds and hearts are red).

    Note: One case-expression is enough.
  *)
fun card_color (s, r) =
  if s = Clubs orelse s = Spades
  then Black
  else Red

(* (b) Write a function card_value,
    which takes a card and returns its value
      (numbered cards have their number as the value, aces are 11, everything else is 10).

    Note: One case-expression is enough.
  *)
fun card_value (s, r) =
  case r of
      Jack => 10
    | Queen => 10
    | King => 10
    | Ace => 11
    | Num (v) => v

(* (c) Write a function remove_card,
    which takes
      a list of cards cs,
      a card c, and
      an exception e.

    It returns a list that has all the elements of cs except c.
    If c is in the list more than once, remove only the first one.
    If c is not in the list, raise the exception e.

    You can compare cards with =.
  *)
fun remove_card (cs, c, e) =
  let
    fun remove (acc, cl) =
      case cl of
          [] => raise e
        | h :: t =>
            if h = c then acc @ t else remove (acc @ [h], t)
  in
    remove ([], cs)
  end

(* (d) Write a function all_same_color,
    which takes a list of cards and returns true if all the cards in the list are the same color.

    Hint: An elegant solution is very similar to one of the functions using nested pattern-matching in the lectures.
  *)
fun all_same_color (cl) =
  case cl of
      [] => true
    | _ :: [] => true
    | head :: neck :: rest =>
        if not ((card_color head) = (card_color neck))
        then false
        else all_same_color (neck :: rest)

(* (e) Write a function sum_cards,
    which takes a list of cards and returns the sum of their values.
    Use a locally defined helper function that is tail recursive.
    (Take “calls use a constant amount of stack space” as a requirement for this problem.)
  *)
fun sum_cards (cl) =
  let
    fun sum (acc, l) =
      case l of
          [] => acc
        | h::t => sum ((acc + (card_value h)), t)
  in
    sum (0, cl)
  end

(* (f) Write a function score,
    which takes a card list (the held-cards) and
    an int (the goal) and computes the score as described above.
  *)
fun score (hcs, goal) =
  let
    val sum = sum_cards hcs;
    val smg = sum - goal;
    val gms = goal - sum;
    val preliminary = if sum > goal then smg * 3 else gms;
  in
    if all_same_color hcs
    then preliminary div 2
    else preliminary
  end

(* (g) Write a function officiate, which “runs a game.”
    It takes
      a card list (the card-list)
      a move list (what the player “does” at each point), and
      an int (the goal) and

      returns the score at the end of the game after processing (some or all of) the moves in the move list in order.

    Use a locally defined recursive helper function that takes several arguments that together represent the current state of the game.

    As described above:
      • The game starts with the held-cards being the empty list.
      • The game ends if there are no more moves. (The player chose to stop since the move list is empty.)
      • If the player discards some card c, play continues
        (i.e., make a recursive call) with the held-cards not having c and
        the card-list unchanged.
        If c is not in the held-cards, raise the IllegalMove exception.
      • If the player draws and the card-list is (already) empty, the game is over.
        Else if drawing causes the sum of the held-cards to exceed the goal, the game is over (after drawing).
        Else play continues with a larger held-cards and a smaller card-list.

    Sample solution for (g) is under 20 lines.
  *)
fun officiate (cl, ml, goal) =
  let
    fun play (card_list, move_list, held_cards, s) =
      case move_list of
          [] => s
        | move_list_h :: move_list_t =>
            case move_list_h of
                Discard (card) =>
                  let
                    val new_held_cards = remove_card (held_cards, card, IllegalMove)
                    val new_score = score (new_held_cards, goal)
                  in
                    play (card_list, move_list_t, new_held_cards, new_score)
                  end
              | Draw =>
                  case card_list of
                      [] => s
                    | card_list_h :: card_list_t =>
                      let
                        val new_sum = sum_cards (card_list_h :: held_cards)
                        val new_score = score (card_list_h :: held_cards, goal)
                      in
                        if new_sum > goal then score (card_list_h :: held_cards, goal) else play (card_list_t, move_list_t, card_list_h :: held_cards, new_score)
                      end
  in
    play (cl, ml, [], score([], goal))
  end
