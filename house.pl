% start location %

current_location(living_room).

% Options per location structure => | location name | location option | %

% Living Room options
options_per_location(living_room, flashlight).
options_per_location(living_room, dinner_room).
options_per_location(living_room, bathroom).
options_per_location(living_room, exit).

% Dinner Room options
options_per_location(dinner_room, living_room).
options_per_location(dinner_room, hall).
options_per_location(dinner_room, kitchen).
options_per_location(dinner_room, red_key).

% Kitchen Options
options_per_location(kitchen, dinner_room).
options_per_location(kitchen, service_room).
options_per_location(kitchen, knife).

% Service Room Options
options_per_location(service_room, kitchen).
options_per_location(service_room, hall).
options_per_location(service_room, battery).

% Hall Options
options_per_location(hall, dinner_room).
options_per_location(hall, service_room).
options_per_location(hall, room_01).
options_per_location(hall, room_02).

% Room 01 Options
options_per_location(room_01, hall).
options_per_location(room_01, yellow_key).

% Room 02 Options
options_per_location(room_02, hall).
options_per_location(room_02, brown_key).

% Bathroom Options
options_per_location(bathroom, living_room).
options_per_location(bathroom, main_key).

locations(living_room).
locations(bathroom).
locations(dinner_room).
locations(kitchen).
locations(service_room).
locations(hall).
locations(room_01).
locations(room_02).
locations(exit).

objects(flashlight).
objects(red_key).
objects(yellow_key).
objects(brown_key).
objects(main_key).
objects(knife).

locked_room(bathroom).
locked_room(room_01).
locked_room(room_02).
locked_room(exit).
