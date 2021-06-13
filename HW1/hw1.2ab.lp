% PROBLEM INPUT

% You are given a network of roads:
% A collection of intersections and a collection of roads that are each between two intersections.
% Some roads are one-way, and some roads are two-way (this is specified in the problem input).
#const num_nodes=10.
num_nodes(1..num_nodes).

#const num_roads=8.
{} 8

% You are also given a collection of which repair equipment is available (e.g., 2 trucks and 1 drill).
#const num_trucks=1.
#const num_drills=2.
#const num_hammers=3.

% In addition, you are given a subset of roads that need to be repaired (repair requests). 
#const num_repairs=5.
repair_id(1..num_repairs).
#const num_possible_days=5*num_nodes.
possible_day(1..num_possible_days)

% - Which road is to be repaired (i.e., the road segment between which two intersections).
1 {repair(Repair_id, A, B) : road(A, B)} 1 :- repair_id(Repair_id).
{repair(Repair_id, A, B) : repair_id(Repair_id)} 1 :- road(A, B).

% - How long this repair takes (e.g., a number of days). The repair should happen on subsequent days.
%%  (Repairs always take a multiple of complete days—in other words, 
%  the granularity of time for this problem is days.)
1 {repair_time(Repair_id, Num_days) : choice_num_days(Num_days)} 1:- repair_id(Repair_id).

% - What tools are needed for this repair (e.g., 1 truck and 1 drill).
choice_num_trucks(1..num_trucks).
choice_num_drills(1..num_drills).
choice_num_hammers(1..num_hammers).

1 {repair_trucks(Repair_id, Num_trucks) : choice_num_trucks(Num_trucks)} 1:- repair_id(Repair_id).
1 {repair_drills(Repair_id, Num_drills) : choice_num_drills(Num_drills)} 1:- repair_id(Repair_id).
1 {repair_hammers(Repair_id, Num_hammers) : choice_num_hammers(Num_hammers)} 1:- repair_id(Repair_id).



% -------------------------------------------------------------------------------
% PROBLEM ENCODING
% The task is to find a schedule for the repairs—i.e., 
% which repairs should happen on which (subsequent) days—such that:

% - each repair is assigned to the right amount of subsequent days,
% repair_on_day(repair_id, day).
% num_days {repair_on_day(repair_id, Day), day(Day) : possible_day(Day) } num_days :- repair(repair_id, road_id), repair_time(repair_id, num_days).
:- day(Day), repair_on_day(Repair_id, Day), repair_on_day(Repair_id, Day+2), not repair_on_day(Repair_id, Day+1).

% - for each day, the total amount of tools needed (for each type of tool) for the repairs
%  scheduled on that day is less than or equal to the total amount of tools available (of that type),
:- day(Day),  Sum = #sum {Num_trucks_needed, repair_trucks(Repair_id, Num_trucks_needed) :  repair_on_day(Repair_id, Day)}, Sum > num_trucks.
:- day(Day),  Sum = #sum {Num_drills_needed, repair_drills(Repair_id, Num_drills_needed) :  repair_on_day(Repair_id, Day)}, Sum > num_drills.
:- day(Day),  Sum = #sum {Num_hammers_needed, repair_hammers(Repair_id, Num_hammers_needed) :  repair_on_day(Repair_id, Day)}, Sum > num_hammers.

% - the overall amount of days after which all repairs are done is minimal.

#minimize {1 : day(Day)}.

