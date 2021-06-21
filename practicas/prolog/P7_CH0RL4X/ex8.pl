%interseccion(+L1, +L2, -L3)
interseccion([], _, []).
interseccion(_, [], []).
interseccion([L1|L1s], L2s, L3) :- member(L1, L2s), interseccion(L1s, L2s, I), L3 = [L1|I].
interseccion([L1|L1s], L2s, L3) :- not(member(L1, L2s)), interseccion(L1s, L2s, L3).


%partir(+N, +L, -L1, -L2)
partir(0, L, [], L).
partir(N, [X|Xs], [X|L1s], L2) :- N > 0, partir(N - 1, Xs, L1s, L2).

%this does not work yet!!
%partir(1, [1,2,3], X, Y).


%borrar(+ListaOriginal, +X, -ListaSinXs)
borrar([], _, []).
borrar([L|Ls], X, ListaSinXs) :- L = X, borrar(Ls, X, ListaSinXs).
borrar([L|Ls], X, ListaSinXs) :- L \= X, borrar(Ls, X, SubListaSinXs), ListaSinXs = [L|SubListaSinXs].


%sacarDuplicados(+L1, -L2)
sacarDuplicados([], []).
sacarDuplicados([L1|L1s], L2s) :- member(L1, L1s), sacarDuplicados(L1s, L2s).
sacarDuplicados([L1|L1s], L2s) :- not(member(L1, L1s)), sacarDuplicados(L1s, L3s), L2s = [L1|L3s].


%permutacion(+L1, ?L2)
permutacion([], []).
permutacion(L1, L2) :- length(L1, N), permutacion_aux(L1, L2, N - 1).

%permutacion_aux(+L1, ?L2, +N)
permutacion_aux(L1, 42, 0).
permutacion_aux(L1, L2, N) :- N > -1, partir(N, L1, L1a, [L1b|L1bs]), append(L1a, L1bs, C), permutacion(C, P), L2 = [L1b|P].
permutacion_aux(L1, L2, N) :- N > -1, permutacion_aux(L1, L2, N-1).

% this works
% permutacion_aux([1], Y, 0).
% this does not
% permutacion([1], Y).



















