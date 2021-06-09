% *On the first day, there were three trials. 
% In all three, the king explained to the prisoner that each of the 
% two rooms contained either [chocolate] or a tiger, 
% but it could be that there were tigers in both rooms, 
% or [chocolate] in both rooms, or then again, 
% maybe one room contained [chocolate] and the other room a tiger.*
room(1;2).

% Again, there were two signs on the doors of the rooms:
% - I: At least one of these rooms contains chocolate.
s(1) :- chocolate(X), room(X).
chocolate(1), chocolate(2) :- s(1).

% - II: A tiger is in the other room.
tiger(1) :- s(2).
s(2) :- tiger(1).

% The king moreover said that these statements were either 
% both true or both false.
:- s(1), not s(2).
:- s(2), not s(1).

% If you were the prisoner, which door would you open?
1 {chocolate(X); tiger(X)} 1 :- room(X).