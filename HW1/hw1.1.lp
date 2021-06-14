% An alphabet Σ (a finite, non-empty set), 
% of symbols σ1,...,σn, all labels of an edge

#const n=2.
symb(d;o;g).

% A finite, non-empty set Q of states (k states).
% An initial state q0 ∈ Q.
#const k=2.
possible_state(0..k).
state(0). % Set the initial state to 0.
{ state(K) : possible_state(K) } k.


% A set of labelled edges (q,q',σ) ∈ Q × Q × Σ.
% Here I select a subset of the edges, at least one for each provided symbol
% The full set of edges is implicit.
% Note that edges in an NFA are one-directional, and can be reflexive.
1 { edge(X, Y, Z) : state(X), state(Y) } 1 :- symb(Z).

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
#const num_words=2.
word_id(1..num_words).

% % Automatic word generation (unfinished)
% #const max_length=3.
% possible_word_length(1..max_length).
% 1 {word_length(I, N) : possible_word_length(N)} 1 :- word_id(I).
% 1 { word(I, T, S) : symb(S)} 1 :- word_id(I), word_length(I, N), possible_word_length(T), T <= N.

% Manual word generation.
word(1, 1, d).
word(1, 2, o).
word(1, 3, g).

word(2, 1, d).
word(2, 2, o).

% Word_accepted(Word_ID)
word_accepted(1).

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
#minimize {K : max_k(K)}.

% #show.
% #show good/1.
#show reached/3.