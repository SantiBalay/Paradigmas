import Data.List
import Text.Show.Functions

type Persona = (Integer,Double,Integer)

edad (e,_,_) = e
peso (_,p,_) =  p
tonificacion (_,_,t) = t

pancho = (fromInteger 40,realToFrac 120.0,fromInteger 1)
andres = (fromInteger 22,realToFrac 80,fromInteger 6)

esObeso persona = peso persona > 100


esSaludable persona =  (not.esObeso) persona && (tonificacion persona) > 5

quemarCalorias:: Persona -> Double -> Persona
quemarCalorias persona cal | esObeso persona = (edad persona,peso persona-(1/150)*cal,tonificacion persona)
                           | (not.esObeso) persona && (edad persona) > 30 = (edad persona,peso persona-1,tonificacion persona)
                           | otherwise = (edad persona,peso persona,tonificacion persona)