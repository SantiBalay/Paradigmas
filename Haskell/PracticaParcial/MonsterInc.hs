import Text.Show.Functions
import Data.List


word (w, _ , _) = w

intensidad (_ ,i, _) = fromIntegral i

mojo (_, _, m) = m


grito1 = ("AAAAAHG",10,True)
grito2 = ("uf",2,False)

energiaGrito:: Grito -> Int
energiaGrito grito | mojo grito = (length (word grito)) * (intensidad grito)^2
                   | not (mojo grito) = 3*(length (word grito)) + (intensidad grito)


type Nene = (String,Integer,Integer)


nombre (w, _ , _) = w

edad (_ ,i, _) = fromIntegral i

altura (_, _, m) = fromIntegral m



sullivan:: Nene -> Grito
sullivan nene = ((concat (replicate (length (nombre nene)) "H")++ "GH") , div (edad nene) 20 , edad nene > 3 )

esVocal a  = a == 'a' || a == 'e'|| a == 'i'|| a == 'o'|| a == 'u'

randall:: Nene -> Grito
randall nene = ("Mamadera",fromIntegral(length(filter esVocal (nombre nene))), altura nene > 4 && altura nene < 7)

nene1 = ("Nene",5,5)

chucknorris:: Nene -> Grito
chucknorris nene = ("abcdefghijklmnñopqrstuvwxyz",1000,True)

osito:: Nene -> Grito
osito nene = ("uf", edad nene, False)

monstruos = [sullivan,randall]

nenes = [nene1,nene2]

nene2 = ("Neneeee",10,5)

--
doble:: Int -> Int
doble n = 3*n

triple:: Int-> Int
triple n = 2*n

lista = [doble,triple]

aplicarFuncion:: Int -> (Int->Int) -> Int
aplicarFuncion v funcion = funcion v 

pam:: [(Int->Int)] -> Int -> [Int]
pam funciones valor = map (aplicarFuncion 4) funciones

---
aplicarNene:: Nene -> (Nene->Grito) -> Grito
aplicarNene nene monstruo = monstruo nene

gritos:: Nene -> [(Nene->Grito)] -> [Grito]
gritos nenex monstruos = map (aplicarNene nenex) monstruos

cuantoMonstruo:: [Nene] -> (Nene->Grito)-> Int
cuantoMonstruo nenes monstruo = sum ( map energiaGrito (map monstruo nenes))

teamMonstruo:: [Nene] -> [(Nene->Grito)] -> Int
teamMonstruo nenes monstruos1 = sum (map (cuantoMonstruo nenes) monstruos1)




comediantes=[capussoto,otroComediante]

capussoto:: Nene -> Risa
capussoto nene = (2*(edad nene),2*(edad nene))

otroComediante:: Nene -> Risa
otroComediante nene = (125,100)

aplicarNene2:: Nene -> (Nene->Risa) -> Risa
aplicarNene2 nene comediante  = comediante nene

aplicarComediantes:: [(Nene->Risa)] -> Nene -> [Risa]
aplicarComediantes comediantes nene = map (aplicarNene2 nene) comediantes

campamentoComediantes:: [Nene] -> [(Nene->Risa)] -> Int
campamentoComediantes nenes comediantes= sum(map fst (concat(map (aplicarComediantes comediantes) nenes)))

data Energia = UnGrito Grito | UnaRisa Risa

grito4 = UnGrito ("AAAAAHG",10,True) 
risa4 = UnaRisa (10,10)

type Grito = (String,Integer,Bool)
type Risa = (Int,Int)

gritosVarios:: Energia -> Int
gritosVarios grito1@(UnGrito grito) = intensidad grito
gritosVarios risa1@(UnaRisa risa) = 40



-----

data Productor = UnMonster Monster | UnComediante Comediante

type Monster = [Nene -> Grito]
type Comediante = [Nene -> Risa]

monstruosPrueba = UnMonster [sullivan,randall]
comediantesPrueba = UnComediante [capussoto,otroComediante]


campamentos:: [Nene] -> Productor -> Int
campamentos nenes comediante1@(UnComediante comediantes)= sum(map fst (concat(map (aplicarComediantes comediantes) nenes)))
campamentos nenes monstruos2@(UnMonster monstruos1) = sum (map (cuantoMonstruo nenes) monstruos1)
















