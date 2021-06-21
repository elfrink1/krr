% Implement an algorithm that generates 9-by-9 BombKnightSudoku inputs (i.e., k=3) that: 
% 1. have exactly 10 cells filled with a number between 1 and 9, 
% 2. and have a unique solution. 
% That is, your algorithm should output a generator that iterates over BombKnightSudoku inputs with the required properties.

% Your algorithm should use the approach of translating this problem to an answer set program P, 
% calling an ASP solver (i.e., clingo) to find answer sets for P, 
% and translating these answer sets to BombKnightSudoku inputs with the required properties.

% (To be clear: you may not 'hardcode' a list of BombKnightSudoku inputs in the answer set program P.)
% There are two variants of this assignment: a harder variant (d.I) and an easier variant (d.II). 
% You may choose which variant you would like to solve. 
% If you opt for the harder variant (d.I), you can get a maximum of 3 points for this assignment. 
% If you opt for the easier variant (d.II), you can get a maximum of 2 points for this assignment. 

% ### (d.I) Harder variant (2pts):

% To solve the harder variant, your answer set program *P* should be such that for **each** BombKnightSudoku input *I* 
% with the required properties, there is an answer set of *P* that corresponds to *I*. 
% For this, you should express in *P* the constraints 
% 1. (that exactly 10 cells are filled) and 
% 2. (that the input has a unique solution).
% *Hint:* Use the technique of saturation to express constraint 2.

% ### (d.II) Easier variant (1pt):

% To solve the easier variant, your answer set program *P* only needs to be such that for **a subset of** 
% BombKnightSudoku inputs *I* with the required properties, there is an answer set of *P* that corresponds to *I*. 
% For this, you could express in *P*, in addition to the constraint 
% 1. (that exactly 10 cells are filled), 
% some other property that entails constraint 
% 2. (that the input has a unique solution).

#const k=3.
#const filled=10.
num(1..k**2).
b(1..k).

% Exactly 10 cells are filled.
10 {cell(X, Y, V) : num(X), num(Y), num(V)} 10.
cell(X, Y, 0) :- num(X), num(Y), not cell(X, Y, _).

% The input has a unique solution, i.e. No cell can contain more than one non-zero value
:- cell(X, Y, V), cell(X, Y, V2), V != V2, V != 0, V2 != 0.

% The standard rules (from C).
% Each cell is part of a k*k block
{block(X, Y, A, C) : X = (A-1)*k + B, Y = (C-1)*k + D} = 1 :- b(A), b(B), b(C), b(D).

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
:- cell(X, Y, V), cell(X2, Y2, V), X-X2=2, Y-Y2=1.
:- cell(X, Y, V), cell(X2, Y2, V), X2-X=2, Y2-Y=1.
:- cell(X, Y, V), cell(X2, Y2, V), X-X2=1, Y2-Y=2.
:- cell(X, Y, V), cell(X2, Y2, V), X2-X=1, Y-Y2=2.

#show cell/3.
