%is_list(+X)
is_list(X) :- var(X), !, fail.
is_list([_|Xs]) :- is_list(Xs).
is_list([]).


%aplanar(+Xs, -Ys)
aplanar(E, [E]) :- not(is_list(E)).
aplanar([], []).
aplanar([X|Xs], Ys) :- aplanar(X, Xa), aplanar(Xs, Xsa), append(Xa, Xsa, Ys).































