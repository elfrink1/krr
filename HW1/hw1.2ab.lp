% PROBLEM INPUT

% You are given a network of roads:
% A collection of intersections and a collection of roads that are each between two intersections.

#const num_nodes=10.
num_nodes(1..num_nodes).

#const num_roads=10.
road_id(1..num_roads).
1 { road(Road_id, A, B) : road_id(Road_id), node(B), not road(_, B, A), not road(_, A, B), A != B } num_roads :- node(A).
1 { road(Road_id, A, B) : node(A), node(B), A != B, not road(_, A, B), not road(_, B, A) } 1 :- road_id(Road_id).

% Some roads are one-way, and some roads are two-way (this is specified in the problem input).
road(Road_id, B, A) :- road(Road_id, A, B), two_way(Road_id).


% In addition, you are given a subset of roads that need to be repaired (repair requests). 
#const num_repairs=5.
repair_id(1..num_repairs).
1 { repair(Rep_id, Road_id) : road_id(Road_id) } 1 :- repair_id(Rep_id).
{ repair(Rep_id, A, B) : repair_id(Rep_id) } 1 :- road(Road_id, A, B).

% - How long this repair takes (e.g., a number of days). The repair should happen on subsequent days.
%%  (Repairs always take a multiple of complete days—in other words, 
%  the granularity of time for this problem is days.)
possible_repair_times(1..num_repairs).
1 {repair_time(Rep_id, Num_days) : possible_repair_times(Num_days)} 1:- repair_id(Rep_id).

% You are also given a collection of which repair equipment is available (e.g., 2 trucks and 1 drill).
% - What tools are needed for this repair (e.g., 1 truck and 1 drill).
#const num_trucks=1.
#const num_drills=2.
#const num_hammers=3.
choice_num_trucks(1..num_trucks).
choice_num_drills(1..num_drills).
choice_num_hammers(1..num_hammers).

1 {repair_trucks(Rep_id, Num_trucks) : choice_num_trucks(Num_trucks)} 1:- repair_id(Rep_id).
1 {repair_drills(Rep_id, Num_drills) : choice_num_drills(Num_drills)} 1:- repair_id(Rep_id).
1 {repair_hammers(Rep_id, Num_hammers) : choice_num_hammers(Num_hammers)} 1:- repair_id(Rep_id).



% -------------------------------------------------------------------------------
% PROBLEM ENCODING
% The task is to find a schedule for the repairs—i.e., 
% which repairs should happen on which (subsequent) days—such that:

% - each repair is assigned to the right amount of subsequent days,
% repair_on_day(repair_id, day).
#const num_possible_days=5*num_nodes.
possible_day(1..num_possible_days).

Num_days { repair_on_day(Rep_id, D) : possible_day(D) } Num_days :- repair(Rep_id, Road_id) , repair_time(Rep_id, Num_days).
day(D) :- repair_on_day(Rep_id, D).
:- day(D), repair_on_day(Rep_id, D), repair_on_day(Rep_id, D+2), not repair_on_day(Rep_id, D+1).

% - for each day, the total amount of tools needed (for each type of tool) for the repairs
%  scheduled on that day is less than or equal to the total amount of tools available (of that type),
:- day(D),  Sum = #sum { Num_trucks : repair_trucks(Rep_id, Num_trucks), repair_on_day(Rep_id, D) }, Sum > num_trucks.
:- day(D),  Sum = #sum { Num_drills : repair_drills(Rep_id, Num_drills),  repair_on_day(Rep_id, D) }, Sum > num_drills.
:- day(D),  Sum = #sum { Num_hammers : repair_hammers(Rep_id, Num_hammers), repair_on_day(Rep_id, D) }, Sum > num_hammers.

% - the overall amount of days after which all repairs are done is minimal.

#minimize {1 : day(D)}.

