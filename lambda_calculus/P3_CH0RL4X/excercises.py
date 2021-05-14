3)
i. 
MGU {t1 → t2 = Nat → Bool}
descomposicion
MGU {t1 = Nat, t2 = Bool}
eliminacion de variable
MGU {t2 = Bool}
eliminacion de variable
MGU {} √
S = {Nat/t1, Bool/t2}

ii.
MGU {t1 → t2 = t3}
eliminacion de variable
MGU {}
S = {(t1 → t2)/t3}

iii. falla por occur check

iv. 
MGU {(t2 → t1) → Bool .= t2 → t3}
descomposicion
MGU {(t2 → t1) = t2, Bool = t3}
falla por occur check

v. 
MGU {t2 → t1 → Bool = t2 → t3}
descomposicion
MGU {t2 = t2, t1 → Bool = t3}
eliminacion de par trivial
MGU {t1 → Bool = t3}
eliminacion de variable
MGU {} √
S = {(t1 → Bool)/t3}

vi.
MGU {t1 → Bool = Nat → Bool, t1 = t2 → t3}
descomposicion
{t1 = Nat, Bool = Bool, t1 = t2 → t3}
eliminacion de variable
{Bool = Bool, Nat = t2 → t3}
descomposicion
{Nat = t2 → t3}
eliminacion de variable
{} √
S = {Nat/t1, (t2 → t3)/Nat}

vii.
MGU {t1 → Bool = Nat → Bool, t2 = t1 → t1}
descomposicion
{t1 = Nat, Bool = Bool, t2 = t1 → t1}
eliminacion de variable
{Bool = Bool, t2 = Nat → Nat}
descomposicion
{t2 = Nat → Nat}
eliminacion de variable
{} √
S = {Nat/t1, Nat → Nat/t2}

viii.
MGU {t1 → t2 = t3 → t4, t3 = t2 → t1}
descomposicion
{t1 = t3, t2 = t4, t3 = t2 → t1}
eliminacion de variable
{t2 = t4, t3 = t2 → t3}
eliminacion de variable
{t3 = t4 → t3}
falla por occur check

S = {t3/t1, t4/t2}


6)

i.

λx. λy. λz. (z x) y z
	
	λy. λz. (z x) y z

		λz. (z x) y z

			(z x) y z
			S = MGU({t6 = t4 -> t7, t4 = t2 -> t3 -> t6}) FALLA POR OCCUR CHECK

				(z x) y
				S = MGU({t5 = t3 -> t6})
				W = {z : t2 -> t3 -> t6, x : t2, y : t3} > (z x) y : t6

					(z x)
					S = MGU({t1 = t2 -> t5})
					W = {z : t2 -> t5, x : t2} > (z x) : t5

						z
						W = {z : t1} > z : t1

						x
						W = {x : t2} > x : t2

					y
					{y : t3} > y : t3

				z
				{z : t4} > z : t4



ii. 
λx. x (w (λy.w y))

	x (w (λy.w y))

		(w (λy.w y))
		S = MGU({t4 = t2 -> t3 -> t5, t4 = t2 -> t3}) FALLA POR OCCUR CHECK

			(λy.w y)
			W = {w : t2 -> t3} > λy:t2.w y : t2 -> t3
				w y
				S = MGU({t1 = t2 -> t3})
				W = {w : t2 -> t3, y : t2} > (w y) : t3
					w
					W = {w : t1} > w : t1

					y
					W = {y : t2} > y : t2

			w
			W = {w : t4} > w : t4

		x


iii.

λx. λy. xy
W = ø > (λx:t2 -> t3. (λy:t2. xy))
	λy. xy
	W = {x : t2 -> t3} > λy:t2. xy
		xy
		S = MGU({t1 = t2 -> t3})
		W = {x : t2 -> t3, y : t2} > xy : t3
			x
			W = {x : t1} > x : t1

			y
			W = {y : t2} > y : t2


v.

λx.(λx. x)
W = {x : t2} > λx:t2.(λx:t1. x) : t2 -> t1 -> t1
	λx. x
	W = ø > λx:t1. x : t1 -> t1
		x
		W = {x : t1} > x : t1


7) 
	σ tiene que ser una funcion cuyo dominio y codominio coinciden
	τ tiene que ser un input valido para funciones de tipo σ
	DUDA: esta bien decir σ : t -> t , τ : t

9) DUDA: lo hice bien?
i.
W(<M,N>) = SΓ1 ∪ SΓ2 > S<M,N> : St
W(M) = Γ1 > M : σ
W(N) = Γ2 > N : τ
S = MGU({t = σ x τ} U {ß1 = ß2 | x : ß1 € Γ1, x : ß2 € Γ2})

ii.

(λf.h<f,2>) (λx.x 1)
W((λf.h<f,2>) (λx.x 1)) = {h : ((Nat -> t2) -> t2) x Nat -> t6} > (λf.h<f,2>) (λx.x 1) : t6
S = MGU({t3 -> t5 = ((Nat -> t2) -> t2) -> t6})
S = MGU({t3 = ((Nat -> t2) -> t2),  t5 = t6})
s = {((Nat -> t2) -> t2)/t3, t6/t5}

	(λf.h<f,2>)
	W(λf.h<f,2>) = {h : t3 x Nat -> t5} > λf:t3. h<f,2> : t3 -> t5

		h<f,2>
		W(h<f,2>) = {h : t3 x Nat -> t5, f : t3} > h<f,2> : t5
		S = MGU({t4 = t3 x Nat -> t5})
			h
			W(h) = {h : t4} > h : t4

			<f,2>
			W(<f,2>) = {f : t3} > <f,2> : t3 x Nat

				f
				W(f) = {f : t3} > f : t3

				2 == succ(succ(0))
				W(succ(succ(0))) = ø > succ(succ(0)) : Nat
				W(succ(0)) = ø > succ(0) : Nat
				W(0) = ø > 0 : Nat

	(λx.x 1)
	ø > λx:Nat -> t2. x 1 : (Nat -> t2) -> t2
		x 1
		W(x 1) = {x : Nat -> t2} > x 1 : t2
		S = MGU({t1 = Nat -> t2})
			x
			W(x) = {x : t1} > x : t1

			1 == succ(0)
			W(succ(0)) = ø > succ(0) : Nat
			W(0) = ø > 0 : Nat
			S = MGU({Nat = Nat})

iii.

(λf.<f 2, f True>) (λx.x)

	(λf.<f 2, f True>)

		<f 2, f True>
		W(<f 2, f True>) = 
		S = MGU({t5 = t4 x t2} U {Nat -> t4 = Bool -> t2}) FALLA por colision

			f 2
			W(f 2) = {f : Nat -> t4} > f 2 : t4
			S = MGU({t3 = Nat -> t4})
				f
				W(f) = {f : t3} > f : t3

				2 == succ(succ(0))
				W(succ(succ(0))) = ø > succ(succ(0)) : Nat
				W(succ(0)) = ø > succ(0) : Nat
				W(0) = ø > 0 : Nat


			f True
			W(f True) = {f : Bool -> t2} > f True : t2
			S = MGU({t1 = Bool -> t2})

				f
				W(f) = {f : t1} > f : t1

				True
				W(True) = ø > True : Bool

	(λx.x)

		x
