%% Made in co-operation with my brother Anton Holt

% Running the query: findall(X, charles(X), Xs), length(Xs, NumberSolutions).
% Results in: NumberSolutions = 16.
% We can divide this number by 4, because it is possible to rotate the entire puzzle 3 times. 
% We can further divide by two because we have two identical pieces.
% This resluts in 2 distinct puzzle solutions. 
% They are attached in the folder as images.

% Brun = brun, graerå = grae, Blond = bl, prikkerrikker = prikker, 

card([[brun, head], [blond, head], [prikker, tail], [grae, tail]]).
card([[grae, head], [prikker, head], [brun, tail], [blond, tail]]).
card([[brun, head], [prikker, head], [grae, tail], [blond, tail]]).
card([[brun, head], [prikker, head], [brun, tail], [blond, tail]]).
card([[grae, head], [blond, head], [brun, tail], [prikker, tail]]).
card([[grae, head], [blond, head], [grae, tail], [prikker, tail]]).
card([[grae, head], [brun, head], [prikker, tail], [blond, tail]]).
card([[brun, head], [prikker, head], [grae, tail], [blond, tail]]).
card([[brun, head], [grae, head], [blond, tail], [prikker, tail]]).

match([X, head], [X, tail]).
match([X, tail], [X, head]).

check_row(C1, C2, C3):-
	nth1(2, C1, RC1),
	nth1(4, C2, LC2),
	nth1(2, C2, RC2),
	nth1(4, C3, LC3),

	match(RC1, LC2),
	match(RC2, LC3).

check_cloumn(C1, C2, C3):-
	nth1(3, C1, DC1),
	nth1(1, C2, UC2),
	nth1(3, C2, DC2),
	nth1(1, C3, UC3),

	match(DC1, UC2),
	match(DC2, UC3).

solution(Cards):-
	[	
		A1, A2, A3,
		A4, A5, A6,
		A7, A8, A9
	] = Cards,

	rotate(A1, C1),
	rotate(A2, C2),
	rotate(A3, C3),
	check_row(C1, C2, C3),
	rotate(A4, C4),
	rotate(A5, C5),
	rotate(A6, C6),
	check_row(C4, C5, C6),
	rotate(A7, C7),
	rotate(A8, C8),
	rotate(A9, C9),
	check_row(C7, C8, C9),

	check_cloumn(C1, C4, C7),
	check_cloumn(C2, C5, C8),
	check_cloumn(C3, C6, C9),
	
	write([C1, ":", C2, ":", C3]), nl,
	write([C4, ":", C5, ":", C6]), nl,
	write([C7, ":", C8, ":", C9]), nl.


takeout(X,[X|R],R).  
takeout(X,[F |R],[F|S]) :- takeout(X,R,S).

perm([X|Y],Z) :- perm(Y,W), takeout(X,Z,W).  
perm([],[]).

rotate(X,X).

rotate(X, RotatedItem):-
	[X1, X2, X3, X4] = X,
	RotatedItem = [X4, X1, X2, X3].

rotate(X, RotatedItem):-
	[X1, X2, X3, X4] = X,
	RotatedItem = [X3, X4, X1, X2].

rotate(X, RotatedItem):-
	[X1, X2, X3, X4] = X,
	RotatedItem = [X2, X3, X4, X1].

charles(X):-
	findall(Card, card(Card), Cards),
	perm(Cards, X),
	solution(X).

% 9! * (4*9) = 