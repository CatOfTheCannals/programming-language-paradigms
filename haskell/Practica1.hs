module Main
    where

import System.IO
import Data.Maybe
import Data.Either

max2:: (Float, Float) -> Float
max2 (x, y) 
    | x >= y = x
    | otherwise = y

subtract2:: Num a => a -> a -> a
subtract2 = flip (-)

curry2:: ((a, b) -> c) -> (a -> b -> c)
curry2 f x y = f (x, y)

uncurry2:: (a -> b -> c) -> ((a, b) -> c)
uncurry2 f (x, y) = f x y 


-- ej 4
isInt:: (Floating a, RealFrac a) => a -> Bool
isInt x = x == (fromInteger (round x))

norm2:: Floating a => a -> a -> a
norm2 a b = sqrt (a^2 + b^2)

mapThreeTup:: (a -> b) -> (a, a, a) -> (b, b, b)
mapThreeTup f (x, y, z) = (f x, f y, f z)

pitagoricas:: [(Integer, Integer, Integer)]
pitagoricas = [(round a, round b, round $ norm2 a b) | a <- [1..], b <- [1..a], isInt $ norm2 a b]


-- ej 5

listContainsDivisor:: Int -> [Int] -> Bool
listContainsDivisor x l = foldr ((||) . ((==) 0) . (mod x)) False l

nPrimos:: Int -> [Int]
nPrimos 1 = [2]
nPrimos n = nextPrime : primesSoFar
    where primesSoFar = nPrimos (n - 1)
          nextPrime = head [a | a <- [(head primesSoFar + 1)..], not $ listContainsDivisor a primesSoFar]


-- ej 7

listasQueSuman :: Int -> [[Int]]
listasQueSuman 0 = [[]]
listasQueSuman n = [(n - i) : l | i <- [0..n - 1], l <- (listasQueSuman i)]


-- ej 8

type DivideConquer a b = (a -> Bool) -- determina si es o no el caso trivial
                        -> (a -> b) -- resuelve el caso trivial
                        -> (a -> [a]) -- parte el problema en sub-problemas
                        -> ([b] -> b) -- combina resultados
                        -> a -- estructura de entrada
                        -> b -- resultado
-- a
dc :: DivideConquer a b
dc trivial solve split combine x = if trivial x then solve x else combine $ map dcp $ split x
    where dcp = dc trivial solve split combine

-- b

mergeSort :: Ord a => [a] -> [a]
mergeSort l = dc trivial solve split combine l
    where trivial a = length a < 2
          solve = id
          split l = pairToList $ splitAt (((length l) + 1) `div` 2) l  
          combine [[], l2] = l2
          combine [l1, []] = l1
          combine [(x1 : xs1), (x2 : xs2)] = if x1 < x2 
            then x1 : (combine [xs1, x2 : xs2])
            else x2 : (combine [x1 : xs1, xs2])

pairToList :: (a, a) -> [a]
pairToList (x,y) = [x,y]

-- c

dcMap :: (a -> b) -> [a] -> [b]
dcMap f l = dc trivial solve split combine l
    where trivial x = length x < 2
          solve [] = []
          solve [e] = [f e]
          split l = pairToList $ splitAt (((length l) + 1) `div` 2) l  
          combine [l1, l2] = l1 ++ l2

dcFilter :: (a -> Bool) -> [a] -> [a]
dcFilter f l = dc trivial solve split combine l
    where trivial x = length x < 2
          solve [] = []
          solve [e] = if f e then [e] else []
          split l = pairToList $ splitAt (((length l) + 1) `div` 2) l  
          combine [l1, l2] = l1 ++ l2


-- ej 10

-- i

foldImpSum :: (Foldable t, Num a) => t a -> a
foldImpSum l = foldr (+) 0 l

foldImpElem :: (Foldable t, Eq a) => a -> t a -> Bool
foldImpElem e l = foldr ((||) . ((==) e)) False l

foldImpPP :: [a] -> [a] -> [a]
foldImpPP l1 l2 = foldr (:) l2 l1

foldImpFilter :: (a -> Bool) -> [a] -> [a]
foldImpFilter f l = foldr ((++).(\x -> if f x then [x] else [])) [] l

foldImpMap :: (a -> b) -> [a] -> [b]
foldImpMap f l = foldr ((:) . f) [] l


-- ii

mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f l = foldr1 (\x y -> if f x y then x else y) l


-- iii

sumasParciales :: Num a => [a] -> [a]
sumasParciales [] = []
sumasParciales l = reverse $ foldl (\y x -> x + (nonStrictHead y) : y) [] l
    where nonStrictHead l = if null l then 0 else head l

-- iv

sumAlt :: [Int] -> Int
sumAlt l = snd $ foldl sumOrSubtract (True, 0) l
    where sumOrSubtract (sumVal, accum) x = if sumVal then (False, accum + x) else (True, accum - x)

-- v

sumAltInv :: [Int] -> Int
sumAltInv l = snd $ foldr sumOrSubtract (True, 0) l
    where sumOrSubtract x (sumVal, accum) = if sumVal then (False, accum + x) else (True, accum - x)

-- vi

permutaciones :: [a] -> [[a]]
permutaciones [] = [[]]
permutaciones [a] = [[a]]
permutaciones [a, b] = [[a, b], [b, a]]
permutaciones (x : xs) = _permutaciones [] x xs

_permutaciones :: [a] -> a -> [a] -> [[a]] 
_permutaciones l1 x [] = permutacionesEmpezandoCon x l1
_permutaciones l1 x (x2 : xs2) = _permutaciones (x : l1) x2 xs2 ++ permutacionesEmpezandoCon x (l1 ++ (x2 : xs2))

permutacionesEmpezandoCon :: a -> [a] -> [[a]]
permutacionesEmpezandoCon x l = map ((:) x) $ permutaciones l


-- 11

-- i

partes :: [a] -> [[a]]
partes l = _partes (length l) l

_partes :: Int -> [a] -> [[a]]
_partes 0 l = [[]]
_partes k l = _partes (k - 1) l ++ (kSizeGroups k l)

kSizeGroups :: Int -> [a] -> [[a]]
kSizeGroups 0 _ = [[]]
kSizeGroups _ [] = [[]]
kSizeGroups k (x : xs) = groupsWithoutFirstElem k (x : xs) ++ (map ((:) x) $ kSizeGroups (k - 1) xs)

groupsWithoutFirstElem :: Int -> [a] -> [[a]]
groupsWithoutFirstElem k (x : xs) = if length xs < k then [] else kSizeGroups k xs 

-- ii

prefijos :: [a] -> [[a]]
prefijos l = [take i l | i <- [0.. length l]]

-- iii

sublistas :: [a] -> [[a]]
sublistas l = [take (end - start) $ drop start l | start <- [0.. length l - 1], end <- [start + 1 .. length l]]


-- ej 12

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x:xs) = f x xs (recr f z xs)

-- a

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna e l = recr (f e) [] l
    where f e x xs z = if e == x then xs else x : z

-- c

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado e l = recr (f e) [] l
    where f e x xs z = if e < x then e : (x : xs) else if null z then [x, e] else x : z


-- ej 13

-- ej 14

-- i

mapPares :: (a -> b -> c) -> [(a,b)] -> [c]
mapPares f l = map (uncurry f) l

-- ii

zip2 :: [a] -> [b] -> [(a, b)]
zip2 [] _ = []
zip2 _ [] = []
zip2 (x1 : xs1) (x2 : xs2) = (x1, x2) : (zip2 xs1 xs2)

-- iii

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f l1 l2 = mapPares f $ zip2 l1 l2


-- ej 16

generate :: ([a] -> Bool) -> ([a] -> a) -> [a]
generate stop next = generateFrom stop next []

generateFrom :: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
generateFrom stop next xs | stop xs = init xs
                          | otherwise = generateFrom stop next (xs ++ [next xs])

-- i

generateBase :: ([a] -> Bool) -> a -> (a -> a) -> [a]
generateBase stop base next = generateFrom stop (next . last) [base]

-- ii

factoriales :: Int -> [Int]
factoriales n = generate stop next
    where stop xs = (length xs) > n
          next [] = 1
          next xs = (length xs) * (last xs)


-- iii

iterateN :: Int -> (a -> a) -> a -> [a]
iterateN n f x = generateBase stop x next
    where 
        stop xs = (length xs) > n
        next = f

-- iv

-- generateFrom2 :: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
-- generateFrom2 stop next xs = takeWhile (not stop) iterate (next) xs 


-- ej 17

foldNat :: (a -> a) -> (a -> a) -> Integer -> a -> a
foldNat baseCaseOp recCaseOp 0 b = baseCaseOp b
foldNat baseCaseOp recCaseOp n b = foldNat baseCaseOp recCaseOp (n - 1) (recCaseOp b)

potencia :: Num a => a -> Integer -> a
potencia base exponent = foldNat id ((*) base) exponent 1 


-- ej 18

data Polinomio a = X
                | Cte a
                | Suma (Polinomio a) (Polinomio a)
                | Prod (Polinomio a) (Polinomio a)


recrPolinomio :: Num a => (Polinomio a -> a) -> Polinomio a -> a
recrPolinomio f X = f X
recrPolinomio f (Cte a) = a
recrPolinomio f (Suma p q) = (recrPolinomio f p) + (recrPolinomio f q)
recrPolinomio f (Prod p q )= (recrPolinomio f p) * (recrPolinomio f q)


eval :: Num a => a -> Polinomio a -> a
eval val p = recrPolinomio replace p
    where replace X = val 


{-

-- ej 19

type Conj a = (a->Bool)

-}

main = do
    putStrLn ("Holis")
















    















    















