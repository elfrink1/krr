person(mr;ms; matt;john;tim).

% - If Mr Smith goes, his wife will go too.
go(ms) :- go(mr).

%  - At least one of their two sons Matt and John will go.
go(matt) ; go(john).
% :- not go(matt), not go(john).
%  - Either Mrs Smith or Tim will go, but not both.
go(ms) ; go(tim).
:- go(ms), go(tim).

%  - Either Tim and John will go, or neither will go.
:- go(tim), not go(john).
:- go(john), not go(tim).

%  - If Matt goes, then John and his father will also go.
go(mr) :- go(matt).
go(john) :- go(matt).

