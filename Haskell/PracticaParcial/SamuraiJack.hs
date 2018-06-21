import Text.Show.Functions
import Data.List
import Data.Ord


data Elemento = UnElemento { 
                tipo :: String,
                ataque :: (Personaje-> Personaje),
                defensa :: (Personaje-> Personaje) } 



data Personaje = UnPersonaje { 
                nombre :: String,
                salud :: Float,
                elementos :: [Elemento],
                anioPresente :: Int } deriving Show

mandarAlAnio:: Int -> Personaje -> Personaje
mandarAlAnio anio persona = persona { anioPresente = anio}

meditar:: Float -> Personaje -> Personaje
meditar sumSalud persona = persona { salud = (salud persona) + sumSalud/2}

causarDanio:: Float -> Personaje -> Personaje
causarDanio danio persona | danio > salud persona = persona { salud = 0}
                          | otherwise = persona { salud = (salud persona) - danio}

nada:: Personaje -> Personaje
nada persona = persona
-------

personajeX = UnPersonaje { nombre = "X" , salud = 10 , elementos = [elementoMalo], anioPresente = 2018}

personajeY = UnPersonaje { nombre = "Y" , salud = 150 , elementos = [elementoMalo], anioPresente = 2020}

elementoMalo = UnElemento { tipo = "Maldad", ataque = causarDanio 50, defensa = meditar 50}

esMalvado:: Personaje -> Bool
esMalvado persona = elem "Maldad" (map (tipo) (elementos persona))

danioProducido:: Personaje -> Elemento -> Float
danioProducido persona elemento | salud (ataque elemento persona) == 0 = salud (persona)
                                | otherwise = (salud persona) - salud (ataque elemento persona) 

puedeMorir_Ante:: Personaje -> Personaje -> Bool
puedeMorir_Ante persona1 persona2 = any (==True) (map (puedeMorir persona1) (elementos persona2))

puedeMorir:: Personaje -> Elemento -> Bool
puedeMorir persona elemento | salud (ataque elemento persona) == 0 = True
                            | otherwise = False

personas=[personajeY,personajeX]

enemigosMortales:: Personaje -> [Personaje] -> [Personaje]
enemigosMortales persona1 personas = filter (puedeMorir_Ante persona1) personas

concentracion:: Float -> Elemento
concentracion nivel = UnElemento {tipo = "Magia" ,ataque = nada , defensa = meditar nivel}

esbirro = UnElemento { tipo = "Maldad", ataque = causarDanio 1, defensa = nada }

instance Show Elemento where
    show (UnElemento tipo _ _ ) = show tipo

esbirrosMalvados:: Int -> [Elemento]
esbirrosMalvados numero = replicate numero esbirro

katana = UnElemento { tipo = "Magia" , ataque = causarDanio 1000, defensa = nada}

jack = UnPersonaje { nombre = "Jack", salud = 300, elementos = [concentracion 3,katana], anioPresente=300}

portal:: Int -> Float -> Elemento
portal anio salud = UnElemento { tipo = "Magia", ataque = mandarAlAnio (anio+2800) defensa=nada }

aku:: Int -> Float -> Personaje
aku anio saludDeseada = UnPersonaje { nombre = "Aku", salud=saludDeseada , elementos = [portal anio saludDeseada]++ esbirrosMalvados (100*anio) , anioPresente = anio}

