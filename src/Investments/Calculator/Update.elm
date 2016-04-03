module Investments.Calculator.Update (Action(..), update) where

import Effects exposing (Effects)
import Investments.Calculator.Model exposing (Model)


type Action
  = NoOp
  | SetPrincipal Float
  | SetStartingMonthlyContribution Float
  | SetAnnualInvestmentIncrease Float
  | SetAnnualRateOfReturn Float
  | SetYears Int


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

    SetPrincipal value ->
      ( { model | principal = value }, Effects.none )

    SetStartingMonthlyContribution value ->
      ( { model | startingMontlyContribution = value }, Effects.none )

    SetAnnualInvestmentIncrease value ->
      ( { model | annualInvestmentIncrease = value / 100 }, Effects.none )

    SetAnnualRateOfReturn value ->
      ( { model | annualRateOfReturn = value / 100 }, Effects.none )

    SetYears value ->
      ( { model | years = value }, Effects.none )
