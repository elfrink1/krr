% ### C.4.

% When McGregor interviewed the fourth couple, the person opening the door 
% said: "My partner and I are of the same type. We are either both knights 
% or both knaves." 
% What can be deduced about the person opening the door and what can be 
% deduced about the partner?

person(7;8).
:- knight(7), knave(8).
:- knave(7), knight(8).

knight(X) ; knave(X) :- person(X).

