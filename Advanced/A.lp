% Tree Decomposition definition
% The union of all sets Xi equals V. 
% That is, each graph vertex is associated with at least one tree node.
% For every edge (v, w) in the graph, 
% there is a subset Xi that contains both v and w. 
% That is, vertices are adjacent in the graph only 
% when the corresponding subtrees have a node in common.
% If Xi and Xj both contain a vertex v, then all nodes Xk of 
% the tree in the (unique) path between Xi and Xj contain v as well. 
% That is, the nodes associated with vertex v form a connected subset of T. 
% This is also known as coherence, or the running intersection property.

%Generate a random undirected graph that is
% - connected
% - simple (no loops)
#const num_nodes=5.
node(1..num_nodes).

#const num_edges=4.

1 {edge(X, Y) : node(Y), X != Y} num_edges :- node(X).

:- S > num_edges, S = #count{ edge(X, Y) : edge(X, Y)}.

% :- S > 2*num_edges, S = #count{ edge(X, Y) : edge(X, Y)}.
% edge(X, Y) :- edge(Y, X).

reachable(1).
reachable(Y) :- edge(X, Y), reachable(X).
:- node(X), not reachable(X).
#show edge/2.


