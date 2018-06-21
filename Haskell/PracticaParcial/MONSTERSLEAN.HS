import Text.Show.Functions

type Monstruo = Niño -> Grito
type Comediante = Niño -> Risa

--Punto 1
data Grito = UnGrito {
             onomatopeya :: String,
             intensidad :: Int,
             mojoLaCama :: Bool} deriving Show

energiaDeGrito :: Grito -> Int
energiaDeGrito (UnGrito onomatopeya intensidad True)  = nivelDeTerror onomatopeya * (intensidad^2)
energiaDeGrito (UnGrito onomatopeya intensidad False) = ((*3).nivelDeTerror) onomatopeya + intensidad

nivelDeTerror :: String -> Int
nivelDeTerror onomatopeya = length onomatopeya

grito1 :: Grito
grito1 = UnGrito "AAAAAHG" 10 True

grito2 :: Grito
grito2 = UnGrito "uf" 2 False

--Punto 2
data Niño = UnNiño {
            nombre :: String,
            edad :: Int,
            altura :: Float} deriving Show

kevin :: Niño
kevin = UnNiño "kevin" 2 1.1

sullivan :: Monstruo
sullivan niño@(UnNiño nombre edad altura) = UnGrito (nombreQueAplicaSullivan nombre) ((div) 20 edad) (esMenorA3 niño) 

nombreQueAplicaSullivan :: String -> String
nombreQueAplicaSullivan nombre = (replicate (length nombre)) 'A' ++ "GH"

esMenorA3 :: Niño ->  Bool
esMenorA3 (UnNiño _ edad _)  = edad < 3

randall :: Monstruo
randall niño@(UnNiño nombre edad altura) = UnGrito "¡Mamadera!" (cantidadDeVocales nombre) (alturaEntre niño 0.8 1.2)

alturaEntre :: Niño -> Float -> Float -> Bool
alturaEntre (UnNiño _ _ altura) num1 num2 = altura >= num1 && altura <= num2

esVocal :: Char -> Bool
esVocal 'a' = True
esVocal 'A' = True
esVocal 'e' = True
esVocal 'E' = True
esVocal 'i' = True
esVocal 'I' = True
esVocal 'o' = True
esVocal 'O' = True
esVocal 'u' = True
esVocal 'U' = True 
esVocal _   = False

cantidadDeVocales :: String -> Int
cantidadDeVocales [] = 0
cantidadDeVocales (x:xs) | esVocal x = 1 + cantidadDeVocales xs
                         | otherwise = 0 + cantidadDeVocales xs

chuck :: Monstruo
chuck niño = UnGrito ['a'..'z'] 1000 True

osito :: Monstruo
osito (UnNiño _ edad _) = UnGrito "uf" edad False 

-- Punto 3

pam :: [(a -> b)] -> a -> [b]
pam lista elemento = map (aplicarElemento elemento) lista

aplicarElemento :: a -> (a -> b) -> b
aplicarElemento elemento funcion = funcion elemento

--Punto 4
monstruos :: [Monstruo]
monstruos = [sullivan, osito, chuck]

gritos :: [Monstruo] -> Niño -> [Grito]
gritos monstruos niño = pam monstruos niño

--Punto 5
leandro = UnNiño "Leandro" 5 0.89

julian = UnNiño "Julian" 3 0.45

santiago = UnNiño "Santiago" 4 0.5

campamento :: [Niño]
campamento = [kevin, leandro, julian, santiago ]

produccionEnergeticaGritos :: [Monstruo] -> [Niño] -> Int
produccionEnergeticaGritos monstruos campamento = sum (energiaGritos monstruos campamento)

energiaGritos :: [Monstruo] -> [Niño] -> [Int]
energiaGritos monstruos campamento = (map energiaDeGrito.concat.map (gritos monstruos)) campamento

--Punto 6
data Risa = UnaRisa {
            duracion :: Int,
            intensidadRisa :: Int} deriving Show

energiaDeRisa :: Risa -> Int
energiaDeRisa (UnaRisa duracion intensidadRisa) = duracion ^ intensidadRisa

risa1 :: Risa
risa1 = UnaRisa 30 10

risa2 :: Risa
risa2 = UnaRisa 15 22

risa3 :: Risa
risa3 = UnaRisa 5 38

comediantes = [capusotto,capusotto]

capusotto :: Comediante
capusotto (UnNiño _ edad _) = UnaRisa (2*edad) edad

--produccionEnergeticaRisas :: [Comediante] -> [Niño] -> Int
--produccionEnergeticaRisas comediantes campamento = (sum.map energiaDeRisa) (hacerReirCampamento comediantes campamento)

risas :: [Comediante] -> Niño -> [Risa]
risas comediantes niño = pam niño comediantes