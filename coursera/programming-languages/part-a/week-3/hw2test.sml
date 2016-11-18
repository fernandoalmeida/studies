(* thanks to gbaptista for the test cases :) *)

use "hw2.sml";

(* problem 1 *)

val test1 = all_except_option ("string", ["string"]) = SOME [];
val test1b = all_except_option ("Gui", ["Rob", "Gui", "Al"]) = SOME ["Rob", "Al"];
val test1c = all_except_option ("Gui", ["Rob", "Alb"]) = NONE;

val test2 = get_substitutions1 ([["foo"],["there"]], "foo") = [];
val test2b = get_substitutions1 ([["foo","lorem"],["there"]], "lorem") = ["foo"];
val test2c = get_substitutions1 ([["a", "b", "c"], ["d", "e"], ["f", "b"]], "b") = ["a", "c", "f"];

val test3 = get_substitutions2 ([["foo"],["there"]], "foo") = [];
val test3b = get_substitutions2 ([["foo","lorem"],["there"]], "lorem") = ["foo"];
val test3c = get_substitutions2 ([["a", "b", "c"], ["d", "e"], ["f", "b"]], "b") = ["a", "c", "f"];

val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}];

(* problem 2 *)

val test5 = card_color (Clubs, Num 2) = Black;
val test5b = card_color (Hearts, Num 2) = Red;

val test6 = card_value (Clubs, Num 2) = 2;
val test6b = card_value (Clubs, Ace) = 11;
val test6c = card_value (Clubs, King) = 10;

val test7 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = [];
val test7b = remove_card ([(Hearts, Ace), (Clubs, King)], (Hearts, Ace), IllegalMove) = [(Clubs, King)];
val test7c = remove_card ([(Hearts, Ace), (Clubs, King), (Hearts, Ace)], (Hearts, Ace), IllegalMove) = [(Clubs, King), (Hearts, Ace)];
val test7d = (remove_card ([(Hearts, Ace), (Clubs, King), (Hearts, Ace)], (Spades, Queen), IllegalMove) = []) handle IllegalMove => true

val test8 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true
val test8b = all_same_color [(Hearts, Ace), (Hearts, Ace), (Clubs, King)] = false

val test91 = sum_cards [] = 0;
val test92 = sum_cards [(Clubs, Ace)] = 11;
val test93 = sum_cards [(Diamonds, Jack), (Hearts, Queen), (Spades, King)] = 30;
val test94 = sum_cards [(Diamonds, Jack), (Hearts, Num 5)] = 15;
val test95 = sum_cards [(Clubs, Num 2),(Hearts, Num 3)] = 5;

val test10 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4;

val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test12 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false)
              handle IllegalMove => true)
