cree(gabriel,campanita).
cree(gabriel,oz).
cree(gabriel,cavenaghi).
cree(macarena,reyesMagos).
cree(macarena,capria).
cree(macarena,campanita).
cree(juan,conejoPascua).

suenio(gabriel,loteria([5,9])).
suenio(gabriel,futbolista(arsenal)).
suenio(juan,cantante(100000)).
suenio(macarena,cantante(10000)).

esChico(arsenal).
esChico(aldosivi).

dificultades((cantante(Numero)),Dificultad):- Numero > 500000, Dificultad is 6.

dificultades((cantante(Numero)),Dificultad):- Numero < 500000, Dificultad is 4.

dificultades(futbolista(Equipo),Dificultad):- esChico(Equipo), Dificultad is 3.

dificultades(futbolista(Equipo),Dificultad):- not(esChico(Equipo)), Dificultad is 16.

dificultades(loteria(Numeros),Dificultad):- length(Numeros,Cant), Dificultad is 10*Cant.

sumaDificultades(Persona,Cantidad):- suenio(Persona,_), findall(Num, dificultadSuenio(Persona,Num), Lista), sum_list(Lista,Cantidad).

dificultadSuenio(Persona,Cantidad):- suenio(Persona,Suenio), dificultades(Suenio,Cantidad).

esAmbiciosa(Persona):- sumaDificultades(Persona,Cantidad), Cantidad>20.

tieneQuimica(Persona,campanita):- cree(Persona,campanita),
                                  dificultadSuenio(Persona,Cantidad),
                                  Cantidad < 5.

tieneQuimica(Persona,Personaje):- cree(Persona,Personaje), suenio(Persona,Suenio), Personaje \= campanita, forall(suenio(Persona,Suenio),(not(esAmbiciosa(Persona)),esPuro(Suenio))).

esPuro(futbolista(_)). 
esPuro(cantante(Cantidad)):- Cantidad < 200000.


esAmigo(campanita,reyesMagos).
esAmigo(campanita,conejoPascua).
esAmigo(conejoPascua,cavenaghi).

personajeBackUp(Personaje,Personaje2):- esAmigo(Personaje,Personaje2).
personajeBackUp(Personaje,Personaje2):- esAmigo(Personaje,Personaje3), personajeBackUp(Personaje3,Personaje2).

alegra(Persona,Personaje):- suenio(Persona,_), tieneQuimica(Persona,Personaje), esAlegre(Personaje).

esAlegre(Personaje):- not(estaEnfermo(Personaje)).
esAlegre(Personaje):- personajeBackUp(Personaje,Personaje2), not(estaEnfermo(Personaje2)).

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoPascua).