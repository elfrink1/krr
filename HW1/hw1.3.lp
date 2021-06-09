% Show how to translate any answer set program P that uses these 
% hypothetical statements with #even and #odd to an equivalent 
% answer set program P' (that is, P and P' have exactly the same 
% answer sets when restricted to the predicates that appear in P) 
% without using aggregates! — only using normal rules 
% (you may use first-order variables).

% You may show concretely how the translation can be done for the 
% following answer set program P0 (for different values of the constant t), 
% and then explain how your solution for P0 can be used (in modified form) 
% to translate arbitrary answer set programs with #even and #odd 
% (in the body of rules) to equivalent programs without these statements.

%Define input
#const k=3.
num(1..k).
{a(X) : num(X)}.
c(1, 1).
c(A+1, Y) :- c(A, X), a(Y), Y > X, not c(A+1, Z), a(Z).  

% Define counting mechanism

% Define even


