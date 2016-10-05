:-dynamic location/1.
:-dynamic options_per_location/2.
:-dynamic bag/1.
:-dynamic current_location/1.

% Initial database listed here %
% Theses values are referent to the location the player start and the current options to choose %

% location ( location name )
% options_per_location ( location name, option name )

current_location(living_room).

% Living Room options
options_per_location(living_room, flashlight).
options_per_location(living_room, kitchen).

% Kitchen Options
options_per_location(kitchen, living_room).
options_per_location(kitchen, dinner_room).
options_per_location(kitchen, knife).
options_per_location(kitchen, key1).

locations(kitchen).
locations(dinner_room).
locations(living_room).

objects(flashlight).
objects(key1).
objects(key2).
objects(knife).

start :- write('Welcome to <game_name>'), nl,
   write("it's an alpha version, so it's still not complete"), nl,
   play.

play :- nl, write('You are currently in the '),
   current_location(Current_location),
   write(Current_location), nl,
   write('and you can: '), nl,
   print_options, nl,
   read(Choosen_option),
   handle_option(Choosen_option),
   play.

print_options :- current_location(Current_location), options_per_location(Current_location, Option), locations(Option),
   tab(4), write('Go to => '), write(Option), nl, fail. % Como melhorar essa parte? %

print_options :- current_location(Current_location), options_per_location(Current_location, Option), objects(Option),
   tab(4), write('Grab => '), write(Option), nl, fail.
print_options :- tab(4), write('See itens on bag => bag').

print_options.

handle_option(Choosen_option) :- locations(Choosen_option), !, retract(current_location(X)), assert(current_location(Choosen_option)).
handle_option(Choosen_option) :- objects(Choosen_option), !, current_location(X), retract(options_per_location(X, Choosen_option)), assert(bag(Choosen_option)).
handle_option(bag) :- print_bag.

print_bag :- bag(X), !, nl, write('The currents items on your bag are: '), print_item_bag.
print_bag :- not(bag(X)), print_empty_bag.
print_bag.

print_item_bag :- nl, bag(Item), tab(4), write('* '), write(Item), nl, fail.
print_item_bag.

print_empty_bag :- nl, write('Your bag is currently empty.'), nl.
