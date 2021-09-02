
% Define the graph
#const n=4.
node(1..n).

% Set edges
{edge(X, Y) : node(X), node(Y), X != Y}.
edge(Y, X) :- edge(X, Y).

% % Optional: Remove singleton nodes (i.e. remove trivial solutions)
% :- node(X), not edge(X, _).

% % Optional: Make the graph connected
% connected(1).
% connected(X) :- node(X), edge(X, Y), connected(Y).
% :- node(X), not connected(X).

% Define dominated nodes
#const k=3.
1 {dom(X) : node(X)} k.

% Define domination criterium
:-  node(X), not dom(X), S = 0, S = #count {1 : edge(X, Y), dom(Y)}.

% The domatic number of G, i.e. the maximum number of sets in a domatic partition of G,
% is equal to the maximum degree of G plus one.
degree(X, S) :- node(X), S = #count {edge(X, Y) : edge(X, Y)}.
max_degree(Q) :- Q = #max {S : node(X), degree(X, S)}.

#show edge/2.