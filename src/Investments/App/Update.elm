module Investments.App.Update (Action(..), init, update) where

import Effects exposing (Effects)
import Investments.App.Model exposing (..)
import Investments.Calculator.Update


type Action
  = NoOp
  | UpdateCalculator Investments.Calculator.Update.Action
  | SetCurrentYear Int


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

    UpdateCalculator action' ->
      let
        ( model', effects ) =
          Investments.Calculator.Update.update action' model.calculator
      in
        ( { model | calculator = model' }
        , Effects.map UpdateCalculator effects
        )

    SetCurrentYear year ->
      ( { model | currentYear = year }
      , Effects.none
      )


init : ( Model, Effects Action )
init =
  ( initialModel, Effects.none )
