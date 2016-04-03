module Main (..) where

import StartApp
import Investments.App.Update exposing (..)
import Investments.App.View exposing (..)
import Investments.YearlyCalculation.Signal


app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = [ swapSignal, setCurrentYearSignal ]
    }


main =
  app.html


setCurrentYearSignal : Signal Action
setCurrentYearSignal =
  Signal.map SetCurrentYear setCurrentYear


swapSignal : Signal Action
swapSignal =
  Signal.map (always NoOp) swap


port yearlyContributionsSignal : Signal String
port yearlyContributionsSignal =
  Investments.YearlyCalculation.Signal.signal app.model


port swap : Signal.Signal Bool
port setCurrentYear : Signal Int
