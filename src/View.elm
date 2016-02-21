module View (..) where

import Html exposing (div)
import Html.Attributes exposing (class)
import Html.Events
import Actions exposing (Action)
import Maths exposing (Digit(..))
import Models

view : Signal.Address Action -> Models.AppModel -> Html.Html
view address model =
  div
    [ class "calc"]
    [ calcDisplay model
    , calcButtonRow address
        ("AC", Actions.AllClear, [class "calc-button-clear"])
        ("CE", Actions.ClearEntry, [class "calc-button-clear"])
        ("%", Actions.Percent, [])
        ("/", Actions.BinOpEntry Maths.Divide, [])
    , calcButtonRow address
        ("7", Actions.DigitEntry Seven, [])
        ("8", Actions.DigitEntry Eight, [])
        ("9", Actions.DigitEntry Nine, [])
        ("*", Actions.BinOpEntry Maths.Multiply, [])
    , calcButtonRow address
        ("4", Actions.DigitEntry Four, [])
        ("5", Actions.DigitEntry Five, [])
        ("6", Actions.DigitEntry Six, [])
        ("-", Actions.BinOpEntry Maths.Subtract, [])
    , calcButtonRow address
        ("1", Actions.DigitEntry One, [])
        ("2", Actions.DigitEntry Two, [])
        ("3", Actions.DigitEntry Three, [])
        ("+", Actions.BinOpEntry Maths.Add, [])
    , calcButtonRow address
        ("0", Actions.DigitEntry Zero, [])
        (".", Actions.Point, [])
        ("=", Actions.Equals, [])
        ("PM", Actions.PlusMinus , [])
    , debugBox model
    ]


debugBox : Models.AppModel -> Html.Html
debugBox model =
  div
    [class "calc-debug-box"]
    [Html.text (toString model)]

calcDisplay : Models.AppModel -> Html.Html
calcDisplay model =
  let
    displayText =
      case model.entry of
        Models.Empty ->
          Html.text (toString model.value)

        entry ->
          Html.text (toString (Models.evalEntry entry))
  in
    div
      [ class "calc-display" ]
      [ div
        [ class "calc-display-text" ]
        [ displayText ]
      ]

calcButtonRow :
    Signal.Address Action ->
    (String, Action, List Html.Attribute) ->
    (String, Action, List Html.Attribute) ->
    (String, Action, List Html.Attribute) ->
    (String, Action, List Html.Attribute) ->
    Html.Html
calcButtonRow address (s1, a1, x1) (s2, a2, x2) (s3, a3, x3) (s4, a4, x4) =
  div
    [ class "calc-button-row" ]
    [ calcButton address a1 s1 x1
    , calcButton address a2 s2 x2
    , calcButton address a3 s3 x3
    , calcButton address a4 s4 x4
    ]

--
-- calcButtonTopRow : Signal.Address Action -> String -> String -> String -> String -> Html.Html
-- calcButtonTopRow s1 s2 s3 s4 =
--   div
--     [ class "calc-button-row" ]
--     [ calcButton [ class "calc-button-clear" ] s1
--     , calcButton [ class "calc-button-clear" ] s2
--     , calcButton [] s3
--     , calcButton [] s4
--     ]

calcButton : Signal.Address Action -> Action -> String -> List Html.Attribute -> Html.Html
calcButton address action label extraAttributes =
  div
    (class "calc-button" ::  Html.Events.onClick address action :: extraAttributes)
    [ div [ class "calc-button-label"] [Html.text label] ]
