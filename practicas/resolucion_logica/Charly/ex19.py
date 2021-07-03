a)
prefiero hacerlo bien sin buscar errores 


b)

teorema del bebedor
(∃X enBar(X)) ⊃ ∃Y (enBar(Y) ∧ (bebe(Y) ⊃ ∀Z(enBar(Z) ⊃ bebe(Z))))

intentaremos refutar la negacion
¬((∃X enBar(X)) ⊃ ∃Y (enBar(Y) ∧ (bebe(Y) ⊃ ∀Z(enBar(Z) ⊃ bebe(Z)))))

pasar a FNN:

eliminar implicaciones
¬(¬(∃X enBar(X)) v ∃Y (enBar(Y) ∧ (¬bebe(Y) v ∀Z(¬enBar(Z) v bebe(Z)))))

de morgan
(∃X enBar(X)) ^ ¬∃Y (enBar(Y) ∧ (¬bebe(Y) v ∀Z(¬enBar(Z) v bebe(Z))))

negar existe
(∃X enBar(X)) ^ ∀Y ¬(enBar(Y) ∧ (¬bebe(Y) v ∀Z(¬enBar(Z) v bebe(Z))))

de morgan
(∃X enBar(X)) ^ ∀Y (¬enBar(Y) v ¬(¬bebe(Y) v ∀Z(¬enBar(Z) v bebe(Z))))

de morgan
(∃X enBar(X)) ^ ∀Y (¬enBar(Y) v (bebe(Y) ^ ¬∀Z(¬enBar(Z) v bebe(Z))))

negar paratodo
(∃X enBar(X)) ^ ∀Y (¬enBar(Y) v (bebe(Y) ^ ∃Z¬(¬enBar(Z) v bebe(Z))))

de morgan
(∃X enBar(X)) ^ ∀Y (¬enBar(Y) v (bebe(Y) ^ ∃Z(enBar(Z) ^ ¬bebe(Z))))

pasar a FNP:
∃X.∀Y.∃Z.(enBar(X)) ^ (¬enBar(Y) v (bebe(Y) ^ (enBar(Z) ^ ¬bebe(Z))))

skolemizar

eliminar X
∀Y.∃Z.(enBar(ebrio)) ^ (¬enBar(Y) v (bebe(Y) ^ (enBar(Z) ^ ¬bebe(Z))))

eliminar Z
∀Y.(enBar(ebrio)) ^ (¬enBar(Y) v (bebe(Y) ^ (enBar(persona(Y)) ^ ¬bebe(persona(Y)))))

llevar a FC:

distribuir disyuncion
∀Y.(enBar(ebrio)) ^ (((¬enBar(Y) v bebe(Y)) ^ ((¬enBar(Y) v enBar(persona(Y))) ^ (¬enBar(Y) v ¬bebe(persona(Y))))))

formula asociativa (eliminar parentesis)
∀Y.((enBar(ebrio)) ^ (¬enBar(Y) v bebe(Y)) ^ (¬enBar(Y) v enBar(persona(Y))) ^ (¬enBar(Y) v ¬bebe(persona(Y))))

distribuir cuantificador universal
∀Y.(enBar(ebrio)) ^ ∀Y.(¬enBar(Y) v bebe(Y)) ^ ∀Y.(¬enBar(Y) v enBar(persona(Y))) ^ ∀Y.(¬enBar(Y) v ¬bebe(persona(Y)))

se tiene las siguientes clausulas
1.{(enBar(ebrio))} 					definicion
2.{(¬enBar(X), bebe(X))} 			definicion
3.{(¬enBar(Y), enBar(persona(Y)))} 	definicion
4.{(¬enBar(Z), ¬bebe(persona(Z)))}	goal

procedemos a realizar una refutacion SLD:

goal									clausula de entrada		sustitucion
{(¬enBar(Z), ¬bebe(persona(Z)))}		1 						{Z <- ebrio}
{bebe(persona(ebrio))}					2  						{X <- persona(ebrio)}
{¬enBar(persona(ebrio))}				3  						{Y <- ebrio}
{¬enBar(ebrio)}							1  						{}
{}

como se llega a la clausula vacia, se logro demostrar lo que se deseaba











