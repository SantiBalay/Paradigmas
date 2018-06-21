import Data.List
import Text.Show.Functions

algunosVigilantes = [("El Comediante", ["Fuerza","Gobierno"], 1942), ("Buho Nocturno", ["Lucha", "Ingenierismo"], 1963), ("Rorschach", ["Perseverancia", "Deduccion", "Sigilo"], 1964), ("Espectro de Seda", ["Lucha", "Sigilo", "Fuerza"], 1962), ("Ozimandias", ["Inteligencia", "Más Inteligencia Aún"], 1968), ("Buho Nocturno", ["Lucha", "Inteligencia", "Fuerza"], 1939), ("Espectro de Seda", ["Lucha", "Sigilo"], 1940)]

agentesDelGobierno = [("Jack Bauer","24"), ("El Comediante", "Watchmen"), ("Dr. Manhattan", "Watchmen"), ("Liam Neeson", "Taken"),("Rorschach","Watchmen")]


type Agente = (String,String)

nombreA (nombre,_) = nombre
serie (_,serie) = serie

type Vigilante = (String,[String],Integer)

nombreV (nombre,_,_) = nombre
habilidades (_,habilidades,_) = habilidades
aparicion (_,_,aparicion) = aparicion

esRorschachManhattan:: Vigilante -> Bool
esRorschachManhattan vigilante = (nombreV vigilante /= "Rorschach" ) || (nombreV vigilante /= "Manhattan")

destruccionNed:: [Vigilante] -> [Vigilante]
destruccionNed vigilantes = filter (esRorschachManhattan) vigilantes

muerteDe:: String -> [Vigilante] -> [Vigilante]
muerteDe vigilante vigilantes = filter ((/=vigilante).nombreV) vigilantes



--guerra de Vietnam: a los vigilantes que además son agentes del gobierno les agrega Cinismo como habilidad, a los restantes no.

estaEnLaLista:: [Vigilante] -> Agente -> [Vigilante]
estaEnLaLista vigilantes agente = (filter ((==(nombreA agente)).nombreV) vigilantes)

noEstaEnLaLista:: [Vigilante] -> Agente -> [Vigilante]
noEstaEnLaLista vigilantes agente = (filter ((/=(nombreA agente)).nombreV) vigilantes)

sonAgentes:: [Vigilante] -> [Agente] -> [Vigilante]
sonAgentes vigilantes agentes = concat (map (estaEnLaLista algunosVigilantes) agentes)

noSonAgentes:: [Vigilante] -> [Agente] -> [Vigilante]
noSonAgentes vigilantes agentes = concat (map (noEstaEnLaLista algunosVigilantes) agentes)

hacerCinico vigilante = (nombreV vigilante,(habilidades vigilante)++["Cinismo"],aparicion vigilante)

guerraVietnam:: [Vigilante] -> [Agente] -> [Vigilante]
guerraVietnam vigilantes agentes = (map hacerCinico (sonAgentes vigilantes agentes)) ++ (noSonAgentes vigilantes agentes)



---------------------------


accidente:: Integer -> Vigilante
accidente anio = ("Dr Manhattan",["Manipulacion"],anio)


---No Funciona
esElJoven:: Vigilante -> Vigilante -> Bool
esElJoven vigilante vigilanteViejo = ((nombreV vigilante)) == (nombreV vigilanteViejo) && ((aparicion vigilante) > (aparicion vigilanteViejo))
                                   
dameAlJoven:: [Vigilante] -> Vigilante -> [Vigilante]
dameAlJoven vigilantes vigilante = filter (esElJoven vigilante) vigilantes 

dameALosJovenes:: [Vigilante] -> [Vigilante]
dameALosJovenes vigilantes = concat (map (dameAlJoven vigilantes) vigilantes)

sonDistintos:: Vigilante -> Vigilante -> Bool
sonDistintos vigilante vigilante1 = nombreV vigilante == nombreV vigilante1 && (aparicion vigilante1 /= aparicion vigilante)

sacarIguales:: [Vigilante] -> Vigilante -> [Vigilante]
sacarIguales vigilantes vigilante = filter (sonDistintos vigilante) vigilantes

-------------------------

name:: Vigilante -> Vigilante -> Ordering
name vig1 vig2 | nombreV vig1 >= nombreV vig2 = GT
               | nombreV vig1 < nombreV vig2 = LT
 
elMasJoven vig1 vig2 | aparicion vig1 > aparicion vig2 = vig1
                     | aparicion vig2 > aparicion vig1 = vig2

repetido:: [Vigilante] -> [Vigilante]
repetido (x:y:z:zs) | (nombreV x == nombreV y) && (elMasJoven x y == x) = [x] ++ repetido (z:zs)
                    | (nombreV x == nombreV y) && (elMasJoven x y == y) = [y] ++ repetido (z:zs)
                    | (length (x:y:z:zs) == 2) && (elMasJoven x y == x) = [x]
                    | (length (x:y:z:zs) == 2 )&& (elMasJoven x y == y) = [y]
                    | otherwise = [x]
                   
                 


--estaEnLaLista1 vigilantes vigilante
