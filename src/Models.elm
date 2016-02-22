module Models (..) where

import Maths exposing (BinOp)

type alias AppModel =
  { entry : Entry
  , op : Maybe BinOp
  , value : Float
  , debugMode : Bool
  }

initialModel : AppModel
initialModel =
  { entry = Empty
  , op = Nothing
  , value = 0
  , debugMode = False
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


negate : Entry -> Entry
negate entry =
  case entry of
    Empty ->
      Empty

    Integer i ->
      Integer (-i)

    Decimal (a, b) ->
      Decimal (-a, b)

    Result f ->
      Result (-f)
