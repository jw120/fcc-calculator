module Main (main) where

import Effects
import Html
import Keyboard
import StartApp
import Task

-- import Actions
import Models
import Presses
import Update
import View


app : StartApp.App Models.AppModel
app =
  StartApp.start
    { init = ( Models.initialModel, Effects.none )
    , inputs = [ Signal.map Presses.handler Keyboard.presses ]
    , update = (\a m -> (Update.update a m, Effects.none))
    , view = View.view
    }


main : Signal.Signal Html.Html
main =
  app.html


port runner : Signal (Task.Task Effects.Never ())
port runner =
  app.tasks
