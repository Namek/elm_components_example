module Component2 exposing (Model, Msg, model, update, view)

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
    { text = "component2"
    }


type Msg
    = Btn2Clicked


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Btn2Clicked ->
            ( { model | text = "btn 2 clicked" }, Cmd.none )


view : (Msg -> msg) -> (Material.Msg msg -> msg) -> Model -> Material.Model -> Html msg
view lift liftMaterial model mdlModel =
    div []
        [ text model.text
        , Button.render
            liftMaterial
            [ ids.c2Button ]
            mdlModel
            [ Button.raised
            , Button.colored
            , Button.ripple
            , Options.onClick (lift Btn2Clicked)
            ]
            [ text "btn1" ]
        ]
