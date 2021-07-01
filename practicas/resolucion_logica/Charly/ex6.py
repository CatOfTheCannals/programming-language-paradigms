i)
	inicio
	{f(x, x, y) = f(a, b, z)}

	descomposicion
	{x = a, x = b, y = z}

	eliminacion de variable

	{a/x} {a = b, y = z} COLISION


ii)
	inicio
	{f(x) = y}

	swap
	{y = f(x)}

	eliminacion de variable
	{f(x)/y}	


iii)
	inicio
	{f(g(c, y), x) = f(z, g(z, a))}

	descomposicion
	{g(c, y) = z, x = g(z, a)}

	eliminacion de variable
	{g(z, a)/x} {g(c, y) = z}

	swap
	{g(z, a)/x} {z = g(c, y)}

	eliminacion de variable
	{g(z, a)/x, g(c, y)/z}


fiaca de seguir




























