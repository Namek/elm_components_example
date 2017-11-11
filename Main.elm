module Main exposing (main)

import Component1
import Component2
import Html exposing (Html, div, text)
import Material
import Misc exposing (makeLifter)


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }


type alias Model =
    { mdl : Material.Model
    , component1 : Component1.Model
    , component2 : Component2.Model
    }


model : Model
model =
    { mdl = Material.model
    , component1 = Component1.model
    , component2 = Component2.model
    }


type Msg
    = MsgMaterial (Material.Msg Msg)
    | MsgComponent1 Component1.Msg
    | MsgComponent2 Component2.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        lift =
            makeLifter model MsgMaterial
    in
    case msg of
        MsgMaterial subMsg ->
            Material.update MsgMaterial subMsg model

        MsgComponent1 subMsg ->
            lift Component1.update (\m x -> { m | component1 = x }) subMsg MsgComponent1 .component1

        MsgComponent2 subMsg ->
            lift Component2.update (\m x -> { m | component2 = x }) subMsg MsgComponent2 .component2


view : Model -> Html Msg
view model =
    div []
        [ text "main"
        , Component1.view MsgComponent1 MsgMaterial model.mdl model.component1
        , Component2.view MsgComponent2 MsgMaterial model.mdl model.component2
        ]
