import Text.Show.Functions
import Data.List

thrd:: (a,b,c) -> c
thrd (_,_,c) = c

type Fecha = (Integer,Integer,Integer)

type CondicionViaje = (Viaje->Bool)

data Cliente = UnCliente {
    nombreCliente:: String,
    dondeVive::String
} deriving (Eq, Show)

data Viaje = UnViaje {
    fecha:: Fecha,
    cliente:: Cliente,
    costo:: Int
} deriving (Eq, Show)

data Chofer = UnChofer {
    nombre:: String,
    kms:: Int,
    viajes::[Viaje],
    condicion:: CondicionViaje
} deriving Show

cualquierViaje:: Viaje -> Bool
cualquierViaje viaje = True

lucas = UnCliente {
    nombreCliente = "Lucas",
    dondeVive = "Olivos"
}

viaje1 = UnViaje {
    fecha = (20,04,2017),
    cliente = lucas,
    costo = 150
}


viaje2 = UnViaje {
    fecha = (20,05,2017),
    cliente = lucas,
    costo = 200
}


daniel = UnChofer {
    nombre = "Daniel",
    kms=23500,
    viajes = [viaje1],
    condicion = noVivaEn "Olivos"
}

alejandra = UnChofer {
    nombre = "Alejandra",
    kms=180000,
    viajes = [],
    condicion = cualquiera
}


cualquiera:: CondicionViaje
cualquiera _ = True

masDe200:: CondicionViaje
masDe200 = (>200).costo 

masDeNLetras:: Int -> CondicionViaje
masDeNLetras n = (>n).(length.nombreCliente.cliente)

noVivaEn:: String -> CondicionViaje
noVivaEn zona = (zona/=).(dondeVive.cliente) 

puedeTomar:: Viaje -> Chofer -> Bool
puedeTomar viaje chofer = (condicion chofer) viaje
 
liquidacion:: Chofer -> Int
liquidacion taxi = sum (map costo(viajes taxi)) 

listachoferes = [alejandra,daniel]

quienesLoToman:: [Chofer] -> Viaje -> [Chofer]
quienesLoToman lista viaje= filter (puedeTomar viaje) lista

menosViajes:: Chofer -> Chofer -> Chofer
menosViajes chofer chofer2 | (length.viajes) chofer > (length.viajes) chofer2 = chofer2
                           | otherwise = chofer

elDeMenosViajes:: [Chofer] -> Chofer
elDeMenosViajes lista = foldl1 menosViajes lista

hacerViaje:: Chofer -> Viaje -> Chofer
hacerViaje chofer viaje = chofer { viajes = viajes chofer ++[viaje]}