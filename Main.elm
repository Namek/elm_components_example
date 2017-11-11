module Main exposing (main)

import Component1
import Component2
import Html exposing (Html, div, text)
import Material


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
    case msg of
        MsgMaterial subMsg ->
            Material.update MsgMaterial subMsg model

        MsgComponent1 subMsg ->
            case Component1.update subMsg MsgComponent1 MsgMaterial model.mdl model.component1 of
                ( subModel, msgs ) ->
                    ( { model | component1 = subModel }, msgs )

        MsgComponent2 subMsg ->
            case Component2.update subMsg MsgComponent2 MsgMaterial model.mdl model.component2 of
                ( subModel, msgs ) ->
                    ( { model | component2 = subModel }, msgs )


view : Model -> Html Msg
view model =
    div []
        [ text "main"
        , Component1.view MsgComponent1 MsgMaterial model.mdl model.component1
        , Component2.view MsgComponent2 MsgMaterial model.mdl model.component2
        ]