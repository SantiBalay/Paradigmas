import Text.Show.Functions
import Data.List



data Aspecto = UnAspecto {
  tipoDeAspecto :: String,
  grado :: Float
} 
type Situacion = [Aspecto]





mejorAspecto mejor peor = grado mejor < grado peor

mismoAspecto aspecto1 aspecto2 = tipoDeAspecto aspecto1 == tipoDeAspecto aspecto2

buscarAspecto aspectoBuscado = head.filter (mismoAspecto aspectoBuscado)


reemplazarAspecto aspectoBuscado situacion = aspectoBuscado : (filter (not.mismoAspecto aspectoBuscado) situacion)



tension = UnAspecto { tipoDeAspecto = "Tension", grado= 15}

tension2 = UnAspecto { tipoDeAspecto = "Tension", grado= 10}

peligro = UnAspecto { tipoDeAspecto = "Peligro", grado= 5}

peligro2 = UnAspecto { tipoDeAspecto = "Peligro", grado= 3}

insertidumbre = UnAspecto { tipoDeAspecto = "Insertidumbre", grado= 17}

insertidumbre2 = UnAspecto { tipoDeAspecto = "Insertidumbre", grado= 15}


types:: Aspecto -> Aspecto -> Ordering
types aspecto1 aspecto2 | tipoDeAspecto aspecto1 >= tipoDeAspecto aspecto2 = GT
                        | otherwise = LT

instance Show Aspecto where
    show(UnAspecto tipo _) = show tipo 



aspectos= [tension,peligro,insertidumbre]

aspectos2=[tension2,peligro2,insertidumbre2]

modificarAspecto:: (Float->Float) -> Aspecto -> Aspecto
modificarAspecto funcion aspecto = aspecto { grado= funcion (grado aspecto)}

sumar5:: Float -> Float
sumar5 n1 = n1 + 5

instance Eq Aspecto where
    aspecto1 == aspecto2 = grado aspecto1 == grado aspecto2

instance Ord Aspecto where
    aspecto1 <= aspecto2 = grado aspecto1 <= grado aspecto2 
   

esMejor:: [Aspecto] -> [Aspecto] -> Bool
esMejor x y | x == [] || y == [] = True
            | head (sortBy types x) <= head (sortBy types y) = False 
            | head (sortBy types x) > head (sortBy types y) = esMejor (tail (sortBy types x)) (tail(sortBy types y))
            | otherwise = True 
                      





















