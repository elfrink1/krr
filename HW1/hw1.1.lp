% An alphabet Σ (a finite, non-empty set), 
% of symbols σ1,...,σn, all labels of an edge

symb(c;d;o;g;).

% A finite, non-empty set Q of states (k states).
% An initial state q0 ∈ Q.
#const k=20.
possible_state(0..k).
state(0). % Set the initial state to 0.
{ state(K) : possible_state(K) } k.


% A set of labelled edges (q,q',σ) ∈ Q × Q × Σ.
% Here I select a subset of the edges, for each symbol in our dictionary.
% Note that there can be more than one edge per symbol.
% The full set of edges is implicit.
% Note that edges in an NFA are one-directional, and can be reflexive.
{ edge(X, Y, Z) : state(X), state(Y) } :- symb(Z).

% A finite set F ⊆ Q of final states. Commented for testing.
1 { final_state(X) : state(X) }.

% We make sure every state is theoretically reachable from state 1.
% Note again that edges (and thus reachability) are one-way.
reachable(0).
reachable(Y) :- edge(X, Y, Z), reachable(X).
:- state(X), not reachable(X).


% The input consists of a positive integer k and a set of tuples (w,o)
%  where w is a finite word over the alphabet Σ and o ∈ { 0,1 }. 
% word(Word_ID, Index of symbol, Symbol)
#const num_words=5.
word_id(1..num_words).

% Manual word generation.
word(1, 1, d).
word(1, 2, o).
word(1, 3, g).

word(2, 1, d).
word(2, 2, o).
word(2, 3, g).
word(2, 4, d).

word(3, 1, c).
word(3, 2, o).
word(3, 3, g).

word(4, 1, c).
word(4, 2, o).
word(4, 3, d).

word(5, 1, d).
word(5, 2, o).
word(5, 3, c).


% Word_accepted(Word_ID)
word_accepted(1;2;5).

% Note that only defined symbols can be used (i.e. to use X we need symb(X)).
% The program will run when using undefined symbols, but the result will not be accurate.
:- word(_, _, S), not symb(S).


% Generate paths, set reached(node_ID, Timestamp, word_ID)
reached(0, 0, I) :- word_id(I).
reached(A, T+1, I) :- reached(B, T, I), edge(B, A, S), word(I, T+1, S).
:- not reached(A, T+1, I), reached(B, T, I), edge(B, A, S), word(I, T+1, S).
:- reached(A, T, I), reached(B, T, I), A != B.

% Set (un)reachable requirement for final states
good(I) :- final_state(A), reached(A, T, I), not word(I, T+1, _).
:- word_accepted(I), not good(I).
:- not word_accepted(I), good(I).

max_k(K) :- K = #max { N : state(N) }.
#minimize {K@2 : max_k(K)}.
num_edges(N) :- N = #count {edge(X, Y, Z) : edge(X, Y, Z) }.
#minimize {N@1 : num_edges(N)}.

% #show.
#show good/1.
#show edge/3.
#show state/1.
#show final_state/1.