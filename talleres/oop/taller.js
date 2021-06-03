/* TO DO: 
          Tal vez sacar código repetido de (1), (2) y (3)
          Agregar tests para ver que:
                                      el agente que dejó de espiar ya no puede responder al mensaje selectorDeTotal de la agencia que espiaba (revisar que estén todos los casos cubiertos)
                                      un agente de cualquier agencia puede espiar 
                                      un agente que espía dos veces puede volver a su agencia de origen
*/
AgenteDeControl = function(){
  this.agencia = "Control";
};

smart = new AgenteDeControl();

Agencia = function(programaDeEntrenamiento, selectorDeId, selectorDeTotal){
  
  this.programaDeEntrenamiento = programaDeEntrenamiento;
  
  // Dado que la cantidad total de agentes debe ser conocida por todos los agentes y su valor es el mismo para todos, 
  // se establece como un mensaje del prototipo de todos los agentes creados con this.programaDeEntrenamiento.
  this.programaDeEntrenamiento.prototype[selectorDeTotal] = 0;
  
  this.agenteAgregado = function(agente) {

    // Incrementa el total de agentes agregados
    this.programaDeEntrenamiento.prototype[selectorDeTotal] += 1;

    // Hace que el agente sepa responder al mensaje selectorDeId que usan los agentes creados con this.programaDeEntrenamiento 
    // y su valor (el número que identifica al agente) se corresponde con el nuevo total.
    agente[selectorDeId] = this.programaDeEntrenamiento.prototype[selectorDeTotal];
  };
  
  // Los mensajes espiar y dejarDeEspiar se agregan a this.programaDeEntrenamiento.prototype para que todos los agentes, 
  // independientemente de la agencia a la que pertenezcan, sepan responderlos.
  this.programaDeEntrenamiento.prototype.espiar = function(otraAgencia){
    
    // Guarda los valores originales si no estuvieran definidos ya (es decir, si el agente nunca hubiera espiado).
    if(!('agenciaOriginal' in this)){
      this.programaOriginal = programaDeEntrenamiento.prototype;
      this.agenciaOriginal = this.agencia;
    }

    // Modifica el prototipo. Esto hace que sea identificado como un agente de la otra agencia y pueda responder el total de agentes que hay ahí.
    Object.setPrototypeOf(this, otraAgencia.programaDeEntrenamiento.prototype); // (1) 
  
  };

  this.programaDeEntrenamiento.prototype.dejarDeEspiar = function(){
    // Restaura los valores originales. this vuelve a responder como lo hacía originalmente al mensaje agencia 
    // y al que utiliza su agencia original para obtener el número total de agentes. Además, deja de poder responder el total de la agencia que espiaba.
    this.agencia = this.agenciaOriginal;
    Object.setPrototypeOf(this, this.programaOriginal);
  };
};

control = new Agencia(AgenteDeControl, "idC", "nC");

nuevoAgente = function(agencia){
  
  // Crea un nuevo agente de la agencia.
  let agente = new (agencia.programaDeEntrenamiento)();
  
  // Indica que se agregó un nuevo agente.
  agencia.agenteAgregado(agente);
  return agente;
};
enrolar = function(agente, agencia){
  
  // Asocia el parámetro this de la función agencia.programaDeEntrenamiento, con el agente 
  // y ejecuta la función obtenida para hacer pasar al agente por el programa de entrenamiento de la agencia.
  agencia.programaDeEntrenamiento.bind(agente)();

  // Establece el prototipo del agente como el de todos los agentes creados con la función agencia.programaDeEntrenamiento.
  Object.setPrototypeOf(agente, agencia.programaDeEntrenamiento.prototype); // (3)
  
  // Indica que se agregó un nuevo agente.
  agencia.agenteAgregado(agente);
};

agenteEspecial = function(agencia, habilidad){ 
  let agente = new nuevoAgente(agencia);

  // Hace que el agente sepa responder al mensaje habilidad.
  agente[habilidad.name] = habilidad;
  return agente;
};

camuflar = function(otroObjeto){

  // Hace que this sepa responder a todos los mensajes que sabe responder otroObjeto.
  for(selector in otroObjeto) this[selector] = otroObjeto[selector];
};

// Agreguen aquí los tests representados como funciones que toman un objeto res como argumento.
  // Pueden llamar a res.write para escribir en la salida.
  // Si le pasan un booleano como segundo argumento, el color de los que escriban será verde o rojo en base al valor de dicho booleano.

// Ejemplo de un test
function testEjemplo(res) {
  res.write("\n|| Probando la suma ||\n");
  let sumando1 = 4;
  let sumando2 = 6;
  let resultado_obtenido = sumando1 + sumando2;
  let resultado_esperado = 10;
  res.write("El resultado de sumar " + sumando1 + " y " + sumando2 + " da " + resultado_obtenido, (resultado_obtenido===resultado_esperado));
  sumando1 = "4";
  sumando2 = "6";
  resultado_obtenido = sumando1 + sumando2;
  resultado_esperado = "10";
  res.write("El resultado de sumar " + sumando1 + " y " + sumando2 + " da " + resultado_obtenido, (resultado_obtenido===resultado_esperado));
  sumando1 = 4;
  sumando2 = undefined;
  resultado_obtenido = sumando1 + sumando2;
  res.write("El resultado de sumar " + sumando1 + " y " + sumando2 + " da " + resultado_obtenido);
}

// Test Ejercicio 1
function testEjercicio1(res) {

  res.write("\n|| Crear al agente Smart ||\n");

  let creadoCorrectamente = Object.getPrototypeOf(smart) === AgenteDeControl.prototype;
  res.write(`Agente Smart creado de forma ${creadoCorrectamente ? '' : 'in'}correcta`, creadoCorrectamente);

  let conoceSuAgencia = "agencia" in smart;
  res.write(`Agente Smart ${si_o_no(conoceSuAgencia)} conoce su agencia`, conoceSuAgencia);

  let suAgenciaEsControl = smart.agencia === "Control";
  res.write(`La Agencia del agente Smart ${si_o_no(suAgenciaEsControl)} es Control`, suAgenciaEsControl);  

}

// Test Ejercicio 2
function testEjercicio2(res) {

  let agenciaEstaDefinida = Agencia != undefined;
  res.write(`La función Agencia ${si_o_no(agenciaEstaDefinida)} está definida`, agenciaEstaDefinida);

  let AgenteDeKaos = function() {};
  kaos = new Agencia(AgenteDeKaos);

  let tieneDefinidoElProgramaDeEntrenamiento = Object.values(kaos).includes(AgenteDeKaos);
  res.write(`La agencia ${si_o_no(tieneDefinidoElProgramaDeEntrenamiento)} tiene definido un programa de entrenamiento`, tieneDefinidoElProgramaDeEntrenamiento);

  // Completar

}

// Test Ejercicio 3
function testEjercicio3(res) {

  res.write("\n|| Crear una agencia y un agente ||\n");

  let fConstructora = function() { };
  fConstructora.prototype.peliculas = 2;

  let oss = new Agencia(fConstructora);
  let miniEspia = nuevoAgente(oss);
  let conoceMensajePrototipo = miniEspia.peliculas === 2;
  res.write(`El agente ${si_o_no(conoceMensajePrototipo)} conoce el mensaje de su prototipo`, conoceMensajePrototipo);

  fConstructora.prototype.peliculas = 3;

  let mensajePrototipoActualizado = miniEspia.peliculas === 3;
  res.write(`El agente ${si_o_no(mensajePrototipoActualizado)} sabe que el mensaje se actualizó`, mensajePrototipoActualizado);
  res.write("\n|| Enrolar a un agente ||\n");

  let miniEspia2 = {};
  enrolar(miniEspia2, oss);
  conoceMensajePrototipo = miniEspia2.peliculas === 3;
  res.write(`El agente enrolado ${si_o_no(conoceMensajePrototipo)} conoce el mensaje de su prototipo`, conoceMensajePrototipo);
  
  fConstructora.prototype.peliculas = 1;
  mensajePrototipoActualizado = miniEspia2.peliculas === 1;
  res.write(`El agente enrolado ${si_o_no(mensajePrototipoActualizado)} sabe que el mensaje se actualizó`, mensajePrototipoActualizado);

  let agentes = 0;
  let fConstructora2 = function() { 
    agentes++;
  };
  let cia = new Agencia(fConstructora2);
  let miniEspia3 = {};
  enrolar(miniEspia3, cia);
  agenciaRegistraEnrolamiento = agentes == 1;
  res.write(`El agente enrolado ${si_o_no(agenciaRegistraEnrolamiento)} pasó por el programa de entrenamiento`, agenciaRegistraEnrolamiento);
  
  // Completar

}

// Test Ejercicio 4
function testEjercicio4(res) {
	
  res.write("\n|| Crear un agente de cada agencia ||\n");
	
  control = new Agencia(function() { }, "idC", "nC");
	kaos = new Agencia(function() { }, "idK", "nK");
	let agenteK = {};
  let agenteC = nuevoAgente(control);
  enrolar(agenteK, kaos);
  let C_conoce_idC = "idC" in agenteC;
  let C_conoce_nC = "nC" in agenteC;
  let C_conoce_idK = "idK" in agenteC;
  let C_conoce_nK = "nK" in agenteC;
  let K_conoce_idC = "idC" in agenteK;
  let K_conoce_nC = "nC" in agenteK;
  let K_conoce_idK = "idK" in agenteK;
  let K_conoce_nK = "nK" in agenteK;
  res.write("El agente de Control" + si_o_no(C_conoce_idC) + "sabe responder idC", C_conoce_idC);
  res.write("El agente de Control" + si_o_no(C_conoce_nC) + "sabe responder nC", C_conoce_nC);
  res.write("El agente de Control" + si_o_no(C_conoce_idK) + "sabe responder idK", !C_conoce_idK);
  res.write("El agente de Control" + si_o_no(C_conoce_nK) + "sabe responder nK", !C_conoce_nK);
  res.write("El agente de Kaos" + si_o_no(K_conoce_idC) + "sabe responder idC", !K_conoce_idC);
  res.write("El agente de Kaos" + si_o_no(K_conoce_nC) + "sabe responder nC", !K_conoce_nC);
  res.write("El agente de Kaos" + si_o_no(K_conoce_idK) + "sabe responder idK", K_conoce_idK);
  res.write("El agente de Kaos" + si_o_no(K_conoce_nK) + "sabe responder nK", K_conoce_nK);
  // Completar

}

// Test Ejercicio 5
function testEjercicio5(res) {
  res.write("\n|| Crear un agente de cada agencia y mandarlo a espiar ||\n");
	control = new Agencia(function() { }, "idC", "nC");
	kaos = new Agencia(function() { }, "idK", "nK");
	let agenteK = nuevoAgente(kaos);
  let agenteC = {};
  enrolar(agenteC, control);
  agenteC.espiar(kaos);
  agenteK.espiar(control);
  let C_conoce_idC = "idC" in agenteC;
  let C_conoce_nC = "nC" in agenteC;
  let C_conoce_idK = "idK" in agenteC;
  let C_conoce_nK = "nK" in agenteC;
  let K_conoce_idC = "idC" in agenteK;
  let K_conoce_nC = "nC" in agenteK;
  let K_conoce_idK = "idK" in agenteK;
  let K_conoce_nK = "nK" in agenteK;
  res.write("El espía de Control" + si_o_no(C_conoce_idC) + "sabe responder idC", C_conoce_idC);
  res.write("El espía de Control" + si_o_no(C_conoce_nC) + "sabe responder nC", !C_conoce_nC);
  res.write("El espía de Control" + si_o_no(C_conoce_idK) + "sabe responder idK", !C_conoce_idK);
  res.write("El espía de Control" + si_o_no(C_conoce_nK) + "sabe responder nK", C_conoce_nK);
  res.write("El espía de Kaos" + si_o_no(K_conoce_idC) + "sabe responder idC", !K_conoce_idC);
  res.write("El espía de Kaos" + si_o_no(K_conoce_nC) + "sabe responder nC", K_conoce_nC);
  res.write("El espía de Kaos" + si_o_no(K_conoce_idK) + "sabe responder idK", K_conoce_idK);
  res.write("El espía de Kaos" + si_o_no(K_conoce_nK) + "sabe responder nK", !K_conoce_nK);
  // Completar

}

// Test Ejercicio 6
function testEjercicio6(res) {
  let fConstructora = function() {
    this.sombrero = true;
  };
  let owca = new Agencia(fConstructora);
  let sacarseElSombrero = function() {
    this.sombrero = false;
  }
  res.write("\n|| Crear al agente P ||\n");
  let p = new agenteEspecial(owca, sacarseElSombrero);
  let perrySabeSacarseElSombrero = 'sacarseElSombrero' in p;
  res.write(`El agente P ${si_o_no(perrySabeSacarseElSombrero)} sabe sacarse el sombrero`, perrySabeSacarseElSombrero);

  res.write("\n|| Crear al agente Camaleón ||\n");
  let camaleon = new agenteEspecial(owca, camuflar);
  camaleon.camuflar({
    color: 'rojo',
    repetir: function(s) {return s;}
  });

  let camaleonSabeResponderColor = 'color' in camaleon;
  let camaleonSabeResponderRepetir = 'repetir' in camaleon;
  res.write(`El agente Camaleón ${si_o_no(camaleonSabeResponderColor)} sabe responder \"color\"`, camaleonSabeResponderColor);
  res.write(`El agente Camaleón ${si_o_no(camaleonSabeResponderRepetir)} sabe responder \"repetir\"`, camaleonSabeResponderRepetir);

  let camaleonEsRojo = camaleon.color == 'rojo';
  let camaleonRespondeQOnda = camaleon.repetir('q onda?') == 'q onda?';
  res.write(`El agente Camaleón ${si_o_no(camaleonEsRojo)} es de color rojo`, camaleonEsRojo);
  res.write(`El agente Camaleón ${si_o_no(camaleonRespondeQOnda)} responde 'q onda?' si le piden repetir 'q onda?'`, camaleonRespondeQOnda);
  // Completar

}