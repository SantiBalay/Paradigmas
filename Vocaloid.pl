%%Vocaloid.pl

sabe(magurineLuka,cancion(foreverYoung,5)).
sabe(magurineLuka,cancion(nightFever,4)).
sabe(hatsuneMiku,cancion(tellYourWorld,4)).
sabe(gumi,cancion(foreverYoung,4)).
sabe(gumi,cancion(tellYourWorld,5)).
sabe(seeU,cancion(novemberRain,6)).
sabe(seeU,cancion(nightFever,5)).

sumaMinutos(Cantante,Cuanto):- sabe(Cantante,_), findall(Numero,sabe(Cantante,cancion(_,Numero)),Lista),
                               sum_list(Lista,Cuanto). 
             
sabe2(Cantante):- sabe(Cantante,cancion(Cancion1,_)),
                  sabe(Cantante,cancion(Cancion2,_)),
                  Cancion1 \= Cancion2.

esNovedoso(Cantante):- sumaMinutos(Cantante,Cuanto), Cuanto < 15, sabe2(Cantante). 

%%gigante(MinCanciones,MinTiempo)
%%mediano(MenorA)
%%pequeño(DuracionMinima)
%%concierto(Nombre,Pais,Fama,Tipo) 

concierto(mikuExpo,eeuu,2000,gigante(2,6)).
concierto(magicalMirai,japon,3000,gigante(3,10)).
concierto(vocalekt,eeuu,1000,mediano(9)).
concierto(mikuFest,argentina,100,chico(4)).

cuantasSabe(Cantante,Cuantas):- findall(Cancion, sabe(Cantante,cancion(Cancion,_)),Lista),
                                length(Lista,Cuantas).

puedeParticipar(hatsuneMiku,Concierto):- concierto(Concierto,_,_,_).

puedeParticipar(Cantante,Concierto):- sabe(Cantante,_),
                                      concierto(Concierto,_,_,gigante(MinCanciones,MinTiempo)),
                                      cuantasSabe(Cantante,Cuantas), Cuantas >= MinCanciones,
                                      sumaMinutos(Cantante,Cuanto), Cuanto >= MinTiempo,
                                      Cantante \= hatsuneMiku.


puedeParticipar(Cantante,Concierto):- sabe(Cantante,_),
                                      concierto(Concierto,_,_,mediano(MaxTiempo)),
                                      sumaMinutos(Cantante,Cuanto), Cuanto < MaxTiempo,
                                      Cantante \= hatsuneMiku.

puedeParticipar(Cantante,Concierto):- sabe(Cantante,_),
                                      concierto(Concierto,_,_,chico(DureMas)),
                                      sabe(Cantante,cancion(_,Duracion)), Duracion > DureMas,
                                      Cantante \= hatsuneMiku.

sumaFamas(Cantante,Cuanto):- findall(Fama, famaConcierto(Cantante,Fama), Lista) , sum_list(Lista,Cuanto).

famaConcierto(Cantante,Fama):- puedeParticipar(Cantante,Concierto),fama(Concierto,Fama).

fama(Concierto,Fama):- concierto(Concierto,_,Fama,_).

cuantaFama(Cantante,Fama):- cuantasSabe(Cantante,Cuantas), sumaFamas(Cantante,Cuanto),
                            Fama is Cuantas*Cuanto.
