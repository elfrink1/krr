% An alphabet Σ (a finite, non-empty set), 
% of symbols σ1,...,σn, all labels of an edge

#const n=2.
symb(1..n).

% A finite, non-empty set Q of states (k states).
% An initial state q0 ∈ Q.
#const k=2.
state(1..k).

% A set of labelled edges (q,q',σ) ∈ Q × Q × Σ.
{ edge(X, Y, Z) : symb(Z) } n :- state(X), state(Y).

% A finite set F ⊆ Q of final states.

% The input consists of a positive integer k and a set of tuples (w,o)
%  where w is a finite word over the alphabet Σ and o ∈ { 0,1 }. 
#const num_w = 1
num_w {w(0), w(1)} num_w :- w