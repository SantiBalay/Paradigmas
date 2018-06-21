--Tp--

import Text.Show.Functions
import Data.List

data Cancion = UnaCancion{
    nombreCancion:: String,
    duracionCancion:: Int
}

data Cantante = UnCantante{
    nombre:: Int,
    canciones:: [Cancion]
}

nightFever = UnaCancion {
    nombre = "nightFever"
    duracionCancion = 4
}

foreverYoung = UnaCancion {
    nombre = "foreverYoung"
    duracionCancion = 5
}

tellYourWorld = UnaCancion {
    nombre = "tellYourWorld"
    duracionCancion = 4
}

novemberRain = UnaCancion {
    nombre = "tellYourWorld"
    duracionCancion = 4
}




megurineLuka = UnCantante {
    nombre = "megurineLuka"
    canciones
}