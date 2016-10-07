:-dynamic options_per_location/2.
:-dynamic bag/1.
:-dynamic current_location/1.
:-dynamic locked_room/1.

:-op(500, xfx, opens).

start :- write('Welcome to <game_name>'), nl,
   write("it's an alpha version, so it's still not complete"), nl,
   consult(house), 
   play.

play :- nl, not(current_location(exit)), write('You are currently in the '),
   current_location(Current_location),
   write(Current_location), nl,
   write('and you can: '), nl,
   print_options, nl,
   read(Choosen_option),
   handle_option(Choosen_option),
   play.

play :- current_location(exit), nl, write('You have exit the house!'), nl, write('You Win!'), nl,
   write('Play again?'), nl, write('yes/no'), nl,
   read(Play_again),
   reset_game(Play_again).

print_options :- current_location(Current_location), options_per_location(Current_location, Option), locations(Option),
   tab(4), write('Go to => '), write(Option), nl, fail. % Como melhorar essa parte? %

print_options :- current_location(Current_location), options_per_location(Current_location, Option), objects(Option),
   tab(4), write('Grab => '), write(Option), nl, fail.
print_options :- tab(4), write('See itens on bag => bag').

print_options.

handle_option(Choosen_option) :- locations(Choosen_option), not(locked_room(Choosen_option)), !,
   retract(current_location(X)), assert(current_location(Choosen_option)).

handle_option(Choosen_option) :- locations(Choosen_option), locked_room(Choosen_option), have_key(Choosen_option), !,
   nl, write('You opened the door to '), write(Choosen_option), write('!'), nl.

handle_option(Choosen_option) :- locations(Choosen_option), locked_room(Choosen_option), not(have_key(Choosen_option)), !,
   nl, write('That door is locked!'), nl, write('You need the right key.'), nl.

handle_option(Choosen_option) :- objects(Choosen_option), current_location(X), options_per_location(X, Choosen_option), !,
   retract(options_per_location(X, Choosen_option)), assert(bag(Choosen_option)), print_object_taken_message(Choosen_option).

handle_option(bag) :- print_bag.

% if it's an invalid option %

handle_option(Choosen_option) :- nl, write(Choosen_option), write(' is not an option.'), nl, write('please choose a valid option on the menu'), nl,
   write("To choose an option you must write the name after the '=>' symbol"), nl, nl, play.

print_object_taken_message(Object_taken) :- nl, write(' You now have: '), write(Object_taken), nl, nl.

print_bag :- bag(X), !, nl, write('The currents items on your bag are: '), print_item_bag.
print_bag :- not(bag(X)), print_empty_bag.
print_bag.

print_item_bag :- nl, bag(Item), tab(4), write('* '), write(Item), nl, fail.
print_item_bag.

print_empty_bag :- nl, write('Your bag is currently empty.'), nl.

have_key(Location) :- bag(X), X opens Location, !, retract(bag(X)), retract(locked_room(Location)).

reset_game(yes) :- retractall(bag(Items)), retractall(options_per_location(Locations,Options)), retractall(current_location(Current)), 
   retractall(locked_room(Locked)), start.

reset_game(no) :- retractall(bag(Items)), retractall(options_per_location(Locations,Options)), retractall(current_location(Current)), 
   retractall(locked_room(Locked)), write('Thanks for playing'), nl, write('Good Bye!').
