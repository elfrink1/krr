% ### D.2. The final trial

% *Instead of having [two] rooms for the prisoner to choose from, the king 
% gave him nine! As he explained, only one room contained [chocolate]; 
% each of the other eight contained a tiger or was empty. 
room(1..9).
1 {chocolate(X); tiger(X); empty(X)} 1 :- room(X).
1 {chocolate(X) : room(X)} 1.
% #count {chocolate(X) : room(X)}.
:- chocolate(X), chocolate(Y), X != Y.

% And, the king added, the sign on the door containing the [chocolate] 
% is true; the signs on doors of all rooms containing tigers are false; 
% and the signs on doors of empty rooms can be either true or false.*
1 {s(X); -s(X)} 1 :- room(X).
s(X) :- chocolate(X).
-s(X) :- tiger(X).
chocolate(X), empty(X) :- s(X).
tiger(X), empty(X) :- -s(X).
s(X), -s(X) :- empty(X).

% *Here are the signs:*
% - *I: The [chocolate] is in an odd-numbered room.*
s(1) :- chocolate(X), X \ 2 != 0.
X \ 2 != 0 :- s(1), chocolate(X). 

% - *II: This room is empty.*
s(2) :- empty(2).
empty(2) :- s(2).

% - *III: Either Sign V is right or Sign VII is wrong.*
% s(3) :- s(5), s(7).
% s(3) :- -s(5), -s(7).
s(5), -s(7) :- s(3).
% -s(3) :- -s(5), s(7).
% -s(3) :- s(5), -s(7). 
s(3) :- s(5).
s(3) :- -s(7).

% - *IV: Sign I is wrong.*
-s(1) :- s(4).
s(4) :- -s(1).

% - *V: Either sign II or Sign IV is right.*
s(2), s(4) :- s(5).
s(5) :- s(2).
s(5) :- s(4).
% s(5) :- s(2), -s(4).
% s(5) :- s(4), -s(2).
% -s(5) :- s(2), s(4).


% - *VI: Sign III is wrong.*
-s(6) :- s(3).
-s(3) :- s(6).

% - *VII: The [chocolate] is not in Room I.*
not chocolate(1) :- s(7).
s(7) :-  not chocolate(1).

% - *VIII: This room contains a tiger and Room IX is empty.*
s(8) :- tiger(8), empty(9).
tiger(8) :- s(8).
empty(9) :- s(8).

% - *IX: This room contains a tiger and Sign VI is wrong.*
tiger(9) :- s(9).
-s(6) :- s(9).
s(9) :- tiger(9), -s(6).

% *The prisoner studied the situation for a long while. 
% "The problem is unsolvable!" he exclaimed angrily. 
% "That's not fair!" "I know," laughed the king. 
% "Very funny!" replied the prisoner. 
% "Come on, now, at least give me a decent clue: is Room Eight empty or not?" 
% The king was decent enough to tell him whether Room VIII was empty or not, 
% and the prisoner was then able to deduce where the [chocolate] was.*
:- empty(8).


% Which room contained the chocolate?

#show.
#show X : chocolate(X).
