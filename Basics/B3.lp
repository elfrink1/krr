% Dominique, Ignace, Naren, Olivier, Philippe, and Pascal
% have arrived as the first six at the Paris marathon.
person(d;i;n;o;ph;pa).
number(1..6).

1 { pos(P, I): person(P) } 1 :- number(I).
1 { pos(P, I): number(I) } 1 :- person(P).
% Reconstruct their arrival order from the following
% information:
% - Olivier has not arrived last
:- pos(o, 6).

% - Dominique, Pascal and Ignace have arrived before Naren and Olivier
:- pos(d, I), pos(n, J), I > J.
:- pos(d, I), pos(o, J), I > J.
:- pos(pa, I), pos(n, J), I > J.
:- pos(pa, I), pos(o, J), I > J.
:- pos(i, I), pos(n, J), I > J.
:- pos(i, I), pos(o, J), I > J.


% - Dominique who was third last year has improved this year.
I < 3 :- pos(d, I).

% - Philippe is among the first four.
I < 5 :- pos(ph, I).

% - Ignace has arrived neither in second nor third position.
:- pos(i, 2).
:- pos(i, 3).

% - Pascal has beaten Naren by three positions.
pos(pa, I - 3) :- pos(n, I).
pos(n, I + 3) :- pos(pa, I).
% - Neither Ignace nor Dominique are on the fourth position.
:- pos(i, 4).
:- pos(d, 4).