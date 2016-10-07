:-dynamic options_per_location/2.
:-dynamic bag/1.
:-dynamic current_location/1.
:-dynamic locked_room/1.


% start location %

current_location(living_room).

% Options per location structure => | location name | location option | %

% Living Room options
options_per_location(living_room, flashlight).
options_per_location(living_room, dinner_room).
options_per_location(living_room, bathroom).
options_per_location(living_room, desk).
options_per_location(living_room, box).
options_per_location(living_room, exit).

% Dinner Room options
options_per_location(dinner_room, living_room).
options_per_location(dinner_room, hall).
options_per_location(dinner_room, kitchen).
options_per_location(dinner_room, carpet).

% Kitchen Options
options_per_location(kitchen, dinner_room).
options_per_location(kitchen, service_room).
options_per_location(kitchen, knife).
options_per_location(kitchen, microwave).

% Service Room Options
options_per_location(service_room, kitchen).
options_per_location(service_room, hall).
options_per_location(service_room, battery).
options_per_location(service_room, washing_machine).

% Hall Options
options_per_location(hall, dinner_room).
options_per_location(hall, service_room).
options_per_location(hall, red_room).
options_per_location(hall, yellow_room).

% Red Room Options
options_per_location(red_room, hall).
options_per_location(red_room, writing_desk).
options_per_location(red_room, bed).
options_per_location(red_room, wardrobe).

% Yellow Room Options
options_per_location(yellow_room, hall).
options_per_location(yellow_room, linen).
options_per_location(yellow_room, jewelry_box).
options_per_location(yellow_room, dump).

% Bathroom Options
options_per_location(bathroom, living_room).
options_per_location(bathroom, medicine_chest).

% Hide
not_moved(desk, towel).
not_moved(carpet, red_key).
not_moved(writing_desk, trash).
not_moved(bed, yellow_key).
not_moved(linen, letter).

% Closed
closed(box, toy).
closed(microwave, cookies_toasted).
closed(washing_machine, fifty_dollars).
closed(jewelry_box, bathroom_key).
closed(wardrobe, hanger).
closed(dump, old_picture).
closed(medicine_chest, main_key).

locations(living_room).
locations(bathroom).
locations(dinner_room).
locations(kitchen).
locations(service_room).
locations(hall).
locations(red_room).
locations(yellow_room).
locations(exit).

objects(flashlight).
objects(red_key).
objects(yellow_key).
objects(bathroom_key).
objects(main_key).
objects(knife).
objects(towel).
objects(toy).
objects(cookies_toasted).
objects(fifty_dollars).
objects(trash).
objects(letter).
objects(hanger).
objects(old_picture).

locked_room(bathroom).
locked_room(red_room).
locked_room(yellow_room).
locked_room(exit).

movable(desk).
movable(carpet).
movable(bed).
movable(writing_desk).
movable(linen).

openable(box).
openable(microwave).
openable(washing_machine).
openable(jewelry_box).
openable(wardrobe).
openable(dump).
openable(medicine_chest).

:-op(500, xfx, opens).

bathroom_key opens bathroom.
red_key opens red_room.
yellow_key opens yellow_room.
main_key opens exit.
