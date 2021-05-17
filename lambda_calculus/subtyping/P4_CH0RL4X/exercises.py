2)

a) 
infinitos subtipos
	- Top 
	- cualquier registro
	- abstracciones cuyo resultado tiene infinitos subtipos
		esto funciona porque las funciones son variantes en su resultado

b)
infinitos supertipos
	- abstracciones cuyo argumento tiene infinitos subtipos
		esto funciona porque las funciones son contravariantes en su argumento

4)
a) 
Falso 
	sean T = Nat y S = Int

	tenemos Int -> Nat <: A -> A <==> Int <: A ^ A <: Nat 
	lo cual es un absurdo

b) 
Falso
	sean S = Top, T = Top
	entonces {x: S, y : T} tiene como supertipos a {y : T, x : S}, {x : S}, {y : T} y {}
	pero una funcion de tipo Top -> Top tiene infinitos supertipos U -> Top / U <: Top

c)
Falso
	sean S = Top, T = Bool
	entonces {x: S, y : T} tiene como supertipos a 
		{y : T, x : S}, {x : S}, {y : T}, {}, {{x : S, y : U} | Bool <: U} y {{y : U, x : S} | Bool <: U}
		estos conjuntos son finitos, porque Bool tiene una cantidad finita de supertipos

	pero una funcion de tipo Top -> Bool tiene infinitos supertipos U -> Bool / U <: Top 

5)

	R = {x : Nat, y: Nat}
	S = {x : Nat}
	T = {y : Nat}

7)
a) 
ø > λx: Bool.(λy : Nat.suc(y)) x : µ

	t-abs
	{x : Bool} > (λy : Nat.suc(y)) x : Bool -> ¥, con µ = Bool -> ¥

		t-app

		{x : Bool} > (λy : Nat.suc(y)) : Bool -> ¥
			t-sub

			{x : Bool} > (λy : Nat.suc(y)) : Nat -> ¥
				t-abs
				{x : Bool, y : Nat} > suc(y) : ¥, con ¥ = Nat
					t-succ
					{x : Bool, y : Nat} > y : Nat
						t-var
						(y : Nat) € {y : Nat} √


			Nat -> ¥ <: Bool -> ¥
				s-arrow

				Bool <: Nat
					s-boolNat √

				¥ <: ¥
					s-refl √


		{x : Bool} > x : Bool
			t-var
			(x : Bool) € {x : Bool} √

conclusion, el programa es de tipo µ = Bool -> Nat

b)
ø > (λr : {l1 : Bool, l2 : Float}.if r.l1 then r.l2 else 5,5) {l1 = true, l2 = −8, l3 = 9,0} : µ

	t-app

	ø > (λr : {l1 : Bool, l2 : Float}.if r.l1 then r.l2 else 5,5) : ¥ -> µ

		t-abs
		{r : {l1 : Bool, l2 : Float}} > if r.l1 then r.l2 else 5,5 : µ, con ¥ = {l1 : Bool, l2 : Float}

			t-ifThenElse

			{r : {l1 : Bool, l2 : Float}} > r.l1 : Bool
				DUDA: aca hay que usar t-proj?? como se hace??

			{r : {l1 : Bool, l2 : Float}} > r.l2 : µ
				DUDA: idem arriba

			{r : {l1 : Bool, l2 : Float}} > 5,5 : µ, con µ = Float
				t-floatCincoYMedio √

	ø > {l1 = true, l2 = −8, l3 = 9,0} : ¥ = {l1 : Bool, l2 : Float}

		t-sub
		
		ø > {l1 = true, l2 = −8, l3 = 9,0} : {l1 : Bool, l2 : Int, l3 : Float}
			t-rcd

			ø > true : Bool
				t-true √

			ø > -8 : Int
				t-intOcho √ (asumo que esto esta probado)

			ø > 9,0
				t-floatNueve √

		{l1 : Bool, l2 : Int, l3 : Float} <: {l1 : Bool, l2 : Float}
			s-rcd
			{l1, l2} C= {l1, l2, l3} √ DUDA: esta bien escrito asi?

			Bool <: Bool # caso l1 √

			Int <: Float # caso l2
				s-intFloat √


9)
a)
Propongo:
(λf : Int -> Int. f 2) (λs : Float. 0.5 + s)

Si uno intenta evaluar la expresion, va a terminar tratando pasarle un Int a una funcion que toma floats.
En esta funcion se va a realizar una operacion que no esta definida para los Int''s

ø > (λf : Int -> Int. f 2) (λs : Float. 0.5 + s) : µ
	t-app

	ø > (λf : Int -> Int. f 2) : (Int -> Int) -> µ
		t-abs
		{f : Int -> Int} > f 2 : µ, con ¥ = Int -> Int
			t-app
			{f : Int -> Int} > f : Int -> µ, con µ = Int
				t-var
				(f : Int -> Int) € {f : Int -> Int} √

	ø > (λs : Float. 0.5 + s) : Int -> Int
		t-sub

		ø > (λs : Float. 0.5 + s) : Float -> Float
			t-abs
			{s : Float} > 0.5 + s : Float
				t-+
				{s : Float} > 0.5 : Float
					t-half √

				{s : Float} > s : Float
					t-var
					(s : Float) € {s : Float}

		Float -> Float <: Int -> Int
			s-arrow''

			Int <: Float 
				s-intFloat √

			Int <: Float 
				s-intFloat √

11)
a)
ø > λc : Comp{x:Int}. mejorSegún(c, {x = 1, y = 2}, {x = 0}) : Comp{x:Int} -> Bool
	t-abs
	{c : Comp{x:Int}} > mejorSegún(c, {x = 1, y = 2}, {x = 0}) : Bool
		t-comp

		{c : Comp{x:Int}} > c : Comp{x:Int}
			t-var
			(c : Comp{x:Int}) € {c : Comp{x:Int}} √

		{c : Comp{x:Int}} > {x = 1, y = 2} : {x:Int}
			t-sub
			{x = 1, y = 2} : {x : Int, y : Int}
				t-rcd
				1 : Int # x
					t-intUno √
				2 : Int # y
					t-intDos √

			{x : Int, y : Int} <: {x : Int}			
				s-rcdWidth √

		{c : Comp{x:Int}} > {x = 0} : {x:Int}
			t-rcd
				0 : Int # x
					t-intZero √

b)
si compσ fuera covariante entonces, dado µ / σ <: µ, se tendria que compσ <: compµ
esto significaria, por ejemplo, que donde se usa compFloat se puede usar compBool.
pero esto implicaria que se pasen floats donde se esperan bools, lo cual va a romper.

veamos si podemos probar que compσ es contravariante.

µ / σ <: µ, se tendria que compµ <: compσ
esto significa que donde se puede usar compσ, se puede usar compµ
Aca no deberiamos tener problemas, porque todas las operaciones que use compµ, esperan al tipo µ.
Dado que σ <: µ, estas operaciones se podran usar con elementos de tipo σ.

Por lo tanto nos convencemos de que comp es contravariante. Llamaremos s-comp a esta regla.

s-comp
σ <: µ <==> compµ <: compσ

c)
ø > λc : CompFloat.(λx: CompNat.mejorSegún(x, 3, 4)) c : CompFloat -> Bool
	t-abs
	{c : CompFloat} > (λx: CompNat.mejorSegún(x, 3, 4)) c : Bool
		t-app

		{c : CompFloat} > (λx: CompNat.mejorSegún(x, 3, 4)) : CompFloat -> Bool
			t-sub

			{c : CompFloat} > (λx: CompNat.mejorSegún(x, 3, 4)) : CompNat -> Bool
				t-abs
				{c : CompFloat, x : CompNat} > mejorSegún(x, 3, 4) : Bool
					t-comp
					{c : CompFloat, x : CompNat} > x : CompNat
						t-var
						(x : CompNat) € {x : CompNat}

					3 : Nat √

					4 : Nat √

			CompNat -> Bool <: CompFloat -> Bool
				s-arrow
				CompFloat <: CompNat
					s-comp
					Nat <: Float
						s-trans
						Nat <: Int 
							s-natInt √
						Int <: Float
							s-intFloat √

				Bool <: Bool
					s-refl √

		{c : CompFloat} > c : CompFloat
			t-var
			(c : CompFloat) € {c : CompFloat} √
