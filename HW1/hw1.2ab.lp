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
% We leave the code below commented, as it is not useful for part a and b, but remains part of the problem input.
% road(Road_id, B, A) :- road(Road_id, A, B), two_way(Road_id).

% In addition, you are given a subset of roads that need to be repaired (repair requests). 
#const num_repairs=5.
repair_id(1..num_repairs).
1 { repair(Rep_id, Road_id) : road_id(Road_id) } 1 :- repair_id(Rep_id).
{ repair(Rep_id, Road_id) : repair_id(Rep_id) } 1 :- road(Road_id, A, B).

% - How long this repair takes (e.g., a number of days). 
#const max_time=5.
possible_repair_times(1..max_time).
1 { repair_time(Rep_id, Num_days) : possible_repair_times(Num_days) } 1 :- repair_id(Rep_id).

% We set a uniqueness requirement for the time each repair takes.
{ repair_time(Rep_id, Num_days) : repair_id(Rep_id) } 1 :- possible_repair_times(Num_days).

% The next few lines can be used to define any number of tool types.
% The amount of tools of a single type available is automatically set between 1 and max_number_of_tool.
#const tool_types=4.
tool(1..tool_types). 
#const max_number_of_tool=5.
choice_num_tools(1..max_number_of_tool).

1 { num_tools(Tool_id, Num_tools) : choice_num_tools(Num_tools) } 1 :- tool(Tool_id).

% We define the predicate repair_tools(Repair_id, tool_id, number_of_tool_needed).
% We use a generator to assign the number of tools required by each repair.
% This could be set manually if desired. 
% Note that the problem will always be unsatisfiable if any repair needs more than the max number of a tool.
choice_repair_tools(0..max_number_of_tool).
1 { repair_tools(Rep_id, Tool_id, N) : choice_repair_tools(N), N < Num_tools} 1 :- repair_id(Rep_id), num_tools(Tool_id, Num_tools).

% We set the restrictions that each repair needs at least one tool, and that each tool is needed by at least one repair.
:- repair_id(Rep_id), Sum = #sum {N : repair_tools(Rep_id, _, N)}, Sum = 0.
:- tool(Tool_id), Sum = #sum {N : repair_tools(_, Tool_id, N)}, Sum = 0.



% -------------------------------------------------------------------------------
% PROBLEM ENCODING
% The task is to find a schedule for the repairs

% Here we assign the required number of days to each repair. 
% Note how we assign multiple days to the same repair (if necessary),
% using repair_on_day(repair_id, day).
#const possible_days=5*num_nodes.
day(1..possible_days).

Num_days { repair_on_day(Rep_id, D) : day(D) } Num_days :- repair_time(Rep_id, Num_days).

% The requirement for subsequence is expressed here
:- repair_on_day(Rep_id, D), not repair_on_day(Rep_id, D+1), repair_on_day(Rep_id, E), E > D+1.

% For each day, the total amount of tools needed (for each type of tool) for the repairs
%  scheduled on that day is less than or equal to the total amount of tools available (of that type),
% We use the predicate tools_on_day(Tool_ID, Day, Number_of_tool_needed) to express this requirement.
tools_on_day(Tool_id, D, N) :- N = #sum { Num_tools : repair_on_day(Rep_id, D), repair_tools(Rep_id, Tool_id, Num_tools) }, tool(Tool_id), repair_on_day(_, D).
:- tools_on_day(Tool_id, D, N), num_tools(Tool_id, Num_tools), N > Num_tools.

% - the overall amount of days after which all repairs are done is minimal.
max_day(D) :- D = #max {Day : repair_on_day(_, Day) }.
#minimize {D : max_day(D)}.

#show repair_on_day/2.
#show tools_on_day/3.
