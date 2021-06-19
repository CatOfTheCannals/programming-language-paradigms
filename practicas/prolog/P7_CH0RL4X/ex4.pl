%concatenar(?Lista1,?Lista2,?Lista3)

concatenar([], L, L).
concatenar([X1|X1S], Y, [X2|X2S]) :- X1 = X2, concatenar(X1S, Y, X2S).
