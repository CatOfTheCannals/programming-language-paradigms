Alan es un robot japonés: 
R(alan) ^ J(alan)

Cualquier robot que puede resolver un problema lógico es inteligente:
∀x.∀y.((R(x) ^ Pl(y) ^ Res(x, y)) ==> I(x))

Todos los robots japoneses pueden resolver todos los problemas de esta práctica:
∀w.∀z.((R(w) ^ J(w) ^ Pr(z)) ==> Res(w, z))

Todos los problemas de esta práctica son lógicos:
∀p.(Pr(p) ==> Pl(p))

Existe al menos un problema en esta práctica:
∃x.(Pr(x))

Objetivo: quiero usar esta base de conocimiento para demostrar que alan es inteligente

Estrategia: 
- dire que la conjuncion de las reglas implica que alan es inteligente
- refutare la negacion de esta expresion, que al ser insatisfacible nos dira que la afirmacion original es tautologia

conjuncion de reglas implica inteligencia de alan:
[
	∀x.∀y.((R(x) ^ Pl(y) ^ Res(x, y)) ==> I(x)) ^
	∀w.∀z.((R(w) ^ J(w) ^ Pr(z)) ==> Res(w, z)) ^
	∀p.(Pr(p) ==> Pl(p)) ^
	∃x.(Pr(x)) ^
	R(alan) ^ 
	J(alan)
] ==> I(alan)

negar formula
[
	∀x.∀y.((R(x) ^ Pl(y) ^ Res(x, y)) ==> I(x)) ^
	∀w.∀z.((R(w) ^ J(w) ^ Pr(z)) ==> Res(w, z)) ^
	∀p.(Pr(p) ==> Pl(p)) ^
	∃x.(Pr(x)) ^
	R(alan) ^ 
	J(alan)
] ^ ¬I(alan)

eliminar implicaciones
[
	∀x.∀y.(¬(R(x) ^ Pl(y) ^ Res(x, y)) v I(x)) ^
	∀w.∀z.(¬(R(w) ^ J(w) ^ Pr(z)) v Res(w, z)) ^
	∀p.(¬Pr(p) v Pl(p)) ^
	∃x.(Pr(x)) ^
	R(alan) ^ 
	J(alan)
] ^ ¬I(alan)

de morgan
[
	∀x.∀y.((¬R(x) v ¬Pl(y) v ¬Res(x, y)) v I(x)) ^
	∀w.∀z.((¬R(w) v ¬J(w) v ¬Pr(z)) v Res(w, z)) ^
	∀p.(¬Pr(p) v Pl(p)) ^
	∃x.(Pr(x)) ^
	R(alan) ^ 
	J(alan)
] ^ ¬I(alan)

eliminar cuantificador existe
[
	∀x.∀y.((¬R(x) v ¬Pl(y) v ¬Res(x, y)) v I(x)) ^
	∀w.∀z.((¬R(w) v ¬J(w) v ¬Pr(z)) v Res(w, z)) ^
	∀p.(¬Pr(p) v Pl(p)) ^
	(Pr(ej)) ^
	R(alan) ^ 
	J(alan)
] ^ ¬I(alan)

se tiene las siguientes clausulas

1. {¬R(x), ¬Pl(y), ¬Res(x, y), I(x)}, 	definicion
2. {¬R(w), ¬J(w), ¬Pr(z), Res(w, z)}, 	definicion
3. {¬Pr(p), Pl(p)},						definicion
4. {Pr(ej)},							definicion
5. {R(alan)},							definicion
6. {J(alan)},							definicion
7. {¬I(alan)}							goal

procedemos a realizar una refutacion SLD:

goal									clausula de entrada		sustitucion
{¬I(alan)}				 				1						s1 = {x <- alan}
{¬R(alan), ¬Pl(y), ¬Res(alan, y)}		2						s2 = {w <- alan, z <- y}
{¬R(alan), ¬Pl(y), ¬J(alan), ¬Pr(y)}	5						s3 = {}
{¬Pl(y), ¬J(alan), ¬Pr(y)}				6						s4 = {}
{¬Pl(y), ¬Pr(y)}						3 						s5 = {p <- y}
{¬Pr(y)}								4 						s6 = {y <- ej}
{}

como se llega a la clausula vacia, se logro demostrar lo que se deseaba











