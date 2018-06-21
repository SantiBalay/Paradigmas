% TP1 - Asesinato en la mansión Dreadbury (v1.7)

odia(agatha,Alguien):- viveEnMansion(Alguien),
                       Alguien\=carnicero,
                       Alguien\=agatha.

odia(carnicero,Alguien):- odia(agatha,Alguien),
                          Alguien\=carnicero.

odia(charles,Alguien):- viveEnMansion(Alguien),
                        not(odia(agatha,Alguien)),
                        Alguien\=charles.

esMasRico(agatha,Alguien):- not(odia(Alguien,carnicero)),
                            viveEnMansion(Alguien).

mataA(Alguien,Otro) :- odia(Alguien,Otro),
                       not(esMasRico(Alguien,Otro)),
                       viveEnMansion(Uno).

viveEnMansion(agatha).
viveEnMansion(carnicero).
viveEnMansion(charles).

% A) 1) odia(_,milhouse). -> false.
%    2) odia(Quienes,charles). -> Quienes = agatha ; Quienes = carnicero ;
%    3) odia(Quien,agatha). -> Quien = charles ;
%    4) odia(Odiador,OdiaA) -> Odiador = agatha, OdiaA = charles ;
%                              Odiador = carnicero, OdiaA = charles ;
%                              Odiador = charles, OdiaA = agatha ;
%                              Odiador = charles, OdiaA = carnicero 
%    5) odia(carnicero,_) -> true.


