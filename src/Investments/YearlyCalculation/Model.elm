module Investments.YearlyCalculation.Model (Model, calculateYears) where

import Investments.Calculator.Model


type alias Model =
  { yearOffset : Int
  , actualYear : Int
  , baseInvestment : Float
  , annualContribution : Float
  , interest : Float
  , total : Float
  , settings : Investments.Calculator.Model.Model
  }


initialModel : Investments.Calculator.Model.Model -> Model
initialModel calculator =
  { yearOffset = 0
  , actualYear = 2015
  , baseInvestment = 0
  , annualContribution = 0
  , interest = 0
  , total = calculator.principal
  , settings = calculator
  }


calculateYears : Investments.Calculator.Model.Model -> List Model
calculateYears calculator =
  let
    yearRange =
      [1..calculator.years - 1]

    startingPoint =
      calculateYear 0 <| initialModel calculator
  in
    List.scanl calculateYear startingPoint yearRange


calculateYear : Int -> Model -> Model
calculateYear year calc =
  let
    base =
      calc.total

    model =
      calc.settings

    annualMultiplier =
      (1 + model.annualInvestmentIncrease) ^ (toFloat <| year)

    baseAnnualContribution =
      model.startingMontlyContribution * 12

    annualContribution =
      baseAnnualContribution * annualMultiplier

    interest =
      (base + annualContribution) * model.annualRateOfReturn

    total =
      base + annualContribution + interest
  in
    { calc
      | yearOffset = year + 1
      , actualYear = calc.actualYear + 1
      , baseInvestment = base
      , annualContribution = annualContribution
      , interest = interest
      , total = total
    }
