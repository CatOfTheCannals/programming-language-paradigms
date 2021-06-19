%last(?L, ?U)
last([X|[]], X).
last([_|XS], E) :- last(XS, E).


%reverse(+L, -L1)
reverse([], []).
reverse([X|XS], Y) :- reverse(XS, Reversed), append(Reversed, [X], Y).


%prefijo(?P, +L)
prefijo([], _).
prefijo([P|PS], [L|LS]) :- P = L, prefijo(PS, LS).


%sufijo(?P, +L)
sufijo(U, L) :- append(_, U, L).


%sublista(?S, +L)
sublista(U, L) :- prefijo(P, L), sufijo(U, P).


%pertenece(?X, +L)
pertenece(X, L) :- sublista([X], L).



























