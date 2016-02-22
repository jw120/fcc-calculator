module Presses (..) where

import Char

import Actions
import Maths exposing (Digit(..))

handler : Int -> Actions.Action
handler key =
  case Char.fromCode key of
    '1' -> Actions.DigitEntry One
    '2' -> Actions.DigitEntry Two
    '3' -> Actions.DigitEntry Three
    '4' -> Actions.DigitEntry Four
    '5' -> Actions.DigitEntry Five
    '6' -> Actions.DigitEntry Six
    '7' -> Actions.DigitEntry Seven
    '8' -> Actions.DigitEntry Eight
    '9' -> Actions.DigitEntry Nine
    '0' -> Actions.DigitEntry Zero
    '+' -> Actions.BinOpEntry Maths.Add
    '-' -> Actions.BinOpEntry Maths.Subtract
    '*' -> Actions.BinOpEntry Maths.Multiply
    '/' -> Actions.BinOpEntry Maths.Divide
    '%' -> Actions.Percent
    '.' -> Actions.Point
    '=' -> Actions.Equals
    'd' -> Actions.ToggleDebug
    'D' -> Actions.ToggleDebug
    _ -> Actions.NoOp
