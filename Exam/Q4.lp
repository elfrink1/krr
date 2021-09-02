% Write an answer set program P that starts with declaring a constant n, 
% and whose answer sets correspond to all undirected graphs G with exactly n nodes that form a tree. 
% A tree is a graph where for every pair u, v of different nodes it holds that u is reachable from v by exactly one path. 
% Or equivalently: a tree is a graph without cycles that is connected (meaning: every node is reachable from every other node by some path).
% An example of a tree on n=4 nodes is the graph G = (V,E) where V = {1,2,3,4} and where E = { {1,2}, {2,3}, {2,4} }.
% Explain how your program works. 
% That is, explain what the different lines in the answer set program do, 
% and explain how the answer sets of the program correspond to graphs with exactly n nodes that are trees.
% Note: you may assume that the nodes in the graph are V = {1,...,k}. 
% More generally, if there are multiple trees that only differ in the naming of the nodes, 
% your program needs to give only one of these, and may give more than one.

% Tip: keep n=4 (or some other suitable example) in mind when thinking about the program 
% (and when testing it with clingo, if you want to do that).
#const n=4.
% Choose an arbitrary or definite number of nodes.
% poss_node(1..n).
% {node(N) : poss_node(N)}.
% :- node(N), poss_node(N-1), not node(N-1).
node(1..n).

% Define that each node needs one edge to a node with a lower number.
1 {edge(X, Y) : node(Y), Y < X} 1:- node(X), X > 1.

% To remove symmetric solutions, the edge to the upper level will always be to the node with the lowest number.
:- edge(X, Y), edge(Y, Z), edge(A, Z), A < Y.

% A node cannot be below a node with a higher number
:- edge(X, Y), edge(A, B), X < A, Y > B. 


#show edge/2.