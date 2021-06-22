%desde(+X,-Y)
desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

% si damos la posibilidad de que Y sea definido por el usuario, se nos puede colgar

%desde2(+X,?Y)
desde2(X,Y) :- X =< Y.
desde2(X,Y) :- X =< Y, N is X+1, desde2(N,Y).


% this does not work!!
% desde2(1, Y).