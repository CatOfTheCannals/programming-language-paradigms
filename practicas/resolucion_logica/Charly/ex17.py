se tiene las siguientes clausulas como base de conocimiento

1. {¬suma(x, y, z), suma(x, suc(y), suc(z))} 
2. {suma(w, cero, w)} 
3. {¬suma(u, u, v), par(v)}

a partir de ellas, queremos probar que vale
par(suc(suc(cero)))

para lo cual lo negaremos (esto viene de querer refutar ¬(conocimiento ==> hipotesis))
¬par(suc(suc(cero)))

esta ultima sera nuestra clausula goal, el resto seran clausulas de definicion

procedemos a realizar una refutacion SLD:

goal									clausula de entrada		sustitucion
{¬par(suc(suc(cero)))}					3  						s1 = {v <- suc(suc(cero))}
{¬suma(u, u, suc(suc(cero)))}			1 						s2 = {x <- succ(y), u <- succ(y), z <- suc(cero)}
{¬suma(suc(y), y, suc(cero))}			2 						s3 = {w <- suc(cero), y <- cero}
{}



















