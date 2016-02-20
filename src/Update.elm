module Update where

import Models exposing (AppModel, Entry(..))
import Maths exposing (Digit, BinOp)
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
  case (action, model.entry) of
    (NoOp, _) -> -- Do nothing
      model

    (DigitEntry d, Empty) -> -- Start a new entry
      { model | entry = Integer (Maths.evalDigit d) }

    (DigitEntry d, Integer i) -> -- Add to an existing integer entry
      { model | entry = Integer (i * 10 + Maths.evalDigit d)  }

    (DigitEntry d, Decimal (before, after)) -> -- Add to an existing decimal entry
      { model | entry = Decimal (before, after * 10 + Maths.evalDigit d)}

    (Point, Empty) -> -- Convert empty entry to a decimal
      { model | entry = Decimal (0, 0) }

    (Point, Integer i) -> -- Convery integer entry to a decimal
      { model | entry = Decimal (i, 0) }

    (Point, Decimal _) -> -- Do nothing if point pressed while already in a decimal
      model

    (BinOpEntry o, _) ->
      { model | value = Models.evalEntry model.entry, op = Just o}

    (Equals, e) ->
      { model | value = Maths.applyOp model.op model.value (Models.evalEntry model.entry) }

    (_, _) ->
      model
