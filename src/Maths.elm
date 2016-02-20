module Maths (..) where

type BinOp
  = Add
  | Subtract
  | Multiply
  | Divide


type Digit
  = One
  | Two
  | Three
  | Four
  | Five
  | Six
  | Seven
  | Eight
  | Nine
  | Zero


evalDigit : Digit -> Int
evalDigit d =
  case d of
    One -> 1
    Two -> 2
    Three -> 3
    Four -> 4
    Five -> 5
    Six -> 6
    Seven -> 7
    Eight -> 8
    Nine -> 9
    Zero -> 0


{- Convert an integer to a 0<x<1 float, e.g., 12 -> 0.12 -}
toFractional : Int -> Float
toFractional x =
  let
    go : Float -> Float
    go x =
      if abs x > 1 then
        go (x / 10)
      else
        x
  in
    go (toFloat x)


applyOp: Maybe BinOp -> Float -> Float -> Float
applyOp op x y =
  case op of
    Just Add ->
      x + y

    Just Subtract ->
      x - y

    Just Multiply ->
      x * y

    Just Divide ->
      x / y

    Nothing ->
      y
