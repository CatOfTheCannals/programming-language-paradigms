padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X,Y) :- padre(X,Z), padre(Z,Y).

hijo(X,Y) :- padre(Y,X).
hermano(X,Y):- padre(Z,X), padre(Z,Y).
descendiente(X,Y) :- hijo(X,Y).
descendiente(X,Y) :- padre(Y,Z), descendiente(X,Z).

ancestro(X, X).
ancestro(X, Y) :- padre(X, Z), ancestro(Z, Y).