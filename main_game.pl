:-dynamic location/1.
:-dynamic options_per_location/2.
:-dynamic bag/1.
:-dynamic current_location/1.

% Initial database listed here %
% Theses values are referent to the location the player start and the current options to choose %

% location: | location name |
% options_per_location | option name |location name |

current_location(living_room).

% Living Room options
options_per_location(flashlight, living_room).
options_per_location(kitchen, living_room).

% Kitchen Options
options_per_location(living_room, kitchen).
options_per_location(dinner_room, kitchen).
options_per_location(knife, kitchen).
options_per_location(key1, kitchen).

locations(kitchen).
locations(dinner_room).
locations(living_room).

objects(flashlight).
objects(key1).
objects(key2).
objects(knife).

start_play :- write('Welcome to <game_name>'), nl,
   write('this is an alpha version, so its still not complete'), nl,
   play.

play :- write('you currently are in the '),
   current_location(Current_location),
   write(Current_location), nl,
   write('and you can: '), nl,
   print_options, nl,
   read(Choosen_option),
   handle_option(Choosen_option),
   play.

print_options :- current_location(Current_location), options_per_location(Option, Current_location), locations(Option),
   write('Go to => '), write(Option), nl, fail. % Como melhorar essa parte? %

print_options :- current_location(Current_location), options_per_location(Option, Current_location), objects(Option),
   write('Grab => '), write(Option), nl, fail.

print_options.

handle_option(Choosen_option) :- locations(Choosen_option), !, retract(current_location(X)), assert(current_location(Choosen_option)).
handle_option(Choosen_option) :- objects(Choosen_option), !, assert(bag(Choosen_option)).
