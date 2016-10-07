:-dynamic options_per_location/2.
:-dynamic bag/1.
:-dynamic current_location/1.
:-dynamic locked_room/1.
:-dynamic not_moved/2.
:-dynamic closed/2.
:-multifile user:message_property/2.

:-op(500, xfx, opens).

% ansi_format([bold,fg(black)], 'black~w', [world]), nl,
% ansi_format([bold,fg(red)], 'red~w', [world]), nl,
% ansi_format([bold,fg(green)], 'green~w', [world]), nl,
% ansi_format([bold,fg(yellow)], 'yellow~w', [world]), nl,
% ansi_format([bold,fg(blue)], 'blue~w', [world]), nl,
% ansi_format([bold,fg(magenta)], 'magenta~w', [world]), nl,
% ansi_format([bold,fg(cyan)], 'cyan~w', [world]), nl,
% ansi_format([bold,fg(white)], 'white~w', [world]), nl,

start :- cls, write('Welcome to '), ansi_format([bold,fg(magenta)], 'No Wa~w', [y]), write(': The Game!'), nl,
   ansi_format([bold,fg(red)], 'Escape if you ca~w', [n]), nl,
   consult(house),
   play.

play :- nl, not(current_location(exit)),
   print_bag, nl,
   write('You are currently in the '),
   current_location(Current_location),
	 ansi_format([bold,fg(green)], '~w', [Current_location]), nl,
	 write('and you can: '), nl,
   print_options, nl,
   read(Choosen_option),
	 cls,
   handle_option(Choosen_option),
   play.

play :- current_location(exit), nl, write('You have exit the house!'), nl, write('You Win!'), nl,
   write('Play again?'), nl, write('yes/no'), nl,
   read(Play_again),
   reset_game(Play_again).

print_options :- current_location(Current_location), options_per_location(Current_location, Option), locations(Option),
   tab(4), write('Go to => '), ansi_format([bold,fg(yellow)], '~w', [Option]), nl, fail.

print_options :- current_location(Current_location), options_per_location(Current_location, Option), objects(Option),
   tab(4), write('Grab => '), ansi_format([bold,fg(blue)], '~w', [Option]), nl, fail.

print_options :- current_location(Current_location), options_per_location(Current_location, Option), movable(Option),
   tab(4), write('Move => '), ansi_format([bold,fg(cyan)], '~w', [Option]), nl, fail.

print_options :- current_location(Current_location), options_per_location(Current_location, Option), openable(Option),
   tab(4), write('Open => '), ansi_format([bold,fg(magenta)], '~w', [Option]), nl, fail.

print_options.

handle_option(Choosen_option) :- current_location(Current_location), options_per_location(Current_location, Choosen_option),
locations(Choosen_option), not(locked_room(Choosen_option)), !, retract(current_location(X)), assert(current_location(Choosen_option)).

handle_option(Choosen_option) :- current_location(Current_location), options_per_location(Current_location, Choosen_option), locations(Choosen_option),
 locked_room(Choosen_option), have_key(Choosen_option), !, nl, ansi_format([bold,fg(green)], 'You opened the door to ~w',
	[Choosen_option]), write('!'), nl, handle_option(Choosen_option).

handle_option(Choosen_option) :- current_location(Current_location), options_per_location(Current_location, Choosen_option), movable(Choosen_option), current_location(Current_location), not_moved(Choosen_option, Y), !,
   assert(options_per_location(Current_location, Y)), retract(not_moved(Choosen_option, Y)), retract(options_per_location(X, Choosen_option)).

handle_option(Choosen_option) :- current_location(Current_location), options_per_location(Current_location, Choosen_option), openable(Choosen_option), current_location(Current_location), closed(Choosen_option, Y), !,
   assert(options_per_location(Current_location, Y)), retract(closed(Choosen_option, Y)), retract(options_per_location(X, Choosen_option)).

handle_option(Choosen_option) :- current_location(Current_location), options_per_location(Current_location, Choosen_option), locations(Choosen_option), locked_room(Choosen_option), not(have_key(Choosen_option)), !,
   nl, ansi_format([bold,fg(red)], 'That door is ~w', [locked]), nl, ansi_format([bold,fg(red)], 'You need the right ~w', [key]), nl.

handle_option(Choosen_option) :- current_location(Current_location), options_per_location(Current_location, Choosen_option), objects(Choosen_option), !,
   retract(options_per_location(Current_location, Choosen_option)), assert(bag(Choosen_option)), print_object_taken_message(Choosen_option).

handle_option(bag) :- print_bag.

% if it is an invalid option %

handle_option(Choosen_option) :- nl, write(Choosen_option), write(' is not an option.'), nl, write('please choose a valid option on the menu'), nl,
   write("To choose an option you must write the name after the '=>' symbol"), nl, nl, play.

print_object_taken_message(Object_taken) :- nl, ansi_format([bold,fg(green)], 'You now have: ~w', [Object_taken]), nl, nl.

print_bag :- bag(X), !, nl, write('The currents items on your bag are: '), print_item_bag.
print_bag :- not(bag(X)), print_empty_bag.
print_bag.

print_item_bag :- nl, bag(Item), tab(4), write('* '), ansi_format([bold,fg(white)], '~w', [Item]), nl, fail.
print_item_bag.

print_empty_bag :- nl, ansi_format([bold,fg(white)], 'Your bag is currently ~w', [empty]), nl.

have_key(Location) :- bag(X), X opens Location, !, retract(bag(X)), retract(locked_room(Location)).

reset_game(yes) :- retractall(bag(Items)), retractall(options_per_location(Locations,Options)), retractall(current_location(Current)),
   retractall(locked_room(Locked)), start.

reset_game(no) :- retractall(bag(Items)), retractall(options_per_location(Locations,Options)), retractall(current_location(Current)),
   retractall(locked_room(Locked)), write('Thanks for playing'), nl, write('Good Bye!').

cls :- write('\e[2J').
