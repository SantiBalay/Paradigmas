import Data.List
import Text.Show.Functions

{-
data Pibe = UnNene String Int Int | UnaNena String Int deriving Show

sortByPeso:: Pibe -> Pibe -> Ordering
sortByPeso pibe1 pibe2 | peso pibe1 > peso pibe2 = GT
                       | otherwise = LT

juan = UnNene "Juan" 5 5 
maria = UnaNena "Maria" 4

peso:: Pibe -> Int
peso nena@(UnaNena _ peso) = peso
peso nene@(UnNene _ _ peso) = peso

numero1:: Integer
numero1 = 5

numero2:: Float
numero2 = 4.5
-}

data Persona = UnaPersona {
    nombre:: String,
    habilidadesP:: [String],
    sonBuenas:: Bool
} 

instance Show Persona where
    show (UnaPersona nombre _ _ ) = show nombre  

data Ranger = UnRanger {
    color:: String,
    habilidadesR:: [String],
    nivel:: Int
} deriving (Show,Eq)

alex = UnaPersona "Alex" ["Nada","LaPaja"] True
john = UnaPersona "John" ["Bailar","LaPaja"] False
roby = UnaPersona "Roby" ["Volar","LaPaja"] True

rangerRojo = UnRanger "Rojo" (replicate 6 "SerCrack") 10
rangerAzul = UnRanger "Azul" ["Pelear","SerAzul"] 15
rangerVerde = UnRanger "Verde" ["Pelear","SerVerde"] 9

hacerSuper:: String -> String
hacerSuper skill = "Super" ++ skill

cuantoNivel:: [String] -> Int
cuantoNivel habilidades = length (concat (habilidades))

convertirEnPowerRanger:: String -> Persona -> Ranger
convertirEnPowerRanger queColor persona = UnRanger { color = queColor, habilidadesR = map (hacerSuper) (habilidadesP persona), nivel = cuantoNivel (habilidadesP persona)}

sonBuenos:: [Persona] -> [Persona]
sonBuenos personas = filter ((==True).sonBuenas) personas

colores = ["Rojo","Rosa","Azul"]
personas= [alex,john,roby]
rangerss=[rangerVerde,rangerAzul]

convertirEnTupla:: (String,Persona) -> Ranger
convertirEnTupla tupla = convertirEnPowerRanger (fst tupla) (snd tupla)

formarEquipo:: [String] -> [Persona] -> [Ranger]
formarEquipo colores personas = map convertirEnTupla (zip colores (sonBuenos personas))

rangerLider:: [Ranger] -> Ranger
rangerLider rangers | elem (rangerRojo) rangers = rangerRojo
                    | otherwise = head(rangers)

poder:: Ranger -> Ranger -> Ordering
poder ranger1 ranger2 | nivel ranger1 > nivel ranger2 = LT
                      | otherwise = GT

rangerMasPoderoso:: [Ranger] -> Ranger
rangerMasPoderoso rangers = head (sortBy poder rangers)

rangerHabil:: Ranger -> Bool
rangerHabil ranger = ((>5).length.habilidadesR) ranger

alfa5= UnRanger "Metalico" (["Reparar"]++repeat "ay") 0


