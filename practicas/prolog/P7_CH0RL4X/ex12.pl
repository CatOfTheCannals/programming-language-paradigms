%vacio(?A)
vacio(nil).


%raiz(+A, ?R)
raiz(bin(_, R, _), R).


%altura(+A, ?H)
altura(nil, 0).
altura(bin(I, _, D), H) :- altura(I, Hi), altura(D, Hd), Hi > Hd, H is 1 + Hi.
altura(bin(I, _, D), H) :- altura(I, Hi), altura(D, Hd), Hi <= Hd, H is 1 + Hd.


%cantidadDeNodos(+A, ?C)
cantidadDeNodos(nil, 0).
altura(bin(I, _, D), C) :- cantidadDeNodos(I, Ci), cantidadDeNodos(D, Cd), C = Ci + Cd + 1.






























