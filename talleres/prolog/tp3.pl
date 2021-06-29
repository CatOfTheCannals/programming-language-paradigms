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

evaluar(ST, VAR, 0) :- VAR > 0, not(member((VAR, _), ST)).
evaluar(ST, VAR, VAL) :- VAR > 0, member((VAR, VAL), ST).

%% CODIFICACIÓN

%% Codificación de listas

% al menos uno de los parametros DEBE estar instanciado
% codificacionLista(?L, ?Z)
codificacionLista(L, Z) :- codificacionListaDesde(L, Z, 1), !.

% codificacionLista(?L, ?Z, +I)
codificacionListaDesde([], 1, _).
codificacionListaDesde([X|Xs], Z, I) :- ground([X|Xs]), X > 0, Im1 is I+1, iesimoPrimo(I, P), codificacionListaDesde(Xs, Rec, Im1), Z is Rec*P**X.
codificacionListaDesde([X|Xs], Z, I) :- var(X), var(Xs), Im1 is I+1, iesimoPrimo(I, P), maximoExponenteQueDivideA(X,P,Z), Rec is Z/(P**X), codificacionListaDesde(Xs, Rec, Im1).

% divide(?A, +B)
divide(A, B) :- between(1, B, A), between(1, B, X), B is A*X.

% esPrimo(+P)
esPrimo(P) :- P > 1, Pm1 is P-1, not((between(2, Pm1, X), divide(X, P))).

%desde(+X, ?Y) 
desde(X, X).
desde(X, Y) :- nonvar(Y), Y > X.
desde(X, Y) :- var(Y), N is X+1, desde(N, Y).


% iesimoPrimo(+I, -P)
iesimoPrimo(1, 2).
iesimoPrimo(I, P) :- I>1, PREV is I-1, iesimoPrimo(PREV, PREVP), FROM is PREVP+1, desde(FROM, P), esPrimo(P), !.


% intervaloDecreciente(+X, ?Y)
intervaloDecreciente(X, X).
intervaloDecreciente(X, Y) :- nonvar(Y), Y < X.
intervaloDecreciente(X, Y) :- var(Y), N is X-1, N>=0, intervaloDecreciente(N, Y).


% maximoExponenteQueDivideA(-X, +P, +Z)
maximoExponenteQueDivideA(X, P, Z) :- intervaloDecreciente(Z, X), PX is P**X, divide(PX, Z), !. 

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
instanciarEstado([0|VALS], VAR, STS) :- NEXT is VAR+1, instanciarEstado(VALS, NEXT, STS).
instanciarEstado([VAL|VALS], VAR, [(VAR, VAL)|STS]) :- VAL \= 0, NEXT is VAR+1, instanciarEstado(VALS, NEXT, STS).

indiceParaEtiqueta(P, E, I) :- existeIndice(P, E, I), !.
indiceParaEtiqueta(P, E, I) :- not(existeIndice(P, E, _)), length(P, LEN), I is LEN+1.

existeIndice(P, E, I) :- nth1(I, P, INS), etiquetaInstruccion(INS, E).

avanzarIndice(_, _, INS, IO, I) :- INS \= goto(_,_,_), I is IO+1, !.
avanzarIndice(_, S, goto(_, V, _), IO, I) :- evaluar(S, V, 0), I is IO+1, !.
avanzarIndice(P, S, goto(_, V, E), _, I) :- not(evaluar(S, V, 0)), indiceParaEtiqueta(P, E, I).

avanzarEstado(nada(_, _), SO, SO).
avanzarEstado(suma(_, VAR), SO, S) :- actualizarEstado(SO, suma(_,VAR), S). 
avanzarEstado(resta(_, VAR), SO, S) :- actualizarEstado(SO, resta(_, VAR), S).
avanzarEstado(goto(_, _, _), SO, SO).

actualizarEstado(SO, suma(_, VAR), S) :- evaluar(SO, VAR, VAL), NEWVAL is VAL+1, actualizarVariable(SO, VAR, NEWVAL, S).
actualizarEstado(SO, resta(_, VAR), S) :- evaluar(SO, VAR, VAL), VAL > 1, NEWVAL is VAL-1, actualizarVariable(SO, VAR, NEWVAL, S). 
actualizarEstado(SO, resta(_, VAR), S) :- evaluar(SO, VAR, VAL), 1 >= VAL, delete(SO, (VAR,_), S).

actualizarVariable(SO, VAR, NEWVAL, S) :- delete(SO, (VAR,_), DSO), append(DSO, [(VAR, NEWVAL)], S).

prevSnap(XS, P, T, (PREVI, PREVS)) :- T > 0, PREV is T-1, snap(XS, P, PREV, (PREVI, PREVS)).

% snap(+Xs, +P, +T, -Di)
% Instancia en el cuarto argumento la descripción instantánea resultante de
% ejecutar el programa P con entradas Xs tras T pasos.
snap(XS, _, 0, (1, S)) :- instanciarEstado(XS, 2, S), !. 
snap(XS, P, T, (I, S)) :- T>0, prevSnap(XS, P, T, (PREVI, PREVS)), iEsimaInstruccion(P, PREVI, IESIMA), avanzarIndice(P, PREVS, IESIMA, PREVI, I), avanzarEstado(IESIMA, PREVS, S), !.                                         
snap(XS, P, T, (I, S)) :- T>0, prevSnap(XS, P, T, (PREVI, S)), length(P, LEN), PREVI > LEN, I is LEN+1.

% stp(+Xs, +P, +T)
% Indica si el programa P con entradas Xs termina tras T pasos.
% Se dice que un programa terminó cuando la próxima instrucción a ejecutar es
% 1 más que la longitud del programa.
stp(XS, P, T) :- T >= 0, snap(XS, P, T, (I, _)), length(P, LEN), I is LEN+1.

%% Pseudo-Halt

% pseudoHalt(+X, +Y)
pseudoHalt(X, P) :- desde(0, T), stp([X], P, T), !.

% Buscar entradas para las cuales el programa Y termina
% pseudoHalt2(-X, +Y)
pseudoHalt2(X, P) :- desde(0, C), codificacionDePares((X, T), C), TM is T-1, not(stp([X], P, TM)), stp([X], P, T).

% codificacionDePares(?X, +Z)
% Instancia el par correspondiente a la codificación Z.
codificacionDePares((X,Y), Z) :- ZPLUS is Z+1, maximoExponenteQueDivideA(X, 2, ZPLUS), DX is 2**X, Y is (-1 + ZPLUS/DX)/2, !. 

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

cantidadTestsEvaluar(3).
testEvaluar(1) :- evaluar([],1,0).
testEvaluar(2) :- evaluar([(4,0),(2,3)],2,3).
% pedir variables con indice negativo falla
testEvaluar(3) :- not(evaluar([], -1, _)).


cantidadTestsCodificacion(20). 
testCodificacion(1) :- codificacionLista([],1).
testCodificacion(2) :- codificacionLista([1],2).
testCodificacion(3) :- codificacionLista([2],4).
testCodificacion(4) :- codificacionLista([2,1],12).
testCodificacion(5) :- not(codificacionLista([-1,1],_)).
testCodificacion(6) :- not(codificacionLista([1,-1],_)).

% tests "desde"
testCodificacion(7) :- desde(1,2).
testCodificacion(8) :- not(desde(2,1)).

% tests "esPrimo"
testCodificacion(9) :- not(esPrimo(-1)).
testCodificacion(10) :- not(esPrimo(1)).
testCodificacion(11) :- esPrimo(5).

% tests "iesimoPrimo"
testCodificacion(12) :- iesimoPrimo(1,X), X = 2.
testCodificacion(13) :- not(iesimoPrimo(-1,_)).
testCodificacion(14) :- iesimoPrimo(4,X), X = 7.

% tests "intervaloDecreciente"
testCodificacion(15) :- intervaloDecreciente(2,1).
testCodificacion(16) :- intervaloDecreciente(1,X), X = 0.
testCodificacion(17) :- not(intervaloDecreciente(1,2)).

% tests "maximoExponenteQueDivideA"
testCodificacion(18) :- maximoExponenteQueDivideA(X, 2, 1), X = 0.
testCodificacion(19) :- maximoExponenteQueDivideA(X, 2, 5), X = 0.
testCodificacion(20) :- maximoExponenteQueDivideA(X, 2, 1024), X = 10.

% tests "snap"
cantidadTestsSnapYstp(34). 
% La lista de valores vacía, instancia un estado vacío.
testSnapYstp(1) :- instanciarEstado([], _, []).
% Una lista de valores no vacía, instancia un estado con las tuplas correspondientes.
testSnapYstp(2) :- instanciarEstado([1, -4], 2, [(2, 1), (3, -4)]).

% El índice de una etiqueta que no se encuentra en el programa es igual a su longitud mas 1.
testSnapYstp(3) :- indiceParaEtiqueta([], 5, 1).
% El índice obtenido es el de la etiqueta indicada
testSnapYstp(4) :- indiceParaEtiqueta([nada(5,_)], 5, 1).

% El programa vacío no contiene etiquetas.
testSnapYstp(5) :- not(existeIndice([], _, _)).
% Si la etiqueta existe, se instancia correctamente su índice
testSnapYstp(6) :- existeIndice([nada(5,_)], 5, 1).
% El predicado falla si la etiqueta no existe
testSnapYstp(7) :- not(existeIndice([nada(4,_)], 5, _)).

% Es posible actualizar una variable cuyo valore no aparece explícito en el estado
testSnapYstp(8) :- actualizarVariable([], 1, 1, [(1,1)]).
% Una variable presente en el estado, se actualiza correctamente
testSnapYstp(9) :- actualizarVariable([(1,2)], 1, 1, [(1,1)]).
% Solamente se modifica la variable indicada
testSnapYstp(10) :- actualizarVariable([(2,3), (1,2)], 1, 1, [(2,3), (1,1)]).

% tests avanzarIndice(+P, +S, +Ins, +I0, -I)
% La instrucción nada, suma y resta avanzan el índice en 1
testSnapYstp(11) :- avanzarIndice([nada(0,1)], [], nada(0,1), 1, 2).
testSnapYstp(12) :- avanzarIndice([suma(0,1)], [], suma(0,1), 1, 2).
testSnapYstp(13) :- avanzarIndice([resta(0,1)], [], resta(0,1), 1, 2).
% La instrucción goto avanza el índice en 1 si la variable tiene valor igual a 0
testSnapYstp(14) :- avanzarIndice([goto(0,1,1)], [], goto(0,1,1), 1, 2).
% La instrucción goto modifica el índice si la variable tiene valor distinto de 0
testSnapYstp(15) :- avanzarIndice([goto(0,1,1), resta(0,1), resta(1,1)], [(1,1)], goto(0,1,1), 1, 3).

% tests avanzarEstado(+Ins, +S0, -S)
% La instrucción 'nada' no altera el estado
testSnapYstp(16) :- avanzarEstado(nada(0,1), [(1,3),(2,5)], [(1,3),(2,5)]).
% La instrucción 'suma' altera el estado
testSnapYstp(17) :- avanzarEstado(suma(0,1), [(1,3),(2,5)], [(2,5),(1,4)]).
% La instrucción 'resta' altera el estado
testSnapYstp(18) :- avanzarEstado(resta(0,1), [(1,3),(2,5)], [(2,5),(1,2)]).
% La instrucción 'GOTO' no altera el estado
testSnapYstp(19) :- avanzarEstado(goto(0,1,0), [(1,3),(2,5)], [(1,3),(2,5)]).
testSnapYstp(20) :- avanzarEstado(goto(0,1,0), [(1,0),(2,5)], [(1,0),(2,5)]).

% las distintas instrucciones
% snap\4 es snap(+Xs, +P, +T, -Di)
testSnapYstp(21) :- snap([10],[nada(0,2)],1,(2,[(2,10)])).
testSnapYstp(22) :- snap([10],[suma(0,2)],1,(2,[(2,11)])).
testSnapYstp(23) :- snap([10],[resta(0,2)],1,(2,[(2,9)])).
testSnapYstp(24) :- snap([10],[goto(0,2,0)],1,(1,[(2,10)])).
testSnapYstp(25) :- snap([],[goto(0,2,0)],1,(2,[])).
% Snap funciona correctamente con 0 pasos.
testSnapYstp(26) :- snap([10],[suma(0,2)],0,(1,[(2,10)])).
% Snap funciona correctamente con 1 o más pasos.
testSnapYstp(27) :- snap([10,13],[nada(0,3),suma(1,2),resta(2,4)],3,(4,[(3,13), (2,11)])).

% tests para stp(+Xs, +P, +T)
% Stp funciona correctamente para programas que terminan en cero pasos.
testSnapYstp(28) :- stp([],[],0).
% Stp funciona correctamente para programas que terminan en uno o más pasos.
testSnapYstp(29) :- stp([1], [nada(0,2)], 1).
testSnapYstp(30) :- stp([1], [nada(0,2), nada(1,2)], 2).
% Stp falla si se instancian menos pasos que los necesarios para culminar la ejecución.
testSnapYstp(31) :- not(stp([1], [nada(0,2)], 0)).
% Stp permite instanciar una cantidad de pasos mayor a la necesaria para culminar la ejecución. 
testSnapYstp(32) :- stp([1], [nada(0,2)], 10).

% Snap no permite cantidad de pasos negativa.
testSnapYstp(33) :- not(snap(_, _, -1, _)).
% Stp no permite cantidad de pasos negativa.
testSnapYstp(34) :- not(stp(_, _, -1)).

cantidadTestsHalt(10).
testHalt(1) :- pseudoHalt(1,[nada(0,1)]).
testHalt(2) :- between(1, 10, T), pseudoHalt(T, [nada(0,1)]).
testHalt(3) :- pseudoHalt2(X,[nada(0,1)]), X == 0, !.
testHalt(4) :- pseudoHalt2(X,[nada(0,1)]), X == 1, !.
testHalt(5) :- pseudoHalt2(X,[resta(0,1)]), X == 0, !.
testHalt(6) :- pseudoHalt3(X, P), X == 0, P = [nada(0,1)], !. 
testHalt(7) :- pseudoHalt3(X, P), X == 2, P = [resta(0,1)], !. 
testHalt(8) :- pseudoHalt3(X, P), X == 0, P = [nada(0,1), nada(0,1)], !. 
% Codificación de pares.
testHalt(9) :- codificacionDePares((1,0), 1).
testHalt(10):- desde(0, C), codificacionDePares((2,5), C), !.


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
