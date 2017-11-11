module Component1 exposing (Model, Msg, model, update, view)

import Common exposing (ids)
import Html exposing (Html, div, text)
import Material
import Material.Button as Button
import Material.Options as Options


type alias Model =
    { text : String
    }


model : Model
model =
    { text = "component1" }


type Msg
    = Btn1Clicked


update : Msg -> (Msg -> msg) -> (Material.Msg mdlMsg -> msg) -> Material.Model -> Model -> ( Model, Cmd msg )
update msg msgLifter mdlMsgLifter materialModel model =
    case msg of
        Btn1Clicked ->
            ( { text = "btn 1 clicked" }, Cmd.none )


view : (Msg -> parentMsg) -> (Material.Msg mdlMsg -> parentMsg) -> Material.Model -> Model -> Html parentMsg
view msgLifter mdlMsgLifter mdlModel model =
    div []
        [ text model.text
        , Button.render
            mdlMsgLifter
            [ ids.c1Button ]
            mdlModel
            [ Button.raised
            , Button.colored
            , Button.ripple
            , Options.onClick (msgLifter Btn1Clicked)
            ]
            [ text "btn1" ]
        ]
