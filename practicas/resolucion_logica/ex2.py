i)
FNC: p v (¬p) 
FC: {p, ¬p}
negamos
{¬p}, {p}
el resolvente es []
la formula original es tutologia


ii)
FNC: ¬p v ¬q v p
FC: {¬p, ¬q, p}
negamos
{p}, {q}, {¬p}
resolvente de p y ¬p es []
es tautologia


iii)
FNC: (¬p v p) ^ (¬q v  p)
FC: {¬p, p}, {¬q, p}
negamos
(p ^ ¬p) v (q ^ ¬p)
distribuimos
((p v (q ^ ¬p)) ^ (¬p v (q ^ ¬p)))
distribuimos
((p v q ) ^ (p  v ¬p)) ^ ((¬p v q) ^ (¬p v ¬p))
FC: {p, q}, {p, ¬p}, {¬p, q}, {¬p, ¬p}
resolvente de  {p, q} y {¬p, q} es {q}
{p, q}, {p, ¬p}, {¬p, q}, {¬p, ¬p}, {q}
resolvente de  {p, ¬p} y {¬p, ¬p} es {¬p}
{p, q}, {p, ¬p}, {¬p, q}, {¬p, ¬p}, {q}, {¬p}
como no podemos calcular mas resolventes, no podemos afirmar que esta formula sea insatisfacible
con lo cual, la formula original no es tautologia. esto puede verse para el caso p = true ^ q = false


iv)
FNC: (¬p v p)
FC: {¬p, p}
negamos
p ^ ¬p
resolvente []
con lo cual la formula original es tautologia
