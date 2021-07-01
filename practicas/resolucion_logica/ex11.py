Pago(x)
Espia(x)
smullyan
jefeGob


se tienen los siguientes hechos

(Pago(smullyan) ^ ¬Pago(smullyan))

se quiere ver que se puede demostrar Espia(jefeGob)

escribimos
(Pago(smullyan) ^ ¬Pago(smullyan)) => Espia(jefeGob)

negamos
¬((Pago(smullyan) ^ ¬Pago(smullyan)) => Espia(jefeGob))

eliminamos implicacion
¬(¬(Pago(smullyan) ^ ¬Pago(smullyan)) v Espia(jefeGob))

de morgan
(Pago(smullyan) ^ ¬Pago(smullyan)) ^ ¬Espia(jefeGob)

forma clausal:
1. {Pago(smullyan)}
2. {¬Pago(smullyan)}
3. {¬Espia(jefeGob)}

resolucion
tomamos 1 y 2
se obtiene un resolvente vacio, con lo cual logramos mandar en cana al jefe de gobierno




























