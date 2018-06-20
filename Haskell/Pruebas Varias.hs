import Text.Show.Functions
import Data.List
import Data.Char

data Barbaro = UnBarbaro {
    nombreBarbaro :: String,
    fuerza :: Int,
    habilidades :: [String],
    objetos:: [(Objeto->Barbaro)],
    grito :: String
} deriving Show

data Objeto = Espada String Int | Amuleto String

objetosV:: Objeto -> Barbaro
objetosV (Espada _ peso) = barbaro { fuerza = peso}