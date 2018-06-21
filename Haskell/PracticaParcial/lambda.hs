import Data.List
import Text.Show.Functions

data Pibe = UnNene String Int Int | UnaNena String Int deriving Show

sortByPeso:: Pibe -> Pibe -> Ordering
sortByPeso pibe1 pibe2 | peso pibe1 > peso pibe2 = GT
                       | otherwise = LT


juan = UnNene "Juan" 5 5 

maria = UnaNena "Maria" 4

peso:: Pibe -> Int
peso nena@(UnaNena _ peso) = peso
peso nene@(UnNene _ _ peso) = peso


numero1:: Integer
numero1 = 5

numero2:: Float
numero2 = 4.5

