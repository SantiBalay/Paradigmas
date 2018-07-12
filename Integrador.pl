%Punto 1
mira(juan,himym).
mira(juan,futurama).
mira(juan,got).
mira(nico,starWars).
mira(nico,got).
mira(maiu,starWars).
mira(maiu,onePiece).
mira(maiu,got).
mira(gaston,hoc).
mira(pedro,got).

quiereVer(juan,hoc).
quiereVer(aye,got).
quiereVer(gaston,himym).

%tieneEpisodios(Serie,Temporada,Episodio)
tieneEpisodios(got,3,12).
tieneEpisodios(got,2,10).
tieneEpisodios(himym,1,23).
tieneEpisodios(drHouse,8,16).


%Punto 2
%paso(Serie, Temporada, Episodio, Lo que paso)
paso(futurama, 2, 3, muerte(seymourDiera)).
paso(starWars, 10, 9, muerte(emperor)).
paso(starWars, 1, 2, relacion(parentesco, anakin, rey)).
paso(starWars, 3, 2, relacion(parentesco, vader, luke)).
paso(himym, 1, 1, relacion(amorosa, ted, robin)).
paso(himym, 4, 3, relacion(amorosa, swarley, robin)).
paso(got, 4, 5, relacion([amistad, tyrion, dragon])).
paso(got, 3, 2, plotTwist([suenio,sinPiernas])).
paso(got, 3, 12, plotTwist([fuego,boda])).
paso(superCampeones, 9, 9, plotTwist([suenio,coma,sinPiernas])).
paso(drHouse, 8, 7, plotTwist([coma,pastillas])).

%leDijo/4
leDijo(gaston, maiu, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, maiu, starWars, relacion(parentesco, vader, luke)).
leDijo(nico, juan, got, muerte(tyrion)).
leDijo(aye, juan, got, relacion(amistad, tyrion, john)).
leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
leDijo(aye, gaston, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, juan, futurama, muerte(seymourDiera)).
leDijo(pedro, aye, got, relacion(amistad, tyrion, dragon)).
leDijo(pedro, nico, got, relacion(parentesco, tyrion, dragon)).


%Punto 3

esSpoiler(Serie,Spoiler) :- paso(Serie,_,_,Spoiler).

/*
Apartir del predicado esSpoiler/2 podemos realizar las siguientes consultas:
Respecto a consultas individuales se puede saber si es verdad que ocurrio la muerte
de tal Personaje, o que tiene relacion con otro
Respecto a consultas existenciales, se puede saber en que serie se muere tal personaje
o tiene relacion con otro, si es cierto que se muere alguien, o si se relaciona con
tal otro.*/

%Punto 4
leSpoileo(Alguien,Otro,Serie) :- fueSpoiler(Alguien,Otro,Serie),
                                 miraOQuiereVer(Otro,Serie).

miraOQuiereVer(Persona,Serie) :- mira(Persona,Serie).
miraOQuiereVer(Persona,Serie) :- quiereVer(Persona,Serie).

fueSpoiler(Alguien,Otro,Serie) :- leDijo(Alguien,Otro,Serie,Spoiler),
                                  esSpoiler(Serie,Spoiler).

%Punto 5
televidenteResponsable(Alguien) :- miraOQuiereVer(Alguien,_),
                                   not(leSpoileo(Alguien,_,_)).

%Punto 6
vieneZafando(Alguien,Serie) :- miraOQuiereVer(Alguien,Serie),
                               not(leSpoileo(_,Alguien,Serie)),
                               esSafable(Serie).

esSafable(Serie) :- esPopular(Serie).
esSafable(Serie) :- tieneEpisodios(Serie,Temporada,_),
                    forall(paso(Serie,Temporada,_,Suceso),esFuerte(Serie,Suceso)).


esFuerte(_,muerte(_)).
esFuerte(_,relacion(amorosa,_,_)).
esFuerte(_,relacion(parentesco,_,_)).
esFuerte(Serie,plotTwist(Palabras)) :- esFinalDeTemporada(Serie,plotTwist(_)),
                                       not(esCliche(Serie,Palabras)).

esFinalDeTemporada(Serie,plotTwist(_)) :- tieneEpisodios(Serie,Temporada,Episodio),
                                          paso(Serie,Temporada,Episodio,plotTwist(_)).

esCliche(Serie,Palabras) :- forall((member(Palabra,Palabras)),existeSerie(Serie,Palabra)).


existeSerie(Serie,Palabra) :- paso(Serie,_,_,plotTwist(Palabras)),
    						              member(Palabra,Palabras),
    						              paso(Serie2,_,_,plotTwist(Palabras2)),
                              member(Palabra,Palabras2),
                              Serie\=Serie2.


%Segunda Entrega

%Punto 1

malaGente(Persona) :- forall(leDijo(Persona,Otro,Serie,_),leSpoileo(Persona,Otro,Serie)).
malaGente(Persona) :- leSpoileo(Persona,_,Serie),
                      not(mira(Persona,Serie)).

%Punto 2



%Puntos 3
popular(hoc).
popular(Serie) :- mira(_,Serie),
                  findall(Persona,mira(Persona,Serie),Miran),
                  length(Miran,CantMiran),
                  findall(Persona,leDijo(Persona,_,Serie,_),Charlas),
                  length(Charlas,CantCharlas),
                  (CantMiran*CantCharlas)>=2.

%Punto 4

amigo(nico, maiu).
amigo(maiu, gaston).
amigo(maiu, juan).
amigo(juan, aye).

fullSpoil(Persona1,Persona2) :- leSpoileo(Persona1,Persona2,_).
fullSpoil(Persona1,Persona2) :- amigo(Otro,Persona2),
    							              fullSpoil(Persona1,Otro),
                                Persona1\=Persona2.
