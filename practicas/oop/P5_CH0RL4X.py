13)
	a) si, porque contesta exactamente los mismos mensajes

	b) no, porque difieren los mensajes

14)

o = [arg = ς(x)x, val = ς(x)x.arg]

a)
				______(obj)		_______________(obj)
				o --> o  		x{o/x} = o --> o
______(obj)     _____________________________________(sel)
o --> o 				x.arg{o/x} = o.arg --> o	DUDA: esta bien sacar el ς al usar sel??
_____________________________________________________(sel)
					o.val --> o


b) 
					
___________(ej a)	________________(obj)
o.val --> o 		x{o/x} = o --> o
_________________________________________(sel)
				o.val.arg --> o



c)
					
	______(obj)														_______(obj)		   _______(obj)
	o -> o 															v --> v 	  0{z/v} = 0 --> 0
_______________________________________________________(upd)		______________________________(sel)
(o.arg ⇐ ς(z)0) --> [arg = ς(z)0, val = ς(x)x.arg] = v 					x.arg{v/x} = v.arg --> 0
__________________________________________________________________________________________________(sel)
									(o.arg ⇐ ς(z)0).val --> 0


15)

o = [a = ς(x)(x.a <= ς(y)(y.a <= ς(z)[]))]




							______(obj)
							o -> o		
					   _________________________________(upd)		______(upd)
o -> o 		o.a{o/x} = (o.a <= ς(y)(y.a <= ς(z)[])) -> w 			w -> w 	
________________________________________________________(sel)	____________________________________(upd)
			o.a -> w = [a = ς(y)(y.a <= ς(z)[])]   			  	(y.a <= ς(z)[]){w/y} -> [a = ς(z)[]]
____________________________________________________________________________________________________(sel)
											o.a.a -> [a = ς(z)[]]



16)

a)
true = [
	not = ς(z)[
		not = z,
		if = (λa.(λb.b)),
		ifnot = (λa.(λb.a))
	],
	if = (λa.(λb.a)),
	ifnot = (λa.(λb.b))
]

false = true.not

b)

and = (λa. (λb. a.if(b.if(true)(false))(false)))
or = (λa. (λb. a.if(true)(b.if(true)(false) )))


17)

a)

origen = [
	x = 0,
	y = 0,
	mv = Ç(p)(λv.(λw.((p.y := p.y + w).x := p.x + v)))
]

b)

Punto = [
	new = Ç(z)[
		x = Ç(s)z.x(s)
		y = Ç(s)z.y(s)
		x = Ç(s)z.mv(s)
	],
	x = λs. 0,
	y = λs. 0,
	mv = λs. (λv.(λw.((s.y := s.y + w).x := s.x + v)))
]

c)


										 			p -> p
______________(obj)		_________________________________________________________________(obj)
Punto -> Punto			[x = Ç(s)Punto.x(s), y = Ç(s)Punto.y(s), x = Ç(s)Punto.mv(s)] = p  # DUDA: tendria que poner la definicion de los metodos aca?
__________________________________________________________________________________________________(sel)
					Punto.new -> 


d)

PuntoColoreado = [

	new = Ç(z)[
		x = Ç(s)z.x(s)
		y = Ç(s)z.y(s)
		x = Ç(s)z.mv(s)
		color = Ç(s)z.color(s)
	],
	x = Punto.x,
	y = Punto.y,
	mv = Punto.mv,
	color = λs. blanco 
	new_with_color = (λs. (λc. s.color := c)) # DUDA: esto esta bien??

]



























