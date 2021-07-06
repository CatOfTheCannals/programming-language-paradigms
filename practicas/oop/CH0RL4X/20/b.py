																	______(obj)
																	w -> w  			
________(obj)		______(obj)			________(obj)	_________________________________(upd)
pc -> pc			w -> w  			pc -> pc		w.altura := (w.altura + 10) -> v
______________________________(sel)		__________________________________________________(app)
			pc.new -> w  									pc.crecer(w) -> v
__________________________________________________________________________________________(sel)
								pc.new.crecer -> v

*pc = plantaClass
*w = [altura = plantaClass.altura, crecer = Ç(t)plantaClass.crecer(t)]
*v = [altura = 20, crecer = Ç(t)plantaClass.crecer(t)]