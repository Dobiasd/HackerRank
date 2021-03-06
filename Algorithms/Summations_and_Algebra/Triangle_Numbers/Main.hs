import Data.List
import Data.Maybe
import Control.Arrow

(|>) :: a -> (a -> b) -> b
(|>) x y = y x
infixl 0 |>

main :: IO ()
main = do
    _ <- getLine
    interact $ lines >>>
               filter (not . null) >>>
               map (read >>> posOfFirstEvenNumInTriangleRowNFast >>> show ) >>>
               unlines

posOfFirstEvenNumInTriangleRowNFast :: Int -> Int
posOfFirstEvenNumInTriangleRowNFast n
    | n < 3 = -1
    | otherwise = [2, 3, 2, 4] !! ((n -3) `mod` 4)


-- The 'real' solution begins here. But it is not needed.


posOfFirstEvenNumInTriangleRowN :: Int -> Int
posOfFirstEvenNumInTriangleRowN n =
    triangle !! max 0 (n - 1) |> findIndex even |> fmap (+1) |> fromMaybe (-1)


triangle :: [[Int]]
triangle = iterate nextRow [1]

nextRow :: [Int] -> [Int]
nextRow row = zipWith3 (\ a b c -> a+b+c)
                       (0 : init padded) padded (tail padded ++ [0])
    where padded = 0 : row ++ [0]