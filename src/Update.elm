module Update where

import Models exposing (AppModel, Entry(..))
import Maths exposing (Digit, BinOp(..))
import Actions exposing (..)

{-
Example: 22*3+4=

Start:    entry=Empty, value=0, op=Nothing             Displays 0 (value)
2:        entry=Integer [2], value=0, op=Nothing       Displays 2 (entry)
2:        entry=Integer [2, 2], value=0, op=Nothing    Displays 22 (entry)
*:        entry=Empty, value=22, op=Times              Displays 22 (value)
3:        entry=Integer [3], value=22, op=Times        Displays 3 (entry)
+:        entry=Empty, value=22*3=66, op=Plus          Displays 66 (value)
4:        entry=Integer [4], value=66, op=Plus         Displays 4 (value)
=:        entry=Empty, value=66+4=70, op=Nothing       Displays 70 (value)

-}


update : Action -> AppModel -> AppModel
update action model =
  case action of
    NoOp -> -- Do nothing
      model

    DigitEntry d ->
      case model.entry of
        Empty -> -- Start a new entry
          { model
            | entry = Integer (Maths.evalDigit d)
          }

        Integer i -> -- Add to an existing integer entry
          { model
            | entry = Integer (i * 10 + Maths.evalDigit d)
          }

        Decimal (before, after) -> -- Add to an existing decimal entry
          { model
              | entry = Decimal (before, after * 10 + Maths.evalDigit d)
          }

        Result _ -> -- Overwrite a result
          { model
            | entry = Integer (Maths.evalDigit d)
          }

    Point ->
      case model.entry of
        Empty -> -- Convert empty entry to a decimal
          { model
            | entry = Decimal (0, 0)
          }

        Integer i -> -- Convert integer entry to a decimal
          { model
            | entry = Decimal (i, 0)
          }

        Decimal _ -> -- Do nothing if point pressed while already in a decimal
          model

        Result _ -> -- Overwrite a result
          { model
            | entry = Decimal (0, 0)
          }

    BinOpEntry o ->
      { model
        | entry = Empty
        , value = Models.evalEntry model.entry
        , op = Just o
      }

    Equals ->
      case model.op of
        Nothing ->
          model

        Just op ->
          let
            answer = Maths.applyOp op model.value (Models.evalEntry model.entry)
          in
            { model
              | entry = Result answer
              , value = answer
              , op = Nothing
            }

    Percent ->
      case model.op of
        Nothing -> -- Naked % we just hold a result for the number / 100
          { model
            | entry = Result ((Models.evalEntry model.entry) / 100)
          }

        Just op ->
          { model
            | entry = Result ((Maths.applyOp Multiply model.value (Models.evalEntry model.entry)) / 100)
          }

    AllClear ->
      { model
        | entry = Empty
        , value = 0
        , op = Nothing
      }

    ClearEntry ->
      { model
        | entry = Empty
      }

    PlusMinus ->
      { model
        | entry = Models.negate model.entry
      }

    ToggleDebug ->
      { model
        | debugMode = not model.debugMode
      }
