producto(coto, lacteo, leche, 35).
producto(coto, galletita, oreo, 60).
producto(dia, lacteo, leche, 22).
producto(dia, lacteo, yoghurt, 30).
producto(dia, infusion, cafe, 70).
producto(dia, infusion, te, 30).
producto(dia, galletita, oreo, 45).

esBarato(Precio) :- Precio < 40.

deOferta1(Super,Tipo):-
    forall(producto(Super,Tipo,_,Precio), 
           esBarato(Precio)).

deOferta2(Super,Tipo):-
    producto(Super,Tipo,_,_),
    forall(producto(Super,Tipo,_,Precio),
           esBarato(Precio)).

cuantosTiene(Super,Cant) :-
    producto(Super,_,_,_),
    findall(Prod,producto(Super,_,Prod,_),Lista),
    length(Lista,Cant).

cuantosLacteos(Super,Cant) :-
    producto(Super,_,_,_),
    findall(Prod,producto(Super,lacteo,_,_),Lista),
    length(Lista,Cant).

quiereComprar(pepe,leche).
quiereComprar(pepe,oreo).
quiereComprar(ana,cafe).

meAlcanzaRaton(Super,Dinero) :-
    producto(Super,_,_,_),
    findall(Plata,(producto(Super,_,_,Plata),esBarato(Plata)),Lista),
    sumlist(Lista,Algo),
    Dinero>=Algo.