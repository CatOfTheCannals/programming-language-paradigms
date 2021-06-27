Pago(x)
Espia(x)
smullyan
jefeGob


se tienen los siguientes hechos

(Pago(smullyan) ^ ¬Pago(smullyan))

se quiere ver que se puede demostrar Espia(jefeGob)

escribimos
(Pago(smullyan) ^ ¬Pago(smullyan)) => Espia(jefeGob)

eliminamos implicacion
¬(Pago(smullyan) ^ ¬Pago(smullyan)) v Espia(jefeGob)

de morgan
(¬Pago(smullyan) v Pago(smullyan) v Espia(jefeGob)

pasamos a FC
{¬Pago(smullyan), Pago(smullyan), Espia(jefeGob)}

# DUDA: como hago un paso de unificacion si no hay conjunciones??






























