
% Define the graph
#const k=3.
#const n = 6.
node(1..n).
{edge(X, Y) : node(X), node(Y), X != Y}.
edge(Y, X) :- edge(X, Y).

% Define domination
1 {dom(X) : node(X)} k.
% Set reachability criterium
:-  node(X), not dom(X), S = 0, S = #count {1 : edge(X, Y), dom(Y)}.

#minimize { 1, dom(X) : dom(X)}.
