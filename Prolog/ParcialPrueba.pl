quedaEn(venezuela, america).
quedaEn(argentina, america).
quedaEn(patagonia, argentina).
quedaEn(aula522, utn). % Sí, un aula es un lugar!
quedaEn(utn, buenosAires).
quedaEn(buenosAires, argentina).


tarea(dani, unaTarea(examen,paradigmaLogico,aula522,fecha(10,8,2017))).
tarea(dani, unaTarea(gol,primeraDivision,patagonia,fecha(10,8,2017))).
tarea(alf, unaTarea(discurso,0,utn,fecha(11,8,2017))).

nacimiento(alf,buenosAires).
nacimiento(dani,buenosAires).
nacimiento(nico,buenosAires).

dulceHogar(Persona) :- tarea(Persona,_),forall(tarea(Persona,unaTarea(_,_,Nacio,_)),nacimiento(Persona,Nacio)).

estaEnArgentina(Lugar):- quedaEn(Lugar,argentina).
estaEnArgentina(Lugar):- quedaEn(Lugar,Otro),estaEnArgentina(Otro).

esComplejo(caca).
esComplejo(queseyo).

estres(unaTarea(examen,Tema,Lugar,_)):- estaEnArgentina(Lugar), esComplejo(Tema).
estres(unaTarea(discurso,Cuantos,Lugar,_)):- estaEnArgentina(Lugar), Cuantos > 20000.
estres(unaTarea(gol,_,Lugar,_)):- estaEnArgentina(Lugar).

zen(Persona):- tarea(Persona,_), forall(tarea(Persona,unaTarea(Que,LoQueSea,Lugar,_)),not(estres(unaTarea(Que,LoQueSea,Lugar,_)))).

locos(Persona):- tarea(Persona,_), forall(tarea(Persona,unaTarea(Que,LoQueSea,Lugar,fecha(_,_,2017))),estres(unaTarea(Que,LoQueSea,Lugar,fecha(_,_,2017)))). 

sabios(Persona):- tarea(Persona,Tarea1), 
                  estres(Tarea1),
                  forall((tarea(Persona,Tarea2),estres(Tarea2)),esMismaTarea(Tarea1,Tarea2)).

esMismaTarea(Tarea,Tarea).