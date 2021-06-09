% Someone in Dreadsbury Mansion killed Aunt Agatha
1 {killer(K, a) : mansion(K)} 1.

% Agatha, the butler, and Charles live in Dreadsbury Mansion, 
% and are the only ones to live there.
mansion(a;b;c).

% A killer always hates, and is no richer than his victim.
hates(K, V) :- killer(K, V).
-richer(K, V) :- killer(K, V). 

% Charles hates no one that Agatha hates
-hates(c, P) :- hates(a, P).

% Agatha hates everybody except the butler.
hates(a, P) :- mansion(P), P != b.

% The butler hates everyone not richer than Aunt Agatha
% hates(b, P) :- mansion(P), -richer(P, a).
hates(b, P) :- -richer(P, a).

% The butler hates everyone whom Agatha hates
% hates(b, P) :- hates(a, P), mansion(P).
hates(b, P) :- hates(a, P).

% % No one hates everyone
:- hates(P, a), hates(P, b), hates(P, c).