#const num_nodes=3.
#const num_edges=2.
#const k=num_edges.
% define nodes
node(1..num_nodes).

% define bi-directional edges
edge(X, Y) :- edge(Y, X).

% Generate at least one but no more than k edges per node
1 { edge(X, Y) : node(Y), X != Y } k :- node(X).

% and no more than k edges in total (use 2*k for bidirectionality).
:- S > 2*k, S = #count {edge(X,Y) : edge(X, Y)}.

% Define reachability (we start from node 1).
reachable(1).
reachable(X) :- edge(X, Y), reachable(Y).
:- node(X), not reachable(X).
