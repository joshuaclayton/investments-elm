module Investments.Calculator.View (view) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue)
import WebBindings exposing (toFixed)
import String
import Investments.Calculator.Model exposing (..)
import Investments.Calculator.Update exposing (..)
import Investments.YearlyCalculation.View


view : Signal.Address Action -> Model -> Html
view address model =
  section
    []
    [ aside
        [ class "settings" ]
        [ calculatorForm address model ]
    , div
        [ class "results" ]
        [ Investments.YearlyCalculation.View.view model ]
    ]


formatFieldForValue : Float -> String
formatFieldForValue value =
  case toFixed 2 value of
    Ok val ->
      val

    Err _ ->
      "0.00"


calculatorForm : Signal.Address Action -> Model -> Html
calculatorForm address model =
  Html.form
    []
    [ ul
        []
        [ li
            []
            [ label [ for "principal" ] [ text "Principal" ]
            , text "$"
            , input [ on "input" targetValue (Signal.message address << (parseFloat SetPrincipal)), value (formatFieldForValue model.principal), id "principal", type' "number", Html.Attributes.min "0", step "500" ] []
            ]
        , li
            []
            [ label [ for "starting-monthly-contribution" ] [ text "Starting Monthly Contribution" ]
            , text "$"
            , input [ on "input" targetValue (Signal.message address << (parseFloat SetStartingMonthlyContribution)), value (formatFieldForValue model.startingMontlyContribution), id "starting-monthly-contribution", type' "number", Html.Attributes.min "0", Html.Attributes.max "5000", step "50" ] []
            ]
        , li
            []
            [ label [ for "investment-increase" ] [ text "Annual Investment Increase" ]
            , input [ on "input" targetValue (Signal.message address << (parseFloat SetAnnualInvestmentIncrease)), value (formatFieldForValue <| model.annualInvestmentIncrease * 100), id "investment-increase", type' "number", Html.Attributes.min "0", Html.Attributes.max "20", step "0.25" ] []
            , text "%"
            ]
        , li
            []
            [ label [ for "annual-rate-of-return" ] [ text "Annual Rate of Return" ]
            , input [ on "input" targetValue (Signal.message address << (parseFloat SetAnnualRateOfReturn)), value (formatFieldForValue <| model.annualRateOfReturn * 100), id "annual-rate-of-return", type' "number", Html.Attributes.min "0", Html.Attributes.max "20", step "0.25" ] []
            , text "%"
            ]
        , li
            []
            [ label [ for "years" ] [ text "Years" ]
            , input [ on "input" targetValue (Signal.message address << (parseInt SetYears)), value (toString model.years), id "years", type' "number", Html.Attributes.min "0", Html.Attributes.max "50", step "1" ] []
            ]
        ]
    ]


parseFloat : (Float -> Action) -> String -> Action
parseFloat action value =
  action <| Result.withDefault 0 <| String.toFloat value


parseInt : (Int -> Action) -> String -> Action
parseInt action value =
  action <| Result.withDefault 0 <| String.toInt value
