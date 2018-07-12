jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).


item(madera).
item(piedra).
item(carbon).
item(panceta).
item(pan).
item(pollo).
item(diamante).

lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).


tieneItem(Jugador,Item):- jugador(Jugador,Items,_),member(Item,Items).

sePreocupaPorSuSalud(Jugador):-tieneItemComestible(Jugador,Item1),
                               tieneItemComestible(Jugador,Item2),
                                Item1\=Item2.

cantidadDeItem(Jugador,Item,Cantidad):- item(Item),jugador(Jugador,_,_),findall(Item,tieneItem(Jugador,Item),Items),length(Items,Cantidad).

tieneMasDe(Jugador,Item):- item(Item),jugador(Jugador,_,_),
                           cantidadDeItem(Jugador,Item,CantidadJugador),
                          findall(Cantidad,cantidadDeItem(_,Item,Cantidad),Cantidades),
                          max_list(Cantidades,CantidadJugador).

hayMonstruos(Lugar):- lugar(Lugar,_,Nivel),Nivel>6.


tieneItemComestible(Jugador,Item):- tieneItem(Jugador,Item),comestible(Item).

estaEn(Lugar,Personaje):- lugar(Lugar,Personajes,_), member(Personaje,Personajes).

correPeligro(Jugador):- jugador(Jugador,_,_),
                        estaEn(Lugar,Jugador),
                        hayMonstruos(Lugar).

correPeligro(Jugador):- jugador(Jugador,_,_),
                        estaHambriento(Jugador), not(tieneItemComestible(Jugador,_)).

estaHambriento(Jugador):- jugador(Jugador,_,Hambre), Hambre<4.

poblacion(Lugar,Cantidad):- lugar(Lugar,Gente,_),length(Gente,Cantidad).
poblacionHambrienta(Lugar,Cantidad):- lugar(Lugar,Gente,_),member(Personaje,Gente),
                                     findall(Personaje,estaHambriento(Personaje),Poblacion),
                                      length(Poblacion,Cantidad).

nivelDePeligrosidad(Lugar,Nivel):- lugar(Lugar,_,_),not(hayMonstruos(Lugar)),  
                                  poblacion(Lugar,Cantidad1),
                                  poblacionHambrienta(Lugar,Cantidad2),
                                   Nivel is ((Cantidad2*100)/Cantidad1).
nivelDePeligrosidad(Lugar,Nivel):- lugar(Lugar,_,_),hayMonstruos(Lugar),
                    Nivel is 100.

nivelDePeligrosidad(Lugar,Nivel):- lugar(Lugar,_,Oscuridad),poblacion(Lugar,Cantidad),Cantidad=0,
                                    Nivel is (Oscuridad*10).
                                   

item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).

puedeConstruir(Jugador,Item):- item(Item,Materiales),jugador(Jugador,_,_), 
                               forall(member(Material,Materiales),cumpleRequisitos(Material,Jugador)).
                                  
cumpleRequisitos(itemSimple(ItemPedido,Cantidad),Jugador):- cantidadDeItem(Jugador,ItemPedido,Stock),
                                                            Stock>=Cantidad.

cumpleRequisitos(itemCompuesto(Item),Jugador):- puedeConstruir(Jugador,Item).
                                            
                                           







                          