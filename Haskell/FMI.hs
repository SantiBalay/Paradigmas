import Data.List
import Text.Show.Functions

data Pais = UnPais {
    ingreso:: Float,
    pPrivada:: Int, 
    pPublica:: Int,
    recursos:: [String],
    deuda:: Float -- En Millones
} deriving Show


paisx = UnPais { ingreso = 10, pPrivada =10, pPublica =15, recursos = ["Mineria","Caca","Petroleo"], deuda = 1000}

namibia = UnPais { ingreso = 4140, pPrivada=650000, pPublica=400000, recursos = ["Mineria","Ecoturismo"], deuda = 50}
 
mejorPais = UnPais { ingreso = 10000000000 , pPrivada=650000, pPublica=400000, recursos = ["Mineria","Ecoturismo"], deuda = 50}

--Recetas

prestar:: Float -> Pais -> Pais
prestar n pais = pais { deuda = (deuda pais) + (1.5*n)}

reducir:: Int -> Pais -> Pais
reducir n pais | n > 100 = pais { pPublica = (pPublica pais) - n, ingreso = (ingreso pais)-(0.2)*(ingreso pais)}
               | otherwise = pais { pPublica = (pPublica pais) - n}

explotacion:: String -> Pais -> Pais
explotacion recurso pais | elem recurso (recursos pais) = pais { recursos = filter (/=recurso) (recursos pais), deuda = (deuda pais) - 2}
                         | otherwise = pais 

productoBruto:: Pais -> Float
productoBruto pais = (ingreso pais) * realToFrac(pPrivada pais + pPublica pais)

blindaje:: Pais -> Pais
blindaje pais = pais { deuda = (deuda pais) + (productoBruto pais)/2 , pPublica = (pPublica pais) - 500}

receta = [prestar 5, explotacion "Mineria"]

paises = [paisx,namibia,mejorPais]

aplicarPlan:: Pais -> (Pais->Pais) -> Pais
aplicarPlan pais plan = plan pais

aplicarReceta:: Pais -> [(Pais->Pais)] -> Pais
aplicarReceta pais receta = foldl (aplicarPlan) pais receta


cualesSafan:: [Pais] -> [Pais]
cualesSafan paises = filter (elem ("Petroleo").recursos) paises

sumaDeudas:: [Pais] -> Float
sumaDeudas paises = sum (map deuda paises)

estaOrdenado:: Pais -> [(Pais->Pais)] -> Bool
estaOrdenado pais [] = True
estaOrdenado pais [_] = True
estaOrdenado pais (x:xs) | (productoBruto (x pais)) < (productoBruto ((head xs)pais)) = estaOrdenado pais xs
                         | otherwise = False

--estaOrdenada [] pais = True
--estaOrdenada [_] pais  = True
--estaOrdenada (receta1:receta2:recetas) pais = (pbi (receta1 pais)) <= (pbi (receta2 pais)) && estaOrdenada (receta2:recetas) pais















