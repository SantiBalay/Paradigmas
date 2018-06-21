import Text.Show.Functions
import Data.List
import Data.Char

data Barbaro = UnBarbaro {
    nombreBarbaro :: String,
    fuerza :: Int,
    habilidades :: [String],
    objetos:: [(Barbaro->Barbaro)],
    grito :: String
} 

data Espada = UnaEspada {
    nombreEspada :: String,
    peso :: Int
}

data Amuleto = UnAmuleto {
    habilidadAmuleto :: String
}

data Varita = UnaVarita {
    habilidadVarita :: String
}

data Megafono = UnMegafono {
    habilidadesMeganofo :: (Barbaro->Barbaro)
}
roco = UnBarbaro {
    nombreBarbaro = "Rocoloco",
    fuerza = 100,
    habilidades = ["Nada"],
    objetos = [usarEspada espada1, usarAmuleto amuleto1], 
    grito = "OOOOOOOOOOOOOOO"
}

santi = UnBarbaro {
    nombreBarbaro = "Santi",
    fuerza = 50,
    habilidades = ["Robar"],
    objetos = [], 
    grito = "OOOOOOOOOOOOOOO"
}

faffy = UnBarbaro {
    nombreBarbaro = "Faffy",
    fuerza = 1000,
    habilidades = ["Robar"],
    objetos = [usarEspada espada1], 
    grito = "TOMAAAAAAAAAAAAAAA"
}
--Objetos

espada1 = UnaEspada {
    nombreEspada = "espada",
    peso = 5
}

amuleto1 = UnAmuleto {
    habilidadAmuleto = "Caca"
}

varita1 = UnaVarita {
    habilidadVarita = "Magia"
}

--Funciones

usarAmuleto:: Amuleto -> Barbaro -> Barbaro
usarAmuleto amuletoX barbaro = barbaro { habilidades = habilidades barbaro ++ [habilidadAmuleto amuletoX]}

usarVarita:: Varita -> Barbaro -> Barbaro
usarVarita varitaX barbaro = barbaro { habilidades = habilidades barbaro ++ [habilidadVarita varitaX] , objetos = []}

usarEspada:: Espada -> Barbaro -> Barbaro
usarEspada espadaX barbaro = barbaro {fuerza = fuerza barbaro + 2*(peso espadaX)}

cuerda:: (Barbaro->Barbaro) -> (Barbaro->Barbaro) -> (Barbaro->Barbaro)
cuerda objeto1 objeto2= objeto1.objeto2

megafono:: Barbaro -> Barbaro
megafono barbaro = barbaro { habilidades = [map (toUpper) (concat (habilidades barbaro))]}



invasion:: Barbaro -> Bool
invasion barbaro = elem ("Escribir Poesia Atroz") (habilidades barbaro)

cremallera:: Barbaro -> Bool
cremallera barbaro = (nombreBarbaro barbaro== "Faffy") || (nombreBarbaro barbaro== "Astro")

ritual:: Barbaro -> Bool
ritual barbaro | fuerza barbaro >= 80 && elem ("Robar") (habilidades barbaro) = True
               | fuerza barbaro >= 4*length(objetos barbaro) && (length.grito) barbaro == (length.nombreBarbaro) barbaro = True
               | (length.filter esVocal.nombreBarbaro) barbaro >= 4 && (isUpper.head.nombreBarbaro) barbaro= True
               | otherwise = False

esVocal :: Char -> Bool
esVocal x | x == 'a' = True
                | x == 'e' = True
                | x == 'i' = True
                | x == 'o' = True
                | x == 'u' = True
                | otherwise = False

--sobrevive :: [(Barbaro->Bool)] -> [Barbaro] -> [Barbaro]
---sobrevive aventura barbaros = filter 

aventura = [ritual,cremallera]
barbaros = [roco,santi,faffy]

sobrevive:: [(Barbaro->Bool)] -> Barbaro -> Bool
sobrevive [] barbaro = True
sobrevive (x:xs) barbaro | x barbaro = sobrevive xs barbaro
                         | otherwise = False

sobreviven:: [(Barbaro->Bool)] -> [Barbaro] -> [Barbaro]
sobreviven aventura1 barbaros = filter (sobrevive aventura1) barbaros 

instance Eq Barbaro where
    barbaro == barbaro2 = habilidades barbaro == habilidades barbaro2

instance Show Barbaro where
   show (UnBarbaro nombreBarbaro b c d e) = show nombreBarbaro 


sinRepetidos:: [Barbaro] -> [Barbaro] 
sinRepetidos [] = []
sinRepetidos (x:xs) | xs == [] = [x]
                    | x == head xs = sinRepetidos xs
                    | x /= head xs = (sinRepetidos xs) ++ [x]


nombreDecendiente:: Barbaro -> Barbaro
nombreDecendiente barbaro = barbaro { nombreBarbaro = nombreBarbaro barbaro ++ "*"}
                  

aplicarObjeto:: Barbaro -> (Barbaro->Barbaro) -> Barbaro
aplicarObjeto barbaro objeto = objeto (barbaro)

aplicarObjetoDescendiente:: Barbaro -> Barbaro
aplicarObjetoDescendiente barbaro = foldl (aplicarObjeto) (barbaro) (objetos barbaro)

decendiente:: Barbaro -> Barbaro
decendiente barbaro = aplicarObjetoDescendiente (nombreDecendiente barbaro)