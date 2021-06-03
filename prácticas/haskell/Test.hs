module Main
    where

import System.IO
import Data.Maybe
import Data.Either

valorAbsoluto :: Float -> Float
valorAbsoluto x 
    | x >= 0 = x
    | otherwise = (-x)

factorial :: Int -> Maybe Int
factorial x 
    | x < 0 = Nothing
    | x < 2 = Just 1
    | otherwise = Just(x * fromJust(factorial (x - 1)))

factorial2 :: Int -> Maybe Int
factorial2 x 
    | x < 0 = Nothing
    | x < 2 = Just 1
    | otherwise = factorial2 (x - 1) >>= \y -> Just $ x * y

inverso :: Float -> Maybe Float
inverso x 
    | x == 0 = Nothing
    | otherwise = Just (1 / x)

aEntero :: Either Int Bool -> Int
aEntero x 
    | x == Right True = 1
    | x == Right False = 0
    | otherwise = fromLeft 0 x
-- Usar con
-- aEntero (Right True)
-- aEntero (Left 5)


limpiar :: String -> String -> String
limpiar a b = filter (not.stringContainsChar a) b 

stringContainsChar:: String -> Char -> Bool
stringContainsChar s c = foldr ((||).(\y -> y == c)) False s


difPromedio :: [Float] -> [Float]
difPromedio l = map (\y -> y - myAvg(l)) l

myAvg:: [Float] -> Float
myAvg l = mySum l / (myLen l)::Float

mySum:: Num a => [a] -> a
mySum l = foldr (+) 0 l

myLen:: Num b => [a] -> b
myLen l = foldr (\y -> (+) 1) 0 l


todosIguales :: [Int] -> Bool
todosIguales [] = True
todosIguales l = foldr ((&&).(\y -> y == (l !! 0))) True l


data AB a = Nil | Bin (AB a) a (AB a)

vacioAB :: AB a -> Bool
vacioAB Nil = True
vacioAB _ = False

negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin l a r) = (Bin (negacionAB l) (not a) (negacionAB r))

productoAB :: AB Int -> Int
productoAB Nil = 1
productoAB (Bin l a r) = (productoAB l) * a * (productoAB r)




main = do
    hSetBuffering stdin LineBuffering
    putStrLn "Please enter your name: "
    name <- getLine
    putStrLn ("Hello, " ++ name ++ ", how are you?")














































