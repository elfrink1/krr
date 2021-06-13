% PROBLEM INPUT

% You are given a network of roads:
% A collection of intersections and a collection of roads that are each between two intersections.
% Some roads are one-way, and some roads are two-way (this is specified in the problem input).
#const num_nodes=10.
node(1..num_nodes).


% You are also given a collection of which repair equipment is available (e.g., 2 trucks and 1 drill).
#const num_trucks=1.
#const num_drills=2.
#const num_hammers=3.

% In addition, you are given a subset of roads that need to be repaired (repair requests). 
% For each repair request, you are given:

% - Which road is to be repaired (i.e., the road segment between which two intersections).
% repair(repair_id, road_id).
% - How long this repair takes (e.g., a number of days). The repair should happen on subsequent days.
%%  (Repairs always take a multiple of complete days—in other words, 
%  the granularity of time for this problem is days.)
%  repair_time(repair_id, num_days)
% - What tools are needed for this repair (e.g., 1 truck and 1 drill).
% repair_trucks(repair_id, num_trucks_needed), repair_drills(repair_id, num_drills_needed), etc.


% -------------------------------------------------------------------------------
% PROBLEM ENCODING
% The task is to find a schedule for the repairs—i.e., 
% which repairs should happen on which (subsequent) days—such that:

% - each repair is assigned to the right amount of subsequent days,
% - for each day, the total amount of tools needed (for each type of tool) for the repairs
%  scheduled on that day is less than or equal to the total amount of tools available (of that type),
% - the overall amount of days after which all repairs are done is minimal.

