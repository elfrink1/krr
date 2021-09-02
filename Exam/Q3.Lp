% For this question, you will finish an ASP encoding of the following game (that is loosely based on the game known as Candy Crush). 
% The game is played on a row containing candies of different colors, and the game is played in several rounds. 
% In each round, you may select a sequence of three or more candies of the same color that are directly adjacent to each other, and remove those. 
% Note: if there are no three adjacent candies of the same color, there is no move that you can do, and you lose the game. 
% The goal is to find a strategy that removes all candies after some number of rounds—we call this a winning strategy.
% For example, if we use 1, 2 and 3 to indicate colors, we can consider the following row of 10 different candies: 1233322211. 
% For this starting point of the game, the following strategy is a winning strategy:
% in round 1, remove the three adjacent candies with color 3;
% in round 2, remove the four candies with color 2 that are now adjacent;
% in round 3, remove the three candies with color 1 that are now adjacent.
% Inputs for this game are encoded using predicates position/1 and candy/2, for example as follows:
#const k=10.
position(1..k).
candy(1,red).
candy(2,blue).
candy(3,green).
candy(4,green).
candy(5,green).
candy(6,blue).
candy(7,blue).
candy(8,blue).
candy(9,red).
candy(10,red).
% The encoding of this game into ASP that you will finish is the following:
% Generate a number of steps 1,...,j for some j <= k
possible_step(1..k).
{ step(S) : possible_step(S) }.
:- step(S), possible_step(S-1), not step(S-1).

% Identify the last step
final_step(F) :- F = #max { 0; S : step(S) }.

% Generate a strategy using select/2
3 { select(S,P) : position(P) } :- step(S).

%%%
%%% FINISH PROGRAM:
%%% - express the requirement that this is a valid strategy
%%% - express the requirement that using this strategy, all candies are removed
%%%
%%% Hint: express for each time step which candies are remaining and which
%%% remaining candies are adjacent to each other
%%%


% First I require that each candy must be chosen once and only once.
1 {select(S, P) : step(S)} 1 :- candy(P, C).

% Then I take the hint, and express for each time step which candies are remaining,
chosen(S, P) :- select(S, P).
chosen(S, P) :- chosen(S - 1, P), step(S).
remaining(S, P) :- step(S), candy(P, C), not chosen(S-1, P).

% and which are adjacent.
adjacent(S, P1, P2) :- remaining(S, P1), remaining(S, P2), P1 != P2, A=#max{P1;P2}, B=#min{P1;P2}, #count{ 1 : remaining(S, P3), P3<A, P3>B} = 0.
adjacent(S, P1, P2) :- adjacent(S, P2, P1).

% Finally, I require that every choice is of the same color,
:- select(S, P1), select(S, P2), candy(P1, C1), candy(P2, C2), P1 != P2, C1 != C2.

% that they are adjacent to at least one other selected candy,
:- select(S, P1), #count {1 : adjacent(S, P1, P2), select(S, P2)} = 0.

% and that at least one is adjacent to two other selected candies. 
%This restriction is not necessary to resolve this game. 
%However, removing it would allow solutions using groups of 2.
valid(S) :- select(S, P1), select(S, P2), select(S, P3), adjacent(S, P1, P2), adjacent(S, P2, P3).
:- not valid(S), step(S).


#show select/2.