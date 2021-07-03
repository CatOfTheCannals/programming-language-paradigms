podemos escribir "el pronostico se equivoco" como (p ^ ¬l) v (¬p ^ l)

entonces tenemos nuestras condiciones logicas
p ⊃ a ^ ¬p ⊃ c ^ ¬(a ^ c)

y los hechos reales
a ^ ¬l


¬p v a
p v c
¬a v ¬c
a
¬l

¬((p ^ ¬l) v (¬p ^ l))
¬(p ^ ¬l) ^ ¬(¬p ^ l)
(¬p v l) ^ (p v ¬l)

nuestro objetivo es demostrar que el pronostico se equivoco a partir de las reglas y los hechos
((p ⊃ a) ^ (¬p ⊃ c) ^ ¬(a ^ c) ^ a ^ ¬l) ⊃ ((p ^ ¬l) v (¬p ^ l))

simplificamos las implicaciones
¬((¬p v a) ^ (p v c) ^ ¬(a ^ c) ^ a ^ ¬l) v ((p ^ ¬l) v (¬p ^ l))

si la negacion de la formula es insatisfacible, entonces la formula es valida
¬(¬((¬p v a) ^ (p v c) ^ ¬(a ^ c) ^ a ^ ¬l) v ((p ^ ¬l) v (¬p ^ l)))

a partir e aca vamos a llevar la formula negada a su FNC

de morgan
((¬p v a) ^ (p v c) ^ ¬(a ^ c) ^ a ^ ¬l) ^ ¬((p ^ ¬l) v (¬p ^ l))

PELIGRO:este paso inventa negaciones que rompen!!!

de morgan
(¬(¬p v a) v ¬(p v c) v (a ^ c) v ¬a v l) ^ (¬(p ^ ¬l) ^ ¬(¬p ^ l))

de morgan
((p ^ ¬a) v (¬p ^ ¬c) v (a ^ c) v ¬a v l) ^ (¬p v l) ^ (p v ¬l)

distributiva
(((p v (¬p ^ ¬c)) ^ (¬a v (¬p ^ ¬c))) v (a ^ c) v ¬a v l) ^ (¬p v l) ^ (p v ¬l)

distributiva
((((p v ¬p) ^ (p v ¬c)) ^ (¬a v (¬p ^ ¬c))) v (a ^ c) v ¬a v l) ^ (¬p v l) ^ (p v ¬l)

distributiva
((((p v ¬p) ^ (p v ¬c)) ^ (((¬a v ¬p) ^ (¬a v ¬c)))) v (a ^ c) v ¬a v l) ^ (¬p v l) ^ (p v ¬l)

metemos parentesis para ayudarnos a aplicar una distributiva mas en la direccion correcta
((((p v ¬p) ^ (p v ¬c)) ^ (((¬a v ¬p) ^ (¬a v ¬c)))) v (a ^ c) v (¬a v l)) ^ (¬p v l) ^ (p v ¬l)

distributiva
((((p v ¬p) ^ (p v ¬c)) ^ (((¬a v ¬p) ^ (¬a v ¬c)))) v ((a v (¬a v l)) ^ (c v (¬a v l)))) ^ (¬p v l) ^ (p v ¬l)

distributiva
(
	(((p v ¬p) ^ (p v ¬c)) v ((a v (¬a v l)) ^ (c v (¬a v l)))) ^ 

	((((¬a v ¬p) ^ (¬a v ¬c))) v ((a v (¬a v l)) ^ (c v (¬a v l))))
) 
^ (¬p v l) ^ (p v ¬l)


me dio fiacaaaa

























