module Models (..) where

import Maths exposing (BinOp)

type alias AppModel =
  { entry : Entry
  , op : Maybe BinOp
  , value : Float
  }

initialModel : AppModel
initialModel =
  { entry = Empty
  , op = Nothing
  , value = 0
  }

type Entry
  = Empty
  | Integer Int
  | Decimal (Int, Int)
  | Result Float


evalEntry : Entry -> Float
evalEntry entry =
  case entry of
    Empty ->
      0

    Integer i ->
      toFloat i

    Decimal (a, b) ->
      toFloat a + Maths.toFractional b

    Result f ->
      f
