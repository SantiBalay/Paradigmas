--Tp--

import Text.Show.Functions
import Data.List

type Cancion = (String,Int)

data Cantante = UnCantante {
    nombre:: String,
    canciones:: [Cancion]
} deriving (Eq,Show)
 

megurineLuka = UnCantante {
    nombre = "MegurineLuka",
    canciones =[("nightFever",4),("foreverYoung",5)]
}

hatsuneMiku = UnCantante {
    nombre = "hatsuneMiku",
    canciones =[("tellYourWorld",4)]
}

gumi = UnCantante {
    nombre = "gumi",
    canciones=[("foreverYoung",4),("tellYourWorld",5)]
}

seeU = UnCantante {
    nombre = "seeU",
    canciones=[("novemberRain",6),("nightFever",5)]
}

kaito = UnCantante {
    nombre = "kaito",
    canciones=[]
}






esNovedoso:: Cantante -> Bool
esNovedoso cantante = length (canciones cantante) >= 2 && sum (map snd (canciones cantante)) <= 15

esAscelerado:: Cantante -> Bool
esAscelerado cantante = all (>4) (map snd (canciones cantante))