personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

amigo(vincent, jules).

amigo(jules, jimmie).

amigo(vincent, elVendedor).

esPeligroso(Personaje):- personaje(Personaje,ladron(Cosas)), member(licorerias,Cosas).
esPeligroso(Personaje):- personaje(Personaje,mafioso(maton)).
esPeligroso(Personaje):- trabajaPara(Personaje,Personaje2), esPeligroso(Personaje2).

estanRelacionados(Personaje1,Personaje2):- amigo(Personaje1,Personaje2).
estanRelacionados(Personaje1,Personaje2):- pareja(Personaje2,Personaje1).

duoTemible(Personaje1,Personaje2):- estanRelacionados(Personaje1,Personaje2),
                                   esPeligroso(Personaje1),
                                   esPeligroso(Personaje2).

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

estaEnProblemas(butch).

estaEnProblemas(Personaje):- trabajaPara(Jefe,Personaje), 
                             esPeligroso(Jefe),
                             pareja(Jefe,Pareja),
                             encargo(Jefe,Personaje,cuidar(Pareja)).

estaEnProblemas(Personaje):- encargo(_,Personaje,buscar(Personaje2,_)), esBoxeador(Personaje2).

esBoxeador(Personaje):- personaje(Personaje,boxeador).


tieneCerca(Personaje1,Personaje2):- amigo(Personaje1,Personaje2).
tieneCerca(Personaje1,Personaje2):- trabajaPara(Personaje1,Personaje2).

sanCayetano(Personaje1):- personaje(Personaje1,_), forall(tieneCerca(Personaje1,Personaje2),encargo(Personaje1,Personaje2,_)).

cuantasTareas(Personaje,Cuantas):- encargo(_,Personaje,_), findall(Laburo,encargo(_,Personaje,Laburo),Lista), length(Lista,Cuantas).

masAtareado(Personaje):- cuantasTareas(Personaje,Cuantas1), forall(encargo(_,Personaje2,_),(cuantasTareas(Personaje2,Cuantas2)),Cuantas1>=Cuantas2), Personaje \= Personaje2.

valorRespeto(Personaje,Valor):- personaje(Personaje,mafioso(resuelveProblemas)), Valor is 10.
valorRespeto(Personaje,Valor):- personaje(Personaje,mafioso(maton)), Valor is 1.
valorRespeto(Personaje,Valor):- personaje(Personaje,mafioso(capo)), Valor is 20.
valorRespeto(Personaje,Valor):- personaje(Personaje,actriz(Pelis)), length(Pelis,Cant), Valor is Cant * 1/10.

esRespetable(Personaje):- valorRespeto(Personaje,Valor), Valor>=9.

sonRespetables(Lista):- findall(Tipo,esRespetable(Tipo),Lista).

hartoDe(Personaje,Personaje2) :- encargo(_,Personaje,_),
                                 personaje(Personaje2,_),
                                 forall(encargo(_,Personaje,Tarea),interactuan(Personaje2,Tarea)).

interactuan(Personaje2,buscar(Personaje2,_)).
interactuan(Personaje2,cuidar(Personaje2)).
interactuan(Personaje2,ayudar(Personaje2)).

interactuan(Personaje2,buscar(Amigo,_)) :- amigo(Personaje2,Amigo).
interactuan(Personaje2,cuidar(Amigo)) :- amigo(Personaje2,Amigo).
interactuan(Personaje2,ayudar(Amigo)) :- amigo(Personaje2,Amigo).

caracteristicas(vincent,[negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,[tieneCabeza, muchoPelo]).
caracteristicas(marvin,[negro]).

sonDiferenciables(Personaje1,Personaje2):- caracteristicas(Personaje1,Carac1),caracteristicas(Personaje2,Carac2), sort(Carac1,Sorted1),sort(Carac2,Sorted2), Sorted1\=Sorted2.


