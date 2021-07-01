i)
p ⊃ p o sea, p => p
eliminamos implicacion
FNC: p v (¬p) 
FC: {p, ¬p}


ii)
(p ∧ q) ⊃ p
eliminamos implicacion
¬(p ∧ q) v p
aplicamos de morgan
(¬p v ¬q) v p
FNC: ¬p v ¬q v p
FC: {¬p, ¬q, p}

iii)
(p ∨ q) ⊃ p
eliminamos implicacion
¬(p ∨ q) v p
aplicamos de morgan
(¬p ^ ¬q) v p
distribuimos disyuncion
FNC: (¬p v p) ^ (¬q v  p)
FC: {¬p, p}, {¬q, p}

iv)
¬(p ⇔ ¬p)
eliminamos sii
¬((p ^ ¬p) v (¬p ^ p))
de morgan
¬(p ^ ¬p) ^ ¬(¬p ^ p)
de morgan
(¬p v p) ^ (p v ¬p)
eliminamos clausula redundante # DUDA: esto vale?
FNC: (¬p v p)
FC: {¬p, p}































