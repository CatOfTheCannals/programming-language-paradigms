se tiene la siguiente base de conocimiento
1. {¬Progenitor(x1, y1), Descendiente(y1, x1)} 
2. {¬Descendiente(x2, y2), ¬Descendiente(y2, z2), Descendiente(x2, z2)}
3. {¬Abuelo(x3, y3), Progenitor(x3, medio(x3, y3))}
4. {¬Abuelo(x4, y4), Progenitor(medio(x4, y4), y4)}

se quiere demostrar que
∀x ∀y (Abuelo(x, y) ⊃ Descendiente(y, x))

para demostrarlo, refutaremos su negacion
¬∀x ∀y (Abuelo(x, y) ⊃ Descendiente(y, x))

negacion de cuantificadores
∃x ∃y ¬(Abuelo(x, y) ⊃ Descendiente(y, x))

negacion de implicacion
∃x ∃y (Abuelo(x, y) ^ ¬Descendiente(y, x))

skolemizar, obteniendo dos nuevas clausulas
(Abuelo(norberto, maxi) ^ ¬Descendiente(maxi, norberto))

se tiene las siguientes clausulas
1. {¬Progenitor(x1, y1), Descendiente(y1, x1)} 
2. {¬Descendiente(x2, y2), ¬Descendiente(y2, z2), Descendiente(x2, z2)}
3. {¬Abuelo(x3, y3), Progenitor(x3, medio(x3, y3))}
4. {¬Abuelo(x4, y4), Progenitor(medio(x4, y4), y4)}
5. {Abuelo(norberto, maxi)}
6. {¬Descendiente(maxi, norberto)}

resolucion
de 5 y 3, con {x3 <- norberto, y3 <- maxi}
7. {Progenitor(norberto, medio(norberto, maxi))}

de 1 y 7, con {x1 <- norberto, y1 <- medio(norberto, maxi)}
8. Descendiente(medio(norberto, maxi), norberto)

de 5 y 4, con {x4 <- norberto, y4 <- maxi}
9. {Progenitor(medio(norberto, maxi), maxi)}

de 1 y 9, con {x1 <- medio(norberto, maxi), y1 <- maxi}
10. {Descendiente(maxi, medio(norberto, maxi))}

de 2 y 10, con {x2 <- maxi, y2 <- medio(norberto, maxi)}
11. {¬Descendiente(medio(norberto, maxi, z2), Descendiente(maxi, z2)}

de 8 y 11, con {z2 <- norberto}
12. {Descendiente(maxi, norberto)}

de 6 y 12. con {}
{}

como se llega a la clausula vacia, se logro demostrar lo que se deseaba











