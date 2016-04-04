module Investments.YearlyCalculation.View (view) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Numeral
import Investments.Calculator.Model exposing (..)


view : Model -> Html
view model =
  section
    []
    [ chart
    , resultsTable model.calculations
    ]


chart : Html
chart =
  div [ id "chart2" ] [ svg [] [] ]


resultsTable : List YearlyCalculation -> Html
resultsTable calculations =
  table
    []
    [ thead
        []
        [ tr
            []
            [ th [] [ text "#" ]
            , th [] [ text "Year" ]
            , th [] [ text "Base investment" ]
            , th [] [ text "Annual contribution" ]
            , th [] [ text "Interest" ]
            , th [] [ text "Total" ]
            ]
        ]
    , tbody
        []
        (List.map renderYearlyCalculation calculations)
    ]


renderYearlyCalculation : YearlyCalculation -> Html
renderYearlyCalculation yearlyCalculation =
  tr
    []
    [ td [ class "number" ] [ text (yearlyCalculation.yearOffset |> toString) ]
    , td [ class "number" ] [ text (yearlyCalculation.actualYear |> toString) ]
    , td [ class "number" ] [ text <| renderMoney yearlyCalculation.baseInvestment ]
    , td [ class "number" ] [ text <| renderMoney yearlyCalculation.annualContribution ]
    , td [ class "number" ] [ text <| renderMoney yearlyCalculation.interest ]
    , td [ class "number" ] [ text <| renderMoney yearlyCalculation.total ]
    ]


renderMoney : Float -> String
renderMoney money =
  Numeral.format "$0,0.00" money
