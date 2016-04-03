module Investments.App.View (view) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Investments.App.Update exposing (Action(..))
import Investments.App.Model exposing (Model)
import Investments.Calculator.View


view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "container" ]
    [ pageHeader
    , Investments.Calculator.View.view (Signal.forwardTo address UpdateCalculator) model.calculator
    ]


pageHeader : Html
pageHeader =
  h1 [] [ text "Investments" ]
