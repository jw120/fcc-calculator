module Actions (..) where

import Maths exposing (BinOp, Digit)

type Action
  = NoOp
  | DigitEntry Digit
  | BinOpEntry BinOp
  | Point
  | Equals
  | Percent
  | AllClear
  | ClearEntry
