jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

tieneItem(Nombre,Item):- jugador(Nombre,Cosas,_), member(Item,Cosas).

sePreocupaPorSuSalud(Nombre):- tieneItem(Nombre,Item1),
                               tieneItem(Nombre,Item2),
                               comestible(Item1),
                               comestible(Item2),
                               Item2 \= Item1.

cantidadDelItem(Persona,Item,Cant):- tieneItem(_,Item), 
                                     jugador(Persona,_,_),
                                     findall(Item,tieneItem(Persona,Item),Lista),
                                     length(Lista,Cant).

cantidadDelItem(Persona,Item,Cant):- tieneItem(_,Item),
                                     jugador(Persona,Items,_),
                                     not(member(Item,Items)),
                                     Cant is 0.

tieneMasDe(Persona,Item):- cantidadDelItem(Persona,Item,Cant1), 
                           forall(cantidadDelItem(_,Item,Cant2),Cant1>=Cant2).

hayMonstruos(Lugar):- lugar(Lugar,_,Nivel), Nivel > 6.

correPeligro(Personaje,Lugar):- hayMonstruos(Lugar), 
                                lugar(Lugar,Jugadores,_), 
                                member(Personaje,Jugadores).

correPeligro(Personaje,_):- tieneHambre(Personaje), comestible(Item), not(tieneItem(Personaje,Item)).

tieneHambre(Jugador):- jugador(Jugador,_,Hambre), Hambre < 4.

losHambrientosTotales(Lugar,Cantidad):- lugar(Lugar,Gente,_), member(Jugador,Gente), findall(Jugador,tieneHambre(Jugador),Lista), length(Lista,Cantidad). 

nivelP(Nombre,Peligrosidad):- lugar(Nombre,Gente,_),
                              not(hayMonstruos(Nombre)),
                              length(Gente,Cuantos1),
                              losHambrientosTotales(Nombre,Cantidad),
                              Peligrosidad is (Cantidad/Cuantos1*100).

nivelP(Nombre,Peligrosidad):- lugar(Nombre,_,_),hayMonstruos(Nombre),Peligrosidad is 100.
nivelP(Nombre,Peligrosidad):- lugar(Nombre,Gente,Nivel), length(Gente,Cuantos), Cuantos<1, Peligrosidad is Nivel*10.

item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).

separarItems(Algo,Que,Cuanto):- item(Algo,Items), member(itemSimple(Que,Cuanto),Items).
separarItems(Algo,Que):- item(Algo,Items), member(itemCompuesto(Que),Items).

puedeHacer(Personaje,Algo):- item(Algo,Ingredientes),
                             jugador(Personaje,_,_),
                             forall(member(Ingrediente,Ingredientes),cumpleRequisitos(Personaje,Ingredientes))

cumpleRequisitos(Personaje,itemSimple(Material,Cantidad)):- cantidadDelItem(Personaje,Material,Cuantos), 
                                                            Cuantos>=Cantidad

cumpleRequisitos(Personaje,itemCompuesto(Item)):- puedeHacer(Personaje,Item).