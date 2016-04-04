module Investments.Calculator.Update (Action(..), update) where

import Effects exposing (Effects)
import Investments.Calculator.Model exposing (Model, recalculateYears)


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
      ( recalculateYears { model | principal = value }, Effects.none )

    SetStartingMonthlyContribution value ->
      ( recalculateYears { model | startingMontlyContribution = value }, Effects.none )

    SetAnnualInvestmentIncrease value ->
      ( recalculateYears { model | annualInvestmentIncrease = value / 100 }, Effects.none )

    SetAnnualRateOfReturn value ->
      ( recalculateYears { model | annualRateOfReturn = value / 100 }, Effects.none )

    SetYears value ->
      ( recalculateYears { model | years = value }, Effects.none )
