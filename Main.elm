module Main exposing (main)

import Component1
import Component2
import Html exposing (Html, div, text)
import Material
import Material.Color as Color
import Material.Scheme


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view >> Material.Scheme.topWithScheme Color.Blue Color.Red
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
    = MsgComponent1 Component1.Msg
    | MsgComponent2 Component2.Msg
    | MsgMaterial (Material.Msg Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        wrap msgWrapper subMsg updateFn modelGetter modelUpdater =
            case updateFn subMsg (modelGetter model) of
                ( subModel, subMsgs ) ->
                    ( modelUpdater model subModel, Cmd.map msgWrapper subMsgs )
    in
    case msg of
        MsgComponent1 subMsg ->
            case Component1.update subMsg model.component1 of
                ( subModel, subMsgs ) ->
                    ( { model | component1 = subModel }, Cmd.map MsgComponent1 subMsgs )

        MsgComponent2 subMsg ->
            wrap MsgComponent2 subMsg Component2.update .component2 (\m x -> { m | component2 = x })

        MsgMaterial subMsg ->
            Material.update MsgMaterial subMsg model


view : Model -> Html Msg
view model =
    div []
        [ text "main"
        , Component1.view MsgComponent1 MsgMaterial model.component1 model.mdl
        , Component2.view MsgComponent2 MsgMaterial model.component2 model.mdl
        ]
