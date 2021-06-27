i)

∃x.∃y.x < y, siendo < un predicado binario usado de forma infija.
∃x.∃y.P(x, y), esta en forma prenexa

eliminamos x
∃y.P(a, y)

eliminamos y
P(a, b) FNS y FC


ii)
prenexa
∀x.∃y.P(x, y)

eliminamos y
∀x.P(x, f(x)) FNS y FC


iii)

∀x.¬(P(x) ∧ ∀y.(¬P(y) ∨ Q(y)))

de morgan
∀x.(¬P(x) v ¬(∀y.(¬P(y) ∨ Q(y))))

no para todo <==> existe uno que no
∀x.(¬P(x) v ∃y.¬(¬P(y) ∨ Q(y)))

de morgan
∀x.(¬P(x) v ∃y.(P(y) ^ ¬Q(y))) FNN

extraemos el existe
∀x.∃y.(¬P(x) v (P(y) ^ ¬Q(y))) FP

eliminamos el existe
∀x.(¬P(x) v (P(f(x)) ^ ¬Q(f(x)))) FNS

pasamos la matriz a FNC
distribuimos disyuncion
∀x.((¬P(x) v P(f(x))) ^ (¬P(x) v ¬Q(f(x))))

distribuimos cuantificadores
(∀x.(¬P(x) v P(f(x))) ^ ∀x.(¬P(x) v ¬Q(f(x))))

escritura simplificada
{¬P(x), P(f(x))}, {¬P(x), ¬Q(f(x))}


iv)

∃x.∀y.(P(x, y) ∧ Q(x) ∧ ¬R(y)) FP

extraemos el existe
∀y.(P(a, y) ∧ Q(a) ∧ ¬R(y)) FNS

distribuimos cuantificadores
(∀y.(P(a, y)) ∧ ∀y.(Q(a)) ∧ ∀y.(¬R(y)))

escritura simplificada
({P(a, y)}, {Q(a)}, {¬R(y)})


v)
∀x.(P(x) ∧ ∃y.(Q(y) ∨ ∀z.∃w.(P(z) ∧ ¬Q(w))))

extraemos los cuantificadores # DUDA: se puede hacer tooodo esto en un solo paso?
∀x.∃y.∀z.∃w.(P(x) ∧ (Q(y) ∨ (P(z) ∧ ¬Q(w)))) FP

extraemos el existe
∀x.∀z.(P(x) ∧ (Q(f(x)) ∨ (P(z) ∧ ¬Q(g(x, z)))))

distribuimos disyuncion
∀x.∀z.(P(x) ∧ (Q(f(x)) ∨ P(z)) ∧ (Q(f(x)) ∨ ¬Q(g(x, z))))

distribuimos cuantificadores
∀x.∀z.(P(x)) ∧ ∀x.∀z.(Q(f(x)) ∨ P(z)) ∧ ∀x.∀z.(Q(f(x)) ∨ ¬Q(g(x, z)))

escritura simplificada
{P(x)}, {Q(f(x)), P(z)}, {Q(f(x)), ¬Q(g(x, z))}
































