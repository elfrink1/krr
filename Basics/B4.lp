% The code of Professor Smart's safe is a sequence of 9 distinct nonzero
% digits *C1* to *C9* such that the following equations and
% inequations are satisfied:
digit(c1;c2;c3;c4;c5;c6;c7;c8;c9).
number(1..9).

1 {combo(A, B) : number(B)} 1 :- digit(A).
1 {combo(A, B) : digit(A)} 1 :- number(B).

% *C4 - C6 = C7*
A - B = C :- combo(c4, A), combo(c6, B), combo(c7, C).

% *C1 * C2 * C3 = C8 + C9*
A * B * C = D + E :- combo(c1, A), combo(c2, B), combo(c3, C), combo(c8, D), combo(c9, E).

% *C2 + C3 + C6 < C8*
A + B + C < D :- combo(c2, A), combo(c3, B), combo(c6, C), combo(c8, D).

% *C9 < C8*
A < B :- combo(c9, A), combo(c8, B).

% and *C1 != 1*, *C2 != 2*, ..., *C9 != 9*.
:- combo(c1, 1).
:- combo(c2, 2).
:- combo(c3, 3).
:- combo(c4, 4).
:- combo(c5, 5).
:- combo(c6, 6).
:- combo(c7, 7).
:- combo(c8, 8).
:- combo(c9, 9).
