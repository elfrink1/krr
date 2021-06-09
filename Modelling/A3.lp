item(1..4).
1 { choose(N) : item(N) }.
a(S) :- S = #count {N : choose(N) }.
#minimize {S : a(S)}.
