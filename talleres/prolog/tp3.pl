%% LENGUAJE S

% Variables (representadas con su correspondiente codificación): Y (1), X1 (2), Z1 (3), X2 (4), Z2 (5), ...

% Etiquetas (representadas con su correspondiente codificación): A(1), B(2), C(3), ...

% Instrucciones:
%  nada(L,V)   [L] V <- V
%  suma(L,V)   [L] V <- V+1
%  resta(L,V)  [L] V <- V-1
%  goto(L,V,E) [L] if V /= 0 goto E

% Estado (lista de pares variable-valor):
%  [(var,val)]

% evaluar(+Estado, +Var, -Val)
% Dado un estado y una variable, instancia en el tercer argumento el valor
%   de la variable en el estado. Las variables que no aparecen en el estado tienen valor 0.

evaluar(ST, VAR, 0) :- not(member((VAR, _), ST)).
evaluar(ST, VAR, VAL) :- member((VAR, VAL), ST).

%% CODIFICACIÓN

%% Codificación de listas

% codificacionLista(?L, ?Z)
codificacionLista(L, Z) :- codificacionListaDesde(L, Z, 1).

% codificacionLista(?L, ?Z, +I)
codificacionListaDesde([], 1, _) :- !. /*************************************************** ABUSAMOS DEL CUT???????????????????*************************************************************************************************/
codificacionListaDesde([X|Xs], Z, I) :- ground([X|Xs]), Im1 is I+1, iesimoPrimo(I, P), codificacionListaDesde(Xs, Rec, Im1), Z is Rec*P**X, !.
codificacionListaDesde([X|Xs], Z, I) :- var(X), var(Xs), Im1 is I+1, iesimoPrimo(I, P), maximoExponenteQueDivideA(X,P,Z), Rec is Z/(P**X), codificacionListaDesde(Xs, Rec, Im1), !.

% divide(?A, +B)
divide(A, B) :- between(1, B, A), between(1, B, X), B is A*X, !.

% esPrimo(+P)
esPrimo(P) :- P \= 1, Pm1 is P-1, not((between(2, Pm1, X), divide(X, P))), !.


desde(X, X).
desde(X, Y) :- nonvar(Y), Y > X.
desde(X, Y) :- var(Y), N is X+1, desde(N, Y).


% iesimoPrimo(+I, -P)
iesimoPrimo(1, 2).
iesimoPrimo(I, P) :- I>1, PREV is I-1, iesimoPrimo(PREV, PREVP), FROM is PREVP+1, desde(FROM, P), esPrimo(P), !.


intervaloDecreciente(X, X).
intervaloDecreciente(X, Y) :- nonvar(Y), Y < X.
intervaloDecreciente(X, Y) :- var(Y), N is X-1, N>=0, intervaloDecreciente(N, Y).


% maximoExponenteQueDivideA(-X, +P, +Z)
maximoExponenteQueDivideA(X, P, Z) :- intervaloDecreciente(Z, X), PX is P**X, divide(PX, Z), !. 
/*El problema con esto es que si X va instanciado no es posible determinar si efectivamente es el mayor exponente*/

%% OBSERVADORES

% pi1(+(X,Y), -X) % instancia en el segundo argumento la primer componente de la tupla (X, Y).
pi1((X, _), X).

% pi2(+(X,Y), -Y) % instancia en el segundo argumento la primer componente de la tupla (X, Y).
pi2((_, Y), Y).

% iesimo(+L, +I, -X) % indexar en lista: instancia en el tercer argumento el elemento en la posición I de la lista L.
iesimo([X|_], 1, X).
iesimo([_|Xs], I, E) :- I > 1, Im1 is I-1, iesimo(Xs, Im1, E).

% etiquetaInstruccion(+Instruccion, -Etiqueta)
etiquetaInstruccion(nada(L,_), L).
etiquetaInstruccion(suma(L,_), L).
etiquetaInstruccion(resta(L,_), L).
etiquetaInstruccion(goto(L,_,_), L).

% codigoInstruccion(+Instruccion, -Codigo)
codigoInstruccion(nada(_,_), 0).
codigoInstruccion(suma(_,_), 1).
codigoInstruccion(resta(_,_), 2).
codigoInstruccion(goto(_,_,E), C) :- C is E+2.

% variableInstruccion(+Instruccion, -Variable)
variableInstruccion(nada(_,V), V).
variableInstruccion(suma(_,V), V).
variableInstruccion(resta(_,V), V).
variableInstruccion(goto(_,V,_), V).

% longitud(+P, -L) % Instancia en el segundo argumento la longitud del programa P
longitud([], 0).
longitud([_|Xs], L) :- longitud(Xs, Lm1), L is Lm1 + 1.

% iEsimaInstruccion(+P, +Indice, -Instruccion) % Instancia en el tercer argumento la Indice-ésima instrucción del programa P.
iEsimaInstruccion(E, Indice, Instruccion) :- is_list(E), iesimo(E, Indice, Instruccion).

%% Simulación del lenguaje S

% Descripción instantánea (par índice-estado, donde el índice (empezando en 1)
% indica el número de la próxima instrucción a ejecutar):
%  (i,s)

instanciarEstado([], _, []).
instanciarEstado([VAL|VALS], VAR, [(VAR, VAL)|STS]) :- NEXT is VAR+1, instanciarEstado(VALS, NEXT, STS).

indiceParaEtiqueta(P, E, I) :- existeIndice(P, E, I), !.
indiceParaEtiqueta(P, E, I) :- not(existeIndice(P, E, _)), length(P, LEN), I is LEN+1.

existeIndice(P, E, I) :- nth1(I, P, INS), etiquetaInstruccion(INS, E).

avanzarIndice(_, _, INS, IO, I) :- codigoInstruccion(INS, CODE), CODE =< 2, I is IO+1.
avanzarIndice(_, S, goto(_, V, _), IO, I) :- evaluar(S, V, 0), I is IO+1.
avanzarIndice(P, S, goto(_, V, E), _, I) :- not(evaluar(S, V, 0)), indiceParaEtiqueta(P, E, I).

avanzarEstado(nada(_, _), SO, SO).
avanzarEstado(suma(_, VAR), SO, S) :- actualizarEstado(SO, suma(_,VAR), S). 
avanzarEstado(resta(_, VAR), SO, S) :- actualizarEstado(SO, resta(_, VAR), S).
avanzarEstado(goto(_, _, _), SO, SO).

actualizarEstado(SO, suma(_, VAR), S) :- evaluar(SO, VAR, VAL), NEWVAL is VAL+1, actualizarVariable(SO, VAR, NEWVAL, S).
actualizarEstado(SO, resta(_, VAR), S) :- evaluar(SO, VAR, VAL), VAL > 1, NEWVAL is VAL-1, actualizarVariable(SO, VAR, NEWVAL, S). 
actualizarEstado(SO, resta(_, VAR), S) :- evaluar(SO, VAR, VAL), 1 >= VAL, delete(SO, (VAR,_), S).

actualizarVariable(SO, VAR, NEWVAL, S) :- delete(SO, (VAR,_), DSO), append(DSO, (VAR, NEWVAL), S).

prevSnap(XS, P, T, (PREVI, PREVS)) :- T > 0, PREV is T-1, snap(XS, P, PREV, (PREVI, PREVS)).

% snap(+Xs, +P, +T, -Di)
% Instancia en el cuarto argumento la descripción instantánea resultante de
% ejecutar el programa P con entradas Xs tras T pasos.
/* 
    XS: lista de enteros con los valores de entrada de las variables
    P: lista de instrucciones que representa el programa
    T: numero de pasos a ejecutar

    snap = (INDICE DE LA PRÓXIMA INSTRUCCIÓN, ESTADO)
*/

snap(XS, _, 0, (1, S)) :- instanciarEstado(XS, 2, S), !. 
snap(XS, P, T, (I, S)) :- prevSnap(XS, P, T, (PREVI, PREVS)), iEsimaInstruccion(P, PREVI, IESIMA), avanzarIndice(P, PREVS, IESIMA, PREVI, I), avanzarEstado(IESIMA, PREVS, S), !.                                         
snap(XS, P, T, (I, S)) :- prevSnap(XS, P, T, (PREVI, S)), length(P, LEN), PREVI > LEN, I is LEN+1.

% stp(+Xs, +P, +T)
% Indica si el programa P con entradas Xs termina tras T pasos.
% Se dice que un programa terminó cuando la próxima instrucción a ejecutar es
% 1 más que la longitud del programa.
stp(XS, P, T) :- snap(XS, P, T, (I, _)), length(P, LEN), I is LEN+1.

%% Pseudo-Halt

% pseudoHalt(+X, +Y)
pseudoHalt(X, P) :- desde(0, 1), stp([X], P, 1), !.

% Buscar entradas para las cuales el programa Y termina
% pseudoHalt2(-X, +Y)
pseudoHalt2(X, P) :- desde(0, C), codificacionDePares((X, T), C), stp([X], P, T).

codificacionDePares((X,Y), Z) :- ZPLUS is Z+1, maximoExponenteQueDivideA(X, 2, ZPLUS), DX is 2**X, Y is (-1 + ZPLUS/DX)/2. 

% Buscar pares programa-entrada que terminen
% pseudoHalt3(-X, -Y)                                       
pseudoHalt3(X, P) :- desde(1, C), codificacionLista(L, C), L=[X, T, CP], programa(P, CP), TM is T-1, not(stp([X], P, TM)), stp([X], P, T).

% programa(-P, +N)
programa([], 0) :- !.
programa([I|Is], N) :- N > 0, between(1,N,C), instruccion(I,C), N2 is N-C, programa(Is,N2).

% instruccion(-I, +N)
instruccion(nada(0,1),1).
instruccion(nada(L,V),N) :- N > 1, between(1,N,V), L is N-V.
instruccion(suma(0,1),1).
instruccion(suma(L,V),N) :- N > 1, between(1,N,V), L is N-V.
instruccion(resta(0,1),1).
instruccion(resta(L,V),N) :- N > 1, between(1,N,V), L is N-V.
instruccion(goto(0,1,1),2).
instruccion(goto(L,V,E),N) :- N > 2, N2 is N-1, between(1,N2,V), N3 is N-V, between(1,N3,E), L is N3-E.

%% TESTS

cantidadTestsEvaluar(2). % Actualizar con la cantidad de tests que entreguen
testEvaluar(1) :- evaluar([],1,0).
testEvaluar(2) :- evaluar([(4,0),(2,3)],2,3).
% Agregar más tests

cantidadTestsCodificacion(2). % Actualizar con la cantidad de tests que entreguen
testCodificacion(1) :- codificacionLista([],1).
testCodificacion(2) :- codificacionLista([1],2).
% Agregar más tests

cantidadTestsSnapYstp(2). % Actualizar con la cantidad de tests que entreguen
testSnapYstp(1) :- stp([],[],1).
testSnapYstp(2) :- snap([10],[suma(0,1)],0,(1,[(2,10)])).
% Agregar más tests

cantidadTestsHalt(1). % Actualizar con la cantidad de tests que entreguen
testHalt(1) :- pseudoHalt(1,[suma(0,1)]).
% Agregar más tests

tests(evaluar) :- cantidadTestsEvaluar(M), forall(between(1,M,N), testEvaluar(N)).
tests(codificacion) :- cantidadTestsCodificacion(M), forall(between(1,M,N), testCodificacion(N)).
tests(snapYstp) :- cantidadTestsSnapYstp(M), forall(between(1,M,N), testSnapYstp(N)).
tests(halt) :- cantidadTestsHalt(M), forall(between(1,M,N), testHalt(N)).

tests(todos) :-
  tests(evaluar),
  tests(codificacion),
  tests(snapYstp),
  tests(halt).

tests :- tests(todos).
