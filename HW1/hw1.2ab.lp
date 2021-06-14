% PROBLEM INPUT

% You are given a network of roads:
% A collection of intersections and a collection of roads that are each between two intersections.

#const num_nodes=10.
node(1..num_nodes).

#const num_roads=12.
road_id(1..num_roads).

1 { road(Road_id, A, B) : road_id(Road_id), node(B), A != B} num_roads :- node(A).
1 { road(Road_id, A, B) : node(A), node(B), A != B} 1 :- road_id(Road_id).


% Some roads are one-way, and some roads are two-way (this is specified in the problem input).
% road(Road_id, B, A) :- road(Road_id, A, B), two_way(Road_id).


% In addition, you are given a subset of roads that need to be repaired (repair requests). 
#const num_repairs=5.
repair_id(1..num_repairs).
1 { repair(Rep_id, Road_id) : road_id(Road_id) } 1 :- repair_id(Rep_id).
{ repair(Rep_id, Road_id) : repair_id(Rep_id) } 1 :- road(Road_id, A, B).

% - How long this repair takes (e.g., a number of days). The repair should happen on subsequent days.
%%  (Repairs always take a multiple of complete days—in other words, 
%  the granularity of time for this problem is days.)
#const max_time=5.
possible_repair_times(1..max_time).
1 { repair_time(Rep_id, Num_days) : possible_repair_times(Num_days) } 1 :- repair_id(Rep_id).
1 { repair_time(Rep_id, Num_days) : repair_id(Rep_id) } 1 :- possible_repair_times(Num_days).
% You are also given a collection of which repair equipment is available (e.g., 2 trucks and 1 drill).
% - What tools are needed for this repair (e.g., 1 truck and 1 drill).
#const num_trucks=3.
#const num_drills=2.
#const num_hammers=1.
choice_num_trucks(0..num_trucks).
choice_num_drills(0..num_drills).
choice_num_hammers(0..num_hammers).

1 {repair_trucks(Rep_id, Num_trucks) : choice_num_trucks(Num_trucks)} 1 :- repair_id(Rep_id).
1 {repair_drills(Rep_id, Num_drills) : choice_num_drills(Num_drills)} 1 :- repair_id(Rep_id).
1 {repair_hammers(Rep_id, Num_hammers) : choice_num_hammers(Num_hammers)} 1 :- repair_id(Rep_id).
:- repair_id(Rep_id), repair_trucks(Rep_id, 0), repair_drills(Rep_id, 0), repair_hammers(Rep_id, 0).


% -------------------------------------------------------------------------------
% PROBLEM ENCODING
% The task is to find a schedule for the repairs—i.e., 
% which repairs should happen on which (subsequent) days—such that:
% - each repair is assigned to the right amount of subsequent days,
#const possible_days=5*num_nodes.
day(1..possible_days).

Num_days { repair_on_day(Rep_id, D) : day(D) } Num_days :- repair_id(Rep_id), repair_time(Rep_id, Num_days).
:- repair_on_day(Rep_id, D), not repair_on_day(Rep_id, D+1), repair_on_day(Rep_id, E), E > D+1.

% - for each day, the total amount of tools needed (for each type of tool) for the repairs
%  scheduled on that day is less than or equal to the total amount of tools available (of that type),
trucks_on_day(D, N) :- N = #sum { Num_trucks, repair_trucks(Rep_id, Num_trucks) : repair_on_day(Rep_id, D), repair_trucks(Rep_id, Num_trucks) }, repair_on_day(_, D).
:- trucks_on_day(D, N), N > num_trucks.
drills_on_day(D, N) :- N = #sum { Num_drills, repair_drills(Rep_id, Num_drills) : repair_on_day(Rep_id, D), repair_drills(Rep_id, Num_drills)  }, repair_on_day(_, D).
:- drills_on_day(D, N), N > num_drills.
hammers_on_day(D, N) :- N = #sum { Num_hammers, repair_hammers(Rep_id, Num_hammers) : repair_on_day(Rep_id, D), repair_hammers(Rep_id, Num_hammers) }, repair_on_day(_, D).
:- hammers_on_day(D, N), N > num_hammers.

% - the overall amount of days after which all repairs are done is minimal.
max_day(D) :- D = #max {Day : repair_on_day(_, Day) }.
#minimize {D : max_day(D)}.
#show repair_on_day/2.
#show repair_trucks/2.
#show repair_drills/2.
#show repair_hammers/2.