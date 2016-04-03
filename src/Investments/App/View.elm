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
    , pageFooter
    ]


pageHeader : Html
pageHeader =
  h1 [] [ text "Investments" ]


pageFooter : Html
pageFooter =
  footer
    []
    [ p
        []
        [ text "Created by "
        , a [ href "http://joshuaclayton.me" ] [ text "Josh Clayton" ]
        , text ". "
        , text "View the source on "
        , a [ href "https://github.com/joshuaclayton/investments-elm" ] [ text "GitHub" ]
        , text "."
        ]
    ]
