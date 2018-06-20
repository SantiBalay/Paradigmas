import Text.Show.Functions
import Data.List
import Data.Char

type Fecha= (Int,Int,Int)

type Condicion = (Viaje -> Bool)

data Chofer = UnChofer { 
    nombreChofer :: String,
    kilometraje :: Int,
    viajes :: [Viaje],
    condiciones :: Condicion
} deriving Show

data Viaje = UnViaje {
    fecha :: Fecha,
    costo :: Int,
    cliente :: Cliente
} deriving Show

data Cliente = UnCliente {
    nombreCliente :: String,
    dondeVive :: String
} deriving Show


masDe200:: Viaje -> Bool 
masDe200 viaje = ((>200).costo) viaje

tieneNletras:: Int -> Viaje -> Bool
tieneNletras n viaje = n /= (length.nombreCliente.cliente) viaje

noViveEn:: String -> Viaje -> Bool
noViveEn zona viaje = zona /= (dondeVive.cliente) viaje

cualquiera:: Viaje -> Bool
cualquiera _ = True


lucas = UnCliente { nombreCliente = "Lucas", dondeVive ="Victoria"}
daniel= UnChofer { nombreChofer = "Daniel", kilometraje = 23500, viajes =[viaje1], condiciones = noViveEn "Olivos"}
viaje1= UnViaje { fecha = (20,04,2017), costo = 150, cliente= lucas}
alejandra = UnChofer { nombreChofer = "Alejandra", kilometraje = 180000, viajes = [], condiciones = cualquiera}

puedeTomarViaje :: Viaje -> Chofer -> Bool
puedeTomarViaje viaje chofer = (condiciones chofer) viaje 



liquidacion:: Chofer -> Int
liquidacion chofer = sum (map costo (viajes chofer))

tieneMenosViajes:: [Chofer] -> Chofer
tieneMenosViajes (x:[]) = x
tieneMenosViajes (x:xs) | (length.viajes) x >= (length.viajes) (head xs) = tieneMenosViajes xs
                        | (length.viajes) x < (length.viajes) (head xs) = tieneMenosViajes ([x]++tail xs)

choferes = [daniel,alejandra]

cumplenCondicion:: [Chofer] -> Viaje  -> [Chofer]
cumplenCondicion choferes viaje = filter (puedeTomarViaje viaje) choferes

seleccionarChofer:: [Chofer] -> Viaje -> Chofer
seleccionarChofer choferes viaje = tieneMenosViajes (cumplenCondicion choferes viaje)
 
efectuarViaje:: [Chofer] -> Viaje -> Chofer
efectuarViaje choferes viaje = (tieneMenosViajes (cumplenCondicion choferes viaje)) {viajes = viajes (tieneMenosViajes (cumplenCondicion choferes viaje)) ++ [viaje] }

nito = UnChofer { nombreChofer = "Nito", kilometraje = 70000, viajes =(repeat viajeInf), condiciones = tieneNletras 3}

viajeInf = UnViaje { fecha = (11,03,2017), costo = 50,cliente=lucas}

