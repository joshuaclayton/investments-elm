module Investments.App.Model (Model, initialModel) where

import Investments.Calculator.Model exposing (..)


type alias Model =
  { calculator : Investments.Calculator.Model.Model
  , currentYear : Int
  }


initialModel : Model
initialModel =
  { calculator = Investments.Calculator.Model.initialModel
  , currentYear = 0
  }
