/* TO DO: 
          Tal vez sacar código repetido de (1), (2) y (3)
          Agregar tests para ver que:
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

  this.sumarAgente = function() {this.programaDeEntrenamiento.prototype[selectorDeTotal] += 1};
  
  this.agenteAgregado = function(agente) {

    // Incrementa el total de agentes agregados
    //this.programaDeEntrenamiento.prototype[selectorDeTotal] += 1;
    this.sumarAgente();
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
    otraAgencia.sumarAgente();
  
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
  Object.setPrototypeOf(agente, agencia.programaDeEntrenamiento.prototype); // (3) adoptarProtocoloDeLaAgencia(agente, agencia)
  
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

  // se inicializa correctamente el valor de los id's
  let K_responde_idK = agenteK.idK == 1;
  res.write("El primer agente de Kaos" + si_o_no(K_responde_idK) + "tiene ID adecuado", K_responde_idK);
  let C_responde_idC = agenteC.idC == 1;
  res.write("El primer agente de Control" + si_o_no(C_responde_idC) + "tiene ID adecuado", C_responde_idC);

  // se inicializa correctamente el valor de los n
  let K_responde_nK = agenteK.nK == 1;
  res.write("El primer agente de Kaos" + si_o_no(K_responde_nK) + "tiene n adecuado", K_responde_nK);
  let C_responde_nC = agenteC.nC == 1;
  res.write("El primer agente de Control" + si_o_no(C_responde_nC) + "tiene n adecuado", C_responde_nC);

  // agregar nuevos agentes
  let segundoAgenteK = {};
  let segundoAgenteC = nuevoAgente(control);
  enrolar(segundoAgenteK, kaos);

  // agregar nuevos agentes inicializa correctamente los valores de ID
  let segundo_K_responde_idK = segundoAgenteK.idK == 2;
  res.write("El segundo agente de Kaos" + si_o_no(segundo_K_responde_idK) + "tiene ID adecuado", segundo_K_responde_idK);
  let segundo_C_responde_idC = segundoAgenteC.idC == 2;
  res.write("El segundo agente de Control" + si_o_no(segundo_C_responde_idC) + "tiene ID adecuado", segundo_C_responde_idC);

  // agregar nuevos agentes inicializa correctamente los valores de n
  let segundo_K_responde_nK = segundoAgenteK.nK == 2;
  res.write("El segundo agente de Kaos" + si_o_no(segundo_K_responde_nK) + "tiene n adecuado", segundo_K_responde_nK);
  let segundo_C_responde_nC = segundoAgenteC.nC == 2;
  res.write("El segundo agente de Control" + si_o_no(segundo_C_responde_nC) + "tiene n adecuado", segundo_C_responde_nC);

  // los primeros agentes mantienen sus ID's
  let K_sigue_respondiendo_idK = agenteK.idK == 1;
  res.write("El primer agente de Kaos" + si_o_no(K_sigue_respondiendo_idK) + "sigue teniendo ID adecuado", K_sigue_respondiendo_idK);
  let C_sigue_respondiendo_idC = agenteC.idC == 1;
  res.write("El primer agente de Control" + si_o_no(C_sigue_respondiendo_idC) + "sigue teniendo ID adecuado", C_sigue_respondiendo_idC);

  // los primeros agentes conocen el nuevo n
  let K_sigue_respondiendo_nK = agenteK.nK == 2;
  res.write("El primer agente de Kaos" + si_o_no(K_sigue_respondiendo_nK) + "sigue teniendo n adecuado", K_sigue_respondiendo_nK);
  let C_sigue_respondiendo_nC = agenteC.nC == 2;
  res.write("El primer agente de Control" + si_o_no(C_sigue_respondiendo_nC) + "sigue teniendo n adecuado", C_sigue_respondiendo_nC);

}

// Test Ejercicio 5
function testEjercicio5(res) {
  res.write("\n|| Crear un agente de cada agencia y mandarlo a espiar ||\n");
	control = new Agencia(function() { }, "idC", "nC");
	kaos = new Agencia(function() { }, "idK", "nK");
	let agenteK = nuevoAgente(kaos);
  let agenteC = {};
  enrolar(agenteC, control);

  // Los espías saben responder exactamente los mensajes que deben
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


  // Al dejar de espíar vuelven a responder exactamente los mismos mensajes que respondían antes de ser espías
  agenteK.dejarDeEspiar();
  agenteC.dejarDeEspiar();

  C_conoce_idC = "idC" in agenteC;
  C_conoce_nC = "nC" in agenteC;
  C_conoce_idK = "idK" in agenteC;
  C_conoce_nK = "nK" in agenteC;
  K_conoce_idC = "idC" in agenteK;
  K_conoce_nC = "nC" in agenteK;
  K_conoce_idK = "idK" in agenteK;
  K_conoce_nK = "nK" in agenteK;
  res.write("El espía de Control" + si_o_no(C_conoce_idC) + "sabe responder idC", C_conoce_idC);
  res.write("El espía de Control" + si_o_no(C_conoce_nC) + "sabe responder nC", C_conoce_nC);
  res.write("El espía de Control" + si_o_no(C_conoce_idK) + "sabe responder idK", !C_conoce_idK);
  res.write("El espía de Control" + si_o_no(C_conoce_nK) + "sabe responder nK", !C_conoce_nK);
  res.write("El espía de Kaos" + si_o_no(K_conoce_idC) + "sabe responder idC", !K_conoce_idC);
  res.write("El espía de Kaos" + si_o_no(K_conoce_nC) + "sabe responder nC", !K_conoce_nC);
  res.write("El espía de Kaos" + si_o_no(K_conoce_idK) + "sabe responder idK", K_conoce_idK);
  res.write("El espía de Kaos" + si_o_no(K_conoce_nK) + "sabe responder nK", K_conoce_nK);


  // Los espías responden correctamente 
  let segundo_agenteK = nuevoAgente(kaos);
  segundo_agenteK.espiar(control);
  let segundo_agenteK_responde_nC_correctamente = segundo_agenteK.nC === 3;
  res.write("El espía de Kaos" + si_o_no(segundo_agenteK_responde_nC_correctamente) + "sabe responder nC correctamente", segundo_agenteK_responde_nC_correctamente);

  let segundo_agenteK_responde_idK_correctamente = segundo_agenteK.idK === 3;
  res.write("El espía de Kaos" + si_o_no(segundo_agenteK_responde_idK_correctamente) + "sabe responder idK correctamente", segundo_agenteK_responde_idK_correctamente);


  // Al dejar de espiar dejan de responder el total de la otra agencia y recuperan el original
  segundo_agenteK.dejarDeEspiar();
  let segundo_agenteK_responde_nK_correctamente = segundo_agenteK.nK === 3;
  res.write("El espía de Kaos" + si_o_no(segundo_agenteK_responde_nK_correctamente) + "sabe responder nK correctamente", segundo_agenteK_responde_nK_correctamente);


  // El doble espía sabe volver a su agencia original
  let equilibrio = new Agencia(function(){}, "idE", "nE");
  let agenteE = nuevoAgente(equilibrio);
  agenteE.espiar(control);
  agenteE.espiar(kaos);
  agenteE.dejarDeEspiar();
  let agenteE_responde_nE = "nE" in agenteE;
  res.write("El espía de Equilibrio" + si_o_no(agenteE_responde_nE) + "sabe responder nE", agenteE_responde_nE);
  let agenteE_responde_nE_correctamente = agenteE.nE === 1;
  res.write("El espía de Equilibrio" + si_o_no(agenteE_responde_nE_correctamente) + "sabe responder nE correctamente", agenteE_responde_nE_correctamente);

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

  // cuando se agrega un agente especial, se le asigna un ID y sabe el n de la agencia

  control = new Agencia(function() { }, "idC", "nC");
  let agenteC = new agenteEspecial(control, sacarseElSombrero)

  let C_responde_idC = agenteC.idC == 1;
  res.write("El primer agente de Control" + si_o_no(C_responde_idC) + "tiene ID adecuado", C_responde_idC);

  let C_responde_nC = agenteC.nC == 1;
  res.write("El primer agente de Control" + si_o_no(C_responde_nC) + "tiene n adecuado", C_responde_nC);
}
























