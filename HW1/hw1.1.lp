% An alphabet Σ (a finite, non-empty set), 
% of symbols σ1,...,σn, all labels of an edge

#const n=2.
symb(1..n).

% A finite, non-empty set Q of states (k states).
% An initial state q0 ∈ Q.
#const k=2.
possible_state(1..k).
state(1). % Set the initial state to 1.
{ state(K) : possible_state(K) } k.


% A set of labelled edges (q,q',σ) ∈ Q × Q × Σ.
% Here I select a subset of the edges, at least one for each provided symbol
% The full set of edges is implicit.
% Note that edges in an NFA are one-directional, and can be reflexive.
1 { edge(X, Y, Z) : state(X), state(Y) } 1 :- symb(Z).

% A finite set F ⊆ Q of final states. Commented for testing.
% 1 { final(X) : state(X) }.

% We make sure every state is theoretically reachable from state 1.
% Note again that edges (and thus reachability) are one-way.
reachable(1).
reachable(Y) :- edge(X, Y, Z), reachable(X).
:- state(X), not reachable(X).

% The input consists of a positive integer k and a set of tuples (w,o)
%  where w is a finite word over the alphabet Σ and o ∈ { 0,1 }. 
#const num_w = 1.
w0(d;o;g).
w1(d;o).

#show.
#show state/1.
#show edge/3.