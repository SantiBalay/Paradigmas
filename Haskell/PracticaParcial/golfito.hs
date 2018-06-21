import Data.List
import Text.Show.Functions


bart = ("Bart","Homero",(25,60)) --fuerza/presicion
todd = ("Todd","Ned",(15,80))
rafa = ("Rafa","Gorgory",(10,1))
nombre (n,_,_) = n
padre (_,p,_) = p
habilidad (_,_,h) = h

fuerza (_,_,(fue,_))=fue
presicion (_,_,(_,pre))=pre

type Tiro = (Integer,Integer,Integer) -- vel/pre/alt

type Persona = (String,String,(Integer,Integer))

type Palo = (Persona->Tiro)

putter:: Persona -> Tiro
putter persona = (10,2*(snd.habilidad)persona,0)

madera:: Persona -> Tiro
madera persona = (100 ,div (presicion persona) 2,5)

hierros:: Integer -> Persona -> Tiro
hierros n persona = ((presicion persona*fuerza persona),(div (presicion persona) n),(n^2))
 
----------

laguna largo (v,p,a) = ((\(v,_,a)-> v>80 && between 10 50 a),(\(v,p,a) -> (v,p,a `div` largo)))

tunelConRampita (v,p,a) = ((\(_,p,a) -> p>90 && a==0), (\(v,_,a) -> (v*2,100,0)) )

hoyo (v,p,a) = ((\(v,p,a) -> between 5 20 v && p>95 && a==0), (\ _ -> (0,0,0)))

between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b | f a >= f b = a
                 | otherwise = b

----------


golpe:: Persona -> Palo -> Tiro
golpe persona palo = palo persona

--puedeSuperar:: Tiro -> ( Tiro -> Bool , Tiro -> Tiro ) -> Bool
--puedeSuperar tiro = 