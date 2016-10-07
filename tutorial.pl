:-dynamic options_per_location/2.
:-dynamic bag/1.
:-dynamic current_location/1.
:-dynamic locked_room/1.

% start location %

current_location(living_room).

% Options per location structure => | location name | location option | %

% Living Room options
options_per_location(living_room, dinner_room).
options_per_location(living_room, box).
options_per_location(living_room, exit).

% Dinner Room options
options_per_location(dinner_room, living_room).
options_per_location(dinner_room, carpet).

% Hide
not_moved(carpet, main_key).

% Closed
closed(box, toy).

locations(living_room).
locations(dinner_room).
locations(exit).

objects(main_key).
objects(toy).

locked_room(exit).

movable(carpet).

openable(box).

:-op(500, xfx, opens).

main_key opens exit.
