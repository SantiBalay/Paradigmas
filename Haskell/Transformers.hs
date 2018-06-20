import Text.Show.Functions
import Data.List

type Nombre = String
type Fuerza = Int
type Velocidad = Int
type Resistencia = Int
type CualidadesRobot = (Fuerza,Velocidad,Resistencia)
type Transf = (Fuerza,Velocidad,Resistencia) -> (Velocidad,Resistencia)
type CualidadesAuto = (Velocidad,Resistencia)

data Autobot = Robot Nombre CualidadesRobot Transf | Vehiculo Nombre CualidadesAuto

instance Show Autobot where
  show (Robot a b c) = "Nombre: " ++ show a ++ " Atributos: " ++ show b ++ " Transf: " ++ show c
  show (Vehiculo a b) = "Nombre: " ++ show a ++ " Atributos: " ++ show b 

optimus = Robot "Optimus Prime" (20,20,10) optimusTransformacion
optimusTransformacion (_,v,r) = (v * 5, r * 2)

jazz = Robot "Jazz" (8,35,3) jazzTransformacion
jazzTransformacion (_,v,r) = (v * 6, r * 3)

wheeljack = Robot "Wheeljack" (11,30,4) wheeljackTransformacion
wheeljackTransformacion (_,v,r) = (v * 4, r * 3)

bumblebee = Robot "Bumblebee" (10,33,5) bumblebeeTransformacion
bumblebeeTransformacion (_,v,r) = (v * 4, r * 2)

shitbot = Robot "Shitbot" (0,0,0) shitbotTransfo 
shitbotTransfo (_,v,r) = (v,r)

autobots = [ optimus, jazz, wheeljack, bumblebee ]


--funciones

menos:: Int -> Int -> Int
menos val1 val2 = val1 - val2

maximoSegun:: (Int->Int->Int) -> Int -> Int -> Int
maximoSegun func val1 val2 | (func val1 val2) >= (func val2 val1) = val1
                           | otherwise = val2
                          

cualidadesR robot@(Robot _ c _ ) = c
cualidadesV vehiculo@(Vehiculo _ c) = c

transfRobot robot@(Robot _ _ t) = t


fuerza:: Autobot -> Int
fuerza robot@(Robot _ (fuerza,_,_) _) = fuerza 
fuerza vehiculo@ (Vehiculo _ _) = 0

velocidad:: Autobot -> Int
velocidad robot@(Robot _ (_,velocidad,_) _) = velocidad 
velocidad vehiculo@ (Vehiculo _ (velocidad,_)) = velocidad

resistencia:: Autobot -> Int
resistencia robot@(Robot _ (_,_,resistencia) _ ) = resistencia 
resistencia vehiculo@ (Vehiculo _ (_,resistencia)) = resistencia

nombre:: Autobot -> String
nombre robot@(Robot nombre _ _) = nombre
nombre vehiculo@(Vehiculo nombre _) = nombre

transformar1:: Autobot -> Autobot
transformar1 robot = Vehiculo (nombre robot) (transfRobot robot (cualidadesR robot))

--

esPositiva:: Bool -> Int -> Int -> Int
esPositiva True x y = x - y
esPositiva False x y = 0

resta:: (Bool -> Int -> Int -> Int) -> Int -> Int -> Int
resta esPositiva x y = esPositiva (x>y) x y

velocidadContra:: Autobot -> Autobot -> Velocidad
velocidadContra auto1 auto2 = (velocidad auto1) - resta esPositiva (fuerza auto2) (resistencia auto1)

elMasRapido:: Autobot -> Autobot -> Autobot
elMasRapido auto1 auto2 | velocidadContra auto1 auto2 > 0 = auto1
                        | otherwise = auto2

esMasRapido:: Autobot -> Autobot -> Bool
esMasRapido auto1 auto2 = velocidadContra auto1 auto2 > velocidadContra auto2 auto1

esMayor:: Velocidad -> Bool
esMayor velocidad = velocidad > 0

domina:: Autobot -> Autobot -> Bool
domina auto1 auto2 = esMasRapido auto1 auto2 && esMasRapido (transformar1 auto1) auto2 && esMasRapido (transformar1 auto1) (transformar1 auto2) && esMasRapido auto1 (transformar1 auto2) 


dominaAtodos:: Autobot -> [Autobot] -> Bool
dominaAtodos autobot autobots = not(any (==False) (map (domina autobot) autobots))


condicion1:: Autobot -> Bool
condicion1 autobot = velocidad autobot >= 30

quienesCumplen:: (Autobot->Bool) -> [Autobot] -> [Autobot]
quienesCumplen condicion autobots = filter condicion autobots


