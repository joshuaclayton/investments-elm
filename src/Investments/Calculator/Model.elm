module Investments.Calculator.Model (Model, YearlyCalculation, initialModel, recalculateYears) where


type alias Model =
  { principal : Float
  , startingMontlyContribution : Float
  , annualRateOfReturn : Float
  , annualInvestmentIncrease : Float
  , years : Int
  , calculations : List YearlyCalculation
  }


initialModel : Model
initialModel =
  let
    baseModel =
      { principal = 0
      , startingMontlyContribution = 100
      , annualRateOfReturn = 7.5e-2
      , annualInvestmentIncrease = 0.0
      , years = 30
      , calculations = []
      }
  in
    recalculateYears baseModel


recalculateYears : Model -> Model
recalculateYears model =
  { model | calculations = calculateYears model }


type alias YearlyCalculation =
  { yearOffset : Int
  , actualYear : Int
  , baseInvestment : Float
  , annualContribution : Float
  , interest : Float
  , total : Float
  }


initialYearlyCalculation : Model -> YearlyCalculation
initialYearlyCalculation model =
  { yearOffset = 0
  , actualYear = 2015
  , baseInvestment = 0
  , annualContribution = 0
  , interest = 0
  , total = model.principal
  }


calculateYears : Model -> List YearlyCalculation
calculateYears model =
  let
    yearRange =
      [1..model.years - 1]

    startingPoint =
      calculateYear model 0 <| initialYearlyCalculation model
  in
    List.scanl (calculateYear model) startingPoint yearRange


calculateYear : Model -> Int -> YearlyCalculation -> YearlyCalculation
calculateYear model year calc =
  let
    base =
      calc.total

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
