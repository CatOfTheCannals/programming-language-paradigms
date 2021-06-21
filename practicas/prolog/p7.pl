%Ejercicio 1

padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X, Y) :- padre(X, Z), padre(Z, Y).

% i) La consulta abuelo(X, manuel) instancia a X con juan.

% ii)

hijo(X, Y) :- padre(Y, X).
hermano(X, Y) :- hijo(X, Z), hijo(Y, Z), X \= Y.
descendiente(X, Y) :- hijo(X, Y).
descendiente(X, Y) :- hijo(X, Z), descendiente(Z, Y).

% iii) árbol para descendiente(Alguien, juan)

/*


															descendiente(Alguien, juan)
																		|
										(1)								|							(2)
						 _______________________________________________|__________________________________________________________________________________________
					    /																																           \	
				hijo(Alguien, juan)																													hijo(Alguien, Z), descendiente(Z, juan)	
						|																																			|
						|																																			|
 						|														                																	|
				padre(juan, Alguien)																												padre(Z, Alguien), descendiente(Z, juan)
						|																																			|
						|																																			|
	 ___________________|____________________ 												 _______________________________________________________________________|___________________________________________________________________________________________________________________________________________
	/				    |                    \												/																		|									 								   																	    \                                                       	
(Alguien <- carlos: □) (Alguien <- luis: □)  (Alguien <- <cualquier otro>: false)		(z <-juan)																(z <- carlos)																																(z <- luis)
																							|																		|																																			|
																							|																		|																																			|
																							|																		|																																			|
																			padre(juan, Alguien), descendiente(juan, juan)   					padre(carlos, Alguien), descendiente(carlos, juan)																							padre(luis, Alguien), descendiente(luis, juan)
																							|																		|																																			|
																							|																		|																																			|
																							|									 ___________________________________|___________________________________________        																						|
																						todas fallan por 						/								 	|										    \																	ANÁLOGO AL CASO CON CARLOS PERO CON LOS HIJOS DE LUIS
																						descendiente(juan, juan)		(Alguien <- daniel)				     (Alguien <- diego)			              (Alguien <- <cualquier otro>)
																																|									|								           	|
																																|									|											|
																																|									|											|
																										padre(carlos, daniel), descendiente(carlos, juan)   padre(carlos, diego), descendiente(carlos, juan)  padre(carlos, <otro>), descendiente(carlos, juan): false								
																																|									|																							
																																|									|
																																|									|
																														descendiente(carlos, juan)   	 descendiente(carlos, juan): □									
																																|									|															
																														  (1)	|	(2)						  (1)	|  (2)															
																														________|________					________|________															
																													   /                 \				   /				 \
																													  □           falso para todos        □           falso para todos
																																																		
																																PREGUNTA: cómo corta esto y evita el descendiente infinito?
*/

% iv) Alcanza con hacer abuelo(juan, Y) (otra posibilidad en esta base de conocimientos es: descendiente(Y, juan), not(hijo(Y, juan)))

% v)

ancestro(X, X).
ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).

% vi)

/* ancestro(juan, Y) 
						-> (1) unifica X con juan (primer resultado).
						-> (2) al pedir más resultados entra en el segundo caso.

							ancestro(juan, Y)
									|
						ancestro(Z, Y), padre(juan, Z)
									|
								(z <- juan)
									|
						ancestro(juan, Y), padre(juan, juan) (el subproblema contiene al problema original)
									|
	(1)	|																	(2)		|
	(y <- juan)															ancestro(Z', Y), padre(juan, Z'), padre(juan, juan)
		|																			|
ancestro(juan, juan), padre(juan, juan)											(z' <- juan)
		|																			|
	padre(juan, juan)													ancestro(juan, Y), padre(juan,juan), padre(juan, juan) (nuevamente aparece el problema)
		|
		false
						
						
PREGUNTA: es correcto esto? o con juan no entra nunca en el segundo caso?
*/

% vii)

ancestro2(X, X).
ancestro2(X, Y) :- padre(X, Z), ancestro2(Z, Y). % esto lo soluciona porque corta al llegar a padre(juan, juan).



%Ejercicio 2

vecino(X, Y, [_ | Ls]) :- vecino(X, Y, Ls).
vecino(X, Y, [X | [Y | _]]).

% i)

/*

								vecino(5, Y, [5, 6, 5, 3])
											|
			(1)	|													(2)	| 
		(Y<-6) (Ls <- [5, 3])									vecino(5, Y, [6, 5, 3])	
				□														|
													(1) |							(2)	|						
													  false						vecino(5, Y, [5, 3])
													  									|
													  				(1)	|							(2)	|
																	(Y <- 3) (Ls <- [])				vecino(5, Y [3])
																		□							(2)	|
																									vecino(X, Y, [])
																										|
																									   false	
*/

% ii) Dado que se explora primero el subárbol derecho del árbol exhibido arriba, el orden se invierte.



%Ejercicio 3

natural(0).
natural(suc(X)) :- natural(X).

menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
menorOIgual(X, X) :- natural(X).


% i)

/*

								menorOIgual(0, X)
										|
									(X <- suc(Y))
					|
		menorOIgual(0, Y)
					|
			(Y <- suc(Y'))
	|
menorOIgual(0, Y')
	|
Sigue así

El problema es que nunca se instancia la segunda variable de menorOIgual, sigue intentando unificar con otra variable.
*/

% ii) Debido a que realiza una búsqueda en profundidad, un ciclo infinito puede darse en una situación en la que un subproblema de un problema, 
% pueda matchear una regla que resulte en el problema original. En este esquema, siempre entrará por esa regla y no se llegará a destino. PREGUNTAR: es correcto el análisis o puede decirse algo más preciso?

% iii) 

menorOIgual2(X, X) :- natural(X).
menorOIgual2(X, suc(Y)) :- menorOIgual2(X, Y).


/*

								menorOIgual2(0, X)
										|
		(1)	|													(2)	|												
		(X <- 0)												(X <- suc(Y))
			|														|
		manorOIgual2(0, 0)										menorOIgual2(0, Y)
			|								(1)	|									(2)	|
		natural(0)							(Y <- 0)								   etcétera
			|									|
		   true								menorOIgual2(0, 0)
		   										|
		   									natural(0)
		   										|
		   									   true (X <- suc(0))
*/



%Ejercicio 4

concatenar([], L, L).
concatenar([X|XS], L, [Y|YS]) :- X = Y, concatenar(XS, L, YS).



%Ejercicio 5

%i)

last2(L, U) :- append(_,[U], L).

% ii)

reverse2([], []).
reverse2([X|XS], XXSR) :- reverse(XS, XSR), append(XSR, [X], XXSR). 

/*
					reverse2([a,b,c], [c,b,a])
								|
								| (2) 
								|
				(X <- a) (XS <- [b, c]) (XXSR <- [c,b,a])
								|
					reverse2([b, c], XSR1), append(XSR1, [a], [c,b,a])
								|
								| (2)
								|
				(X' <- b) (XS' <- [c])
								|
					reverse([c], XSR2), append(XSR2, [b], XSR1), append(XSR1, [a], [c,b,a])
								|
								| (2)
								|
				(X'' <- c) (XS'' <- [])
								|
					reverse([], XSR3), append(XSR3, [c], XSR2), append(XSR2, [b], XSR1), append(XSR1, [a], [c,b,a])
								|
								| (1)
								|
				(XSR3 <- [])
								|
					reverse2([], []), append([], [c], XSR2), append(XSR2, [b], XSR1), append(XSR1, [a], [c,b,a])
								|
				(XSR2 <- [c])
								|
					reverse2([], []), append([], [c], [c]), append([c], [b], XSR1), append(XSR1, [a], [c,b,a])
								|
				(XSR1 <- [c, b])
								|
					reverse2([], []), append([], [c], [c]), append([c], [b], [c, b]), append([c, b], [a], [c,b,a])
								|
							  true 

*/


% iii)

prefijo(P, L) :- append(P, _, L).

% iv)

%sufijo(P, L) :- reverse(L, LR), prefijo(PR, LR), reverse(PR, P).
sufijo(P, L) :- append(_, P, L).

% v)

/*
Con repetidos

sublista(SL, L) :- prefijo(SL, L).
sublista(SL, L) :- sufijo(SL, L).

*/
sublista([], _).
sublista(SL, L) :- prefijo(P, L), sufijo(SL, P), not(SL = []). % PREGUNTA: por qué no funciona SL /= []???????????????????

% vi)

pertenece(X, L) :- sublista([X], L).



% Ejercicio 6

aplanar([], []).
aplanar([X|XS], YS) :- aplanar(X, H), aplanar(XS, T), append(H, T, YS), !. % PREGUNTA: es muy feo esto?
aplanar(E, [E]). 



% Ejercicio 7

% i)

palindromo(L, L1) :- reverse2(L, LR), append(L, LR, L1).

% ii)

%iesimo(I, L, X) :-  PREGUNTA: esto es muy horrible
iesimo(I, L, X) :- append(P, _, L), length(P, I), last(P, X).   



% Ejercicio 8


