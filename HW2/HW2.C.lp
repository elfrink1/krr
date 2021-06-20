input(1,3,3).
input(1,4,9).
input(1,6,5).
input(1,7,4).
input(3,1,4).
input(3,9,9).
input(4,1,6).
input(4,9,4).
input(6,1,7).
input(6,9,8).
input(7,1,3).
input(7,9,7).
input(9,3,7).
input(9,4,1).
input(9,6,3).
input(9,7,9).



#const k=3.
#const n=k*k.

x(1..n).
y(1..n).
v(1..n).
b(1..k).

% Each cell contains a value between 1 and k*k.
{cell(X, Y, V) : v(V)} = 1 :- x(X), y(Y).

% Each cell is part of a k*k block
{block(X, Y, A, C) : X = (A-1)*k + B, Y = (C-1)*k + D} = 1 :- b(A), b(B), b(C), b(D).


% If a cell (i,j) contains a value u in the input, then the cell (i,j) in the solution must contain the same value u.
cell(X, Y, V) :- input(X, Y, V), V != 0.

% Each two different cells in the same row must contain different values.
:- cell(X, Y, V), cell(X2, Y, V), X != X2.
% Each two different cells in the same column must contain different values.
:- cell(X, Y, V), cell(X, Y2, V), Y != Y2.

% Each two different cells in the same k*k block must contain different values.
:- cell(X, Y, V), cell(X2, Y2, V), block(X, Y, A, B), block(X2, Y2, A, B), (X,Y) != (X2,Y2).

% Each two different cells that are directly adjacent (diagonally) must contain different values.
:- cell(X, Y, V), cell(X2, Y2, V), X-X2=1, Y-Y2=1.
:- cell(X, Y, V), cell(X2, Y2, V), X2-X=1, Y2-Y=1.
:- cell(X, Y, V), cell(X2, Y2, V), X-X2=1, Y2-Y=1.
:- cell(X, Y, V), cell(X2, Y2, V), X2-X=1, Y-Y2=1.

% Each two different cells that can be reached from each other with a single knight's move (as in Chess) must contain different values.
:- cell(X, Y, V), cell(X2, Y2, V),





#show cell/3.