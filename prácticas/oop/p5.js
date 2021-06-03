//1)

let c1i = {r:1, i:1};

c1i.sumar = function(c) {
	return {r: this.r + c.r, i: this.i + c.i, sumar: this.sumar};
};

let o = {a: function(){return this;}};



//e) Obviamente es indefinido evaluar c1i.restar(c)

let c = c1i.sumar(c1i);
c.restar = function(another_c){
	return {r: this.r - another_c.r, i: this.i - another_c.i, sumar: this.sumar, restar: this.restar}
};


//f) También está indefinido si se agregó después de crearse el objeto

c1i.mostrar = function(){
	return this.r + "+" + this.i + "i";
}



//2)

//a) PREGUNTA: Se pueden usar funciones flecha?

let t = {ite: (a, b) => a};
let f = {ite: (a, b) => b};

//b) Idem a)

t.mostrar = () => "Verdadero";
f.mostrar = () => "Falso";

//c)

t.not = () => f;
f.not = () => t;

t.and = (boolean_variable) => boolean_variable;
f.and = (boolean_variable) => f;



//3)

//a), b) y c)

let zero = {
			esCero: true, 
			toNumber: 0,
			number_for: function(eval_function){return;}, 
			succ: function() 	{return {
											esCero: false, 
											toNumber: 1+this.toNumber,
											succ: this.succ, 
											pred: this,
											number_for: function(eval_function){
												this.pred.number_for(eval_function);
												eval_function.eval(this);
												return;
											}
										};
								}
			};


let f_eval = {eval: function(i){console.log(i.toNumber)}};



//4)

//a)

let Punto = {
				new: function(x,y)	{
										let res = {x: x, y: y};
										Object.setPrototypeOf(res, this);
										return res;
									},

				mostrar: function(){
										return "Punto(" + this.x + ", " + this.y + ")";
									}
			};


//b)
let PuntoColoreado = 	{
							new: function(x,y)	{
															Object.setPrototypeOf(this, Punto);
															let res = Object.getPrototypeOf(this).new(x,y); //Asqueroso => PREGUNTA: se puede hacer mejor?
															res.color = "Rojo";
															Object.setPrototypeOf(res, this);
															return res;
														}
						};

//c)

PuntoColoreado.new_with_color = function(x,y,color) {

	let res = this.new(x,y);
	res.color = color;
	return res;

};

//d)

//Todos pueden responder moverX ya que tienen todos como prototipo a Punto (los coloreados llegan en dos pasos).

let p1 = Punto.new(1, 2);
let pc1 = PuntoColoreado.new(1, 2);
Punto.moverX = function(unidades){
	this.x += unidades;
};
let p2 = Punto.new(1, 2);
let pc2 = PuntoColoreado.new(1, 2);



//5)

function Punto_constructor(x,y){
	this.x = x;
	this.y = y;
};

Punto_constructor.prototype.mostrar = function() {return "Punto(" + this.x + ", " + this.y + ")";};

function PuntoColoreado_constructor(x,y){
	Object.setPrototypeOf(this, Punto_constructor.prototype);
	let res = new Punto_constructor(x,y);
	res.color = "Rojo";
	return res; 
};

// PREGUNTA: Se puede modificar lo el prototype del anterior para conseguir el argumento extra? 
function PuntoColoreado_constructor_triple(x, y, color){
	let res = new PuntoColoreado_constructor(x, y);
	res.color = color;
	return res;
};


Punto_constructor.prototype.moverX = function(unidades) {this.x += unidades;};



//6)

//a)

let c1 = { 	val : 1, avanzar : function () { this.val ++;} ,avanzarSi : function (cond){if(cond) this.avanzar();}}; 
//c1 = {1, avanzar: ..., avanzarSi: ...} | c2 = undefined
let c2 = Object.create (c1);
//c1 = {1, avanzar: ..., avanzarSi: ...} | c2 = {1, avanzar: ..., avanzarSi: ...}
c2.avanzar = function () { this.val *= 2;};
//c1 = {1, avanzar: ..., avanzarSi: ...} | c2 = {1, avanzar: function() {this.val +=2;}, avanzarSi: ...}
c1.avanzar() ;
//c2 = {2, avanzar: ..., avanzarSi: ...} | c2 = {2, avanzar: function() {this.val +=2;}, avanzarSi: ...}
c2.avanzarSi(true);
//c2 = {2, avanzar: ..., avanzarSi: ...} | c2 = {4, avanzar: function() {this.val +=2;}, avanzarSi: ...}
c1.avanzarSi(true); // IMPORTANTE: no modifica c2 porque el avanzarSi previo definió c2.val de forma implícita al sumale 2 
					// En this,val = this.val + 2 el this.val a la izquierda del igual define el atributo en c2 y el otro accede al valor del prototipo
//c2 = {3, avanzar: ..., avanzarSi: ...} | c2 = {4, avanzar: function() {this.val +=2;}, avanzarSi: ...}


//b)

function Contador(modo_de_avance){
	this.val = 1;
	this.avanzar = function() {this.val = modo_de_avance(this.val);};
	this.avanzarSi = function(variable_booleana){if(variable_booleana) this.avanzar();};
};



//7)

function C1(){};
C1.prototype.g = "Hola";

function C2(){};
C2.prototype.g = "Mundo";

let a = new C1(); // a.g = "Hola"

//a) C1.prototype = C2.prototype; // Acá se asigna C1.prototype con C2.prototype pero no modifica los objetos ya creados PREGUNTA: por qué?

//b_1) C1.prototype.g = C2.prototype.g; // Acá sí se modifica el resultado de a => Es esperado ya que se modifica el atributo g en el prototipo de a y b que es C1.prototype

Object.setPrototypeOf(C1,C2); // Acá es evidente el motivo por el que ambos devuelven "Hola" => C1 queda antes en la cadena de prototipos 
							  // a y b ----> C1 ----> C2 ----> Object ----> Null


let b = new C1(); // b.g = "Mundo"

console.log(a.g); // a.g = "Hola" => a.prototype es C1.prototype ?????????????
console.log(b.g); // b.g = "Mundo" => b.prototype es C1.prototype que es C2.prototype



//8)

let o1 = {x: 1};
let o2 = Object.create(o1);
Object.getPrototypeOf(o2).y = 2;
console.log(o1.y); // Esto loguea un 2 => El object create establece a o1 como prototipo de o2 


let o1_bis = {x: 1};
let o2_bis = {y: 2};
Object.getPrototypeOf(o1_bis).z = 3;
console.log(o2_bis.z) // Esto loguea un 3 => o1_bis y o2_bis comparten prototipo (Object) y se modifica agregándole el atributo z



//9) 

//a)

let o_tris = {a:1 , b: function (x){ return x+a; }};
let o1_tris = Object.create (o_tris);
o1_tris.c = true ;
let a_array = new Array;
let b_array = new Array;
for (k in o1_tris) {a_array.push(k); b_array.push(o1_tris[k]);}; // a = ["c", "a", "b"] | b = [true, 1, function(x){return x+a;}]

console.log(a_array);
console.log(b_array);


//b)

function extender(obj_1, obj_2){
	for(k in obj_1) {if(!(k in obj_2)) obj_2[k] = obj_1[k]; };
};


//c)

A = {
		inicializar : function (n,a) { this.nombre = n; this.apellido = a; this; },
		presentar : function () { return this.nombre +" " + this.apellido; }
	};

B = Object.create( A );
B.saludar = function () { alert( " Hola " + this.presentar() + "." ); };


let juan = Object.create(A); juan.inicializar( " Juan ", "Pérez ");
let pedro = Object.create(B); pedro.inicializar( " Pedro ", "Juárez ");

B.presentar = A.presentar;
delete A.presentar;


//d)

A_constr = function(){};
A_constr.prototype.inicializar = function(n,a){this.nombre = n; this.apellido = a; this;};
A_constr.prototype.presentar = function(){return this.nombre +" " + this.apellido;};

B_constr = function(){};
Object.setPrototypeOf(B_constr.prototype, A_constr.prototype);
B_constr.prototype.presentar = A_constr.prototype.presentar;
delete A_constr.prototype.presentar;


let juan_constr = new A_constr(); juan_constr.inicializar( " Juan ", "Pérez ");
let pedro_constr = new B_constr(); pedro_constr.inicializar( " Pedro ", "Juárez ");



//10)

let vacia = {esVacia: true, cons: function(o){return {esVacia: false, head: o, tail: this, cons: this.cons};}};



//11)

function Mensajero(remitente, destinatario, mensaje){
	let respuesta_del_destinatario = (mensaje in destinatario) ? destinatario[mensaje] : mensaje;
	return (respuesta_del_destinatario in remitente) ? remitente[respuesta_del_destinatario] : respuesta_del_destinatario;
};

let objeto_remitente = {1: "b"};
let objeto_destinatario = {a: 1};



//12)

function InfiniteSequence(){
	this.val = 1;
	this.next = function(){
		let res = new InfiniteSequence();
		res.val = this.val + 1;
		return res;
	}
};





