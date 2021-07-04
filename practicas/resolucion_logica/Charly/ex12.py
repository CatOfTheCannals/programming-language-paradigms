i)
inicio
[∃x.∀y.R(x, y)] ⊃ ∀y.∃x.R(x, y)

negar para ver insatisfacibilidad
¬([∃x.∀y.R(x, y)] ⊃ ∀y.∃x.R(x, y))

eliminar implicacion
¬(¬[∃x.∀y.R(x, y)] v ∀y.∃x.R(x, y))

pasar a FNN:

de morgan
[∃x.∀y.R(x, y)] ^ ¬(∀y.∃x.R(x, y))

negar cuantificador ∀
[∃x.∀y.R(x, y)] ^ (∃y.(¬∃x.R(x, y)))

negar cuantificador ∃
[∃x.∀y.R(x, y)] ^ (∃y.(∀x.¬R(x, y)))

pasar a FNP:

renombrar variables para evitar colisiones
[∃x.∀y.R(x, y)] ^ (∃z.(∀w.¬R(w, z)))

extraer cuantificadores # DUDA: se puede hacer en un solo paso asi??
∃x.∀y.∃z.∀w.(R(x, y) ^ ¬R(w, z))



pasar a FNS:

remuevo ∃x
∀y.∃z.∀w.(R(a, y) ^ ¬R(w, z))

remuevo ∃z
∀y.∀w.(R(a, y) ^ ¬R(w, f(y)))

pasar a FC:
∀y.∀w.(R(a, y) ^ ∀y.∀w.¬R(w, f(y)))
{R(a, y)}, {¬R(w, f(y))}

unificar
{R(a, y1) = R(w, f(y2))} = {a/w, f(y2)/y1}

se obtiene la clausula vacia

ii)

inicio
[∀x.∃y.R(x, y)] ⊃ ∃y.∀x.R(x, y)

negar para ver insatisfacibilidad
¬([∀x.∃y.R(x, y)] ⊃ ∃y.∀x.R(x, y))

eliminar implicacion
¬(¬[∀x.∃y.R(x, y)] v ∃y.∀x.R(x, y))

pasar a FNN:

de morgan
[∀x.∃y.R(x, y)] ^ ¬[∃y.∀x.R(x, y)]

negar cuantificador ∃
[∀x.∃y.R(x, y)] ^ [∀y.¬∀x.R(x, y)]

negar cuantificador ∀
[∀x.∃y.R(x, y)] ^ [∀y.∃x.¬R(x, y)]

pasar a FNP:

renombrar variables para evitar colisiones
[∀x.∃y.R(x, y)] ^ [∀z.∃w.¬R(w, z)]

extraer cuantificadores # DUDA: se puede hacer en un solo paso asi??
∀x.∃y.∀z.∃w.(R(x, y) ^ ¬R(w, z))

pasar a FNS:

remuevo ∃y
∀x.∀z.∃w.(R(x, f(x)) ^ ¬R(w, z))

remuevo ∃w
∀x.∀z.(R(x, f(x)) ^ ¬R(g(x,z), z))

pasar a FC

distribuir cuantificadores
∀x.∀z.R(x, f(x)) ^ ∀x.∀z.¬R(g(x,z), z)

{R(x1, f(x1))}, {¬R(g(x2,z), z)}

unificar

{R(x1, f(x1)) = R(g(x2,z), z)} {f(x1)/z, g(x2,f(x1))/x1} falla por occur check


iii)
inicio
∃x.[P(x) ⊃ ∀x.P(x)]

negar para ver insatisfacibilidad
¬(∃x.[P(x) ⊃ ∀x.P(x)])

eliminar implicacion
¬∃x.[P(x) v ∀x.P(x)]

pasar a FNN:

negar cuantificador ∃
∀x.¬[P(x) v ∀x.P(x)]

de morgan
∀x.[¬P(x) ^ ¬∀x.P(x)]

negar cuantificador ∀
∀x.[¬P(x) ^ ∃x.¬P(x)]

pasar a FNP:

renombrar variables para evitar colisiones
∀y.[¬P(y) ^ ∃x.¬P(x)]

extraer cuantificador ∃
∀y.∃x.[¬P(y) ^ ¬P(x)]

pasar a FNS:

remuevo ∃x
∀y.[¬P(y) ^ ¬P(f(y))]

pasar a FC:

distribuir cuantificador
∀y.¬P(y) ^ ∀y.¬P(f(y))

resolucion
1. {¬P(y)}
2. {¬P(f(y))} # DUDA: aca el hecho de que ambos esten negados es un problema correcto?

	






























