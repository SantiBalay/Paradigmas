import Data.List
import Text.Show.Functions


 --------------------------Simulacro-------------------------------
type Conceptos = [(String, Int)]
type Nombre = String 

data Ayudante = UnAyudante Nombre Conceptos

instance Show Ayudante where
    show (UnAyudante nombre conceptos) = "Nombre: " ++  show nombre

nombre :: Ayudante -> Nombre
nombre (UnAyudante nombre _) = nombre

conceptos :: Ayudante -> Conceptos
conceptos (UnAyudante _ conceptos) = conceptos

guille :: Ayudante
guille = UnAyudante  "Guille" [("Orden Superior",6),("Expresiones Lambda", 7), ("Fold", 8)] 

chacal :: Ayudante
chacal = UnAyudante "Chacal" [("Aplicacion Parcial", 9),("Fold",6),("Sinonimos de Tipo", 7)]

vicky :: Ayudante 
vicky = UnAyudante "Vicky" [("Clases de Tipo", 5),("Aplicacion Parcial",8),("Tuplas",9), ("Orden Superior", 10)]

pibe10 :: Ayudante
pibe10 = UnAyudante "Pibe10" [("Clases de Tipo", 10),("Aplicacion Parcial",10),("Tuplas",10), ("Orden Superior", 10),("Prueba",10)]

ayudantes :: [Ayudante]
ayudantes = [guille,chacal,vicky]

cuantosConNivel :: Int -> [Ayudante] -> Int
cuantosConNivel nivel ayudantes = length (filter (tieneNivel nivel) ayudantes) 

tieneNivel :: Int -> Ayudante -> Bool
tieneNivel nivel ayudante = any (==nivel) (map snd (conceptos ayudante))

--estaAprendiendo ayudante = esCreciente ayudante

obtenerLista ayudante = map (snd) (conceptos ayudante)

estaAprendiendo ayudante = (obtenerLista vicky == sort(obtenerLista vicky))

gise:: Ayudante -> Int
gise ayudante = div (sum(obtenerLista ayudante)) (length (obtenerLista ayudante))

hernan:: Bool ->Ayudante -> Int
hernan bool ayudante = length (conceptos ayudante) + buenDia bool

marche:: Ayudante -> Int
marche ayudante | elem "Orden Superior" (map fst (conceptos ayudante)) = 9
                | otherwise = 5         

buenDia:: Bool -> Int
buenDia bool | bool = 5
             | otherwise = 0

type Juez = (Ayudante->Int)

aplicarJuez:: Ayudante -> Juez -> Int
aplicarJuez ayudante juez = juez ayudante

puntajes:: Ayudante -> [Juez] -> [Int]
puntajes ayudante jueces = map (aplicarJuez ayudante) jueces

promedio:: Ayudante -> [Juez] -> Int
promedio ayudante jueces =  div (sum (puntajes ayudante jueces)) (length (puntajes ayudante jueces))

esBuenAyudante:: Ayudante -> [Juez] -> Bool
esBuenAyudante ayudante jueces = all (>=7) (map (aplicarJuez ayudante) (jueces))

jueces1 = [gise,hernan True,marche,juezAnonimo]

juezAnonimo:: Ayudante -> Int
juezAnonimo x | (\y -> elem "Expresiones Lambda" (map fst(conceptos y))) x  = 10
              | otherwise = 9


cuantosSabe7:: Ayudante -> Int
cuantosSabe7 ayudante = length( filter (>7) (map snd (conceptos ayudante)))

sortTuplas (a1,b1) (a2,b2) | a1 > a2 = GT
                           | a1 < a2 = LT

sortAyudantes:: Ayudante -> Ayudante -> Ordering
sortAyudantes ayudante1 ayudante2 | length(conceptos ayudante1) >= length(conceptos ayudante2) = LT
                                  | length(conceptos ayudante1) < length(conceptos ayudante2)  = GT

sortJuez:: Juez -> Ayudante -> Ayudante -> Ordering
sortJuez juez ayudante1 ayudante2 | juez(ayudante1) >= juez(ayudante2) = LT
                                  | juez(ayudante1) < juez(ayudante2) = GT




--------------------
estaElemento:: String -> (String,Int) -> Bool
estaElemento elemento tupla = fst tupla == elemento

filtradoElemento:: String -> Ayudante -> Int
filtradoElemento elemento ayudante | (map snd (filter (estaElemento elemento) (conceptos ayudante)) /= [] )= head (map snd (filter (estaElemento elemento) (conceptos ayudante)))
                                   | otherwise = 0
----------------
sortElemento:: String -> Ayudante -> Ayudante -> Ordering
sortElemento elemento ayudante ayudante1 | (filtradoElemento elemento ayudante) >= (filtradoElemento elemento ayudante1) = LT
                                         | (filtradoElemento elemento ayudante) < (filtradoElemento elemento ayudante1) = GT

bestCriterio:: [Ayudante] -> (Ayudante -> Ayudante -> Ordering) -> Ayudante
bestCriterio ayudantes criterio = head (sortBy criterio ayudantes)


expresionLambda:: Integer -> Integer
expresionLambda x = (\y -> y + 4 ) x