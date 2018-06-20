import Data.List
import Text.Show.Functions

type Ataque = (Personaje->Personaje)

data Personaje = UnPersonaje {
    nombre::String, 
    ataqueFavorito:: Ataque,
    elementos::[String], 
    energia::Int}

instance Show Personaje where
    show (UnPersonaje nombre _ _ _) = show nombre

nada:: Ataque
nada personaje = personaje

hulk = UnPersonaje "hulk" superFuerza ["pantalones"] 90
thor = UnPersonaje "thor" (relampagos 50) ["mjolnir"] 1000000
viuda = UnPersonaje "viuda negra" artesMarciales [] 90
capitan = UnPersonaje "capitan america" arrojarEscudo ["escudo"] 80
halcon = UnPersonaje "ojo de halcon" arqueria ["arco", "flechas"] 70
vision = UnPersonaje "vision" (proyectarRayos 5) ["gema del infinito"] 100
ironMan = UnPersonaje "iron man" (proyectarRayos 10) ["armadura", "jarvis", "plata"] 60
ultron = UnPersonaje "robot ultron"  corromperTecnologia [] 100 



esRobot:: Personaje -> Bool
esRobot personaje | (head.words.nombre) personaje == "robot" = True
                  | otherwise = False

tieneElemento:: Personaje -> String -> Bool
tieneElemento personaje elemento = elem elemento (elementos personaje)

potencia:: Personaje -> Int
potencia personaje = (energia personaje) * (length (elementos personaje))


--Ataques

superFuerza:: Ataque
superFuerza personaje = personaje {energia = 0}

relampagos:: Int -> Ataque
relampagos n personaje = personaje {energia = (energia personaje) - n}

arqueria:: Ataque
arqueria personaje | not (tieneElemento personaje "escudo") = superFuerza personaje
                   | otherwise = personaje 

proyectarRayos:: Int -> Ataque
proyectarRayos n personaje = personaje {energia = (energia personaje) - 2*n}

arrojarEscudo:: Ataque
arrojarEscudo personaje = personaje { elementos = []}

artesMarciales:: Ataque
artesMarciales personaje = personaje { ataqueFavorito = nada}

corromperTecnologia:: Ataque
corromperTecnologia personaje = personaje { nombre = "robot " ++ (nombre personaje)}


ataque:: Personaje -> Personaje -> Personaje
ataque personaje1 personaje2 = (ataqueFavorito personaje1) personaje2


defensa:: Personaje -> Personaje -> Personaje
defensa personaje1 personaje2 = (ataqueFavorito (ataque personaje1 personaje2)) personaje1

combate:: Personaje -> Personaje -> Bool
combate personaje1 personaje2 | energia (ataque personaje1 personaje2) >= energia (defensa personaje1 personaje2) = False
                              | otherwise = True

--False atacante/ejercito1
--True defensor/ejercito2

combateTuplas:: (Personaje,Personaje) -> Bool
combateTuplas (personaje1,personaje2) | energia (ataque personaje1 personaje2) >= energia (defensa personaje1 personaje2) = False
                                      | otherwise = True

cuantosTrue:: [Personaje] -> [Personaje] -> Int
cuantosTrue ejercito1 ejercito2 = length ( filter (==True) (map combateTuplas (zip ejercito1 ejercito2)) )

ejercito1=[viuda,hulk,capitan,capitan,viuda,viuda]
ejercito2=replicate 5 thor


elMenor ejercito1 ejercito2 | length (ejercito1) < length (ejercito2) = ejercito1
                            | otherwise = ejercito2

batallaEjercitos:: [Personaje] -> [Personaje] -> String
batallaEjercitos ejercito1 ejercito2 | (cuantosTrue ejercito1 ejercito2) > (length (elMenor ejercito1 ejercito2)) - (cuantosTrue ejercito1 ejercito2) = "Gana Ejercito 1"
                                     | otherwise = "Gana Ejercito 2"


stanlee = UnPersonaje "Stan Lee"  nada [] 10000000000000000 

esDigno:: Personaje -> Bool
esDigno personaje = ((potencia personaje) > 1000 && not (esRobot personaje)) || nombre personaje == "Stan Lee"

sonDignos:: [Personaje] -> [Personaje]
sonDignos personajes = filter esDigno personajes