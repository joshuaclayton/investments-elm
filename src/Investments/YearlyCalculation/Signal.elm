module Investments.YearlyCalculation.Signal (signal) where

import Json.Encode as Json exposing (encode, object, string, float, list)
import Investments.App.Model
import Investments.YearlyCalculation.Model exposing (calculateYears)


signal : Signal Investments.App.Model.Model -> Signal String
signal model =
  Signal.map (\model' -> encode 0 (modelToJsonPayload model')) model


modelToJsonPayload : Investments.App.Model.Model -> Json.Value
modelToJsonPayload model =
  let
    groupingList =
      list
        [ string "Grouping"
        , string "Base value"
        , string "Contributions"
        , string "Interest"
        , object [ ( "role", string "annotation" ) ]
        ]

    values =
      let
        process calculation =
          list
            [ string <| toString calculation.actualYear
            , float calculation.baseInvestment
            , float calculation.annualContribution
            , float calculation.interest
            , string ""
            ]
      in
        List.map process <| calculateYears model.calculator
  in
    list
      ([ groupingList ] ++ values)
