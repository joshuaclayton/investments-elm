module Investments.Calculator.Model (..) where


type alias Model =
  { principal : Float
  , startingMontlyContribution : Float
  , annualRateOfReturn : Float
  , annualInvestmentIncrease : Float
  , years : Int
  }


initialModel : Model
initialModel =
  { principal = 0
  , startingMontlyContribution = 100
  , annualRateOfReturn = 7.5e-2
  , annualInvestmentIncrease = 0.0
  , years = 30
  }
