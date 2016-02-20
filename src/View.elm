module View (..) where

import Html exposing (..)
import Html.Attributes exposing (class)
import Actions exposing (..)
import Models exposing (AppModel, Entry(..))

view : Signal.Address Action -> AppModel -> Html.Html
view address model =
  div
    [ class "calc"]
    [ calcDisplay model
    , calcButtonTopRow "AC" "CE" "%" "/"
    , calcButtonRow "7" "8" "9" "*"
    , calcButtonRow "4" "5" "6" "-"
    , calcButtonRow "1" "2" "3" "+"
    , calcButtonRow "0" "." "=" "PM"
    ]


calcDisplay : AppModel -> Html.Html
calcDisplay model =
  let
    displayText =
      case model.entry of
        Empty ->
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


calcButtonRow : String -> String -> String -> String -> Html.Html
calcButtonRow s1 s2 s3 s4 =
  div
    [ class "calc-button-row" ]
    [ calcButton [] s1
    , calcButton [] s2
    , calcButton [] s3
    , calcButton [] s4
    ]


calcButtonTopRow : String -> String -> String -> String -> Html.Html
calcButtonTopRow s1 s2 s3 s4 =
  div
    [ class "calc-button-row" ]
    [ calcButton [ class "calc-button-clear" ] s1
    , calcButton [ class "calc-button-clear" ] s2
    , calcButton [] s3
    , calcButton [] s4
    ]


calcButton : List Html.Attribute -> String -> Html.Html
calcButton attrs s =
  div
    (class "calc-button" ::  attrs)
    [ div [ class "calc-button-label"] [Html.text s] ]
