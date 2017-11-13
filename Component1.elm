module Component1 exposing (Model, Msg, model, update, view)

import Common exposing (ids)
import Html exposing (Html, div, text)
import Html.Events exposing (onClick)
import Material
import Material.Button as Button
import Material.Options as Options


type alias Model =
    { text : String
    , isButtonRaised : Bool
    }


model : Model
model =
    { text = "component1"
    , isButtonRaised = True
    }


type Msg
    = Btn1Clicked
    | DivClicked


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Btn1Clicked ->
            ( { model | text = "btn 1 clicked" }, Cmd.none )

        DivClicked ->
            ( { model | isButtonRaised = False }, Cmd.none )


view : (Msg -> parentMsg) -> (Material.Msg parentMsg -> parentMsg) -> Model -> Material.Model -> Html parentMsg
view lift liftMaterial model mdlModel =
    div [ onClick (lift DivClicked) ]
        [ text model.text
        , Button.render
            liftMaterial
            [ ids.c1Button ]
            mdlModel
            [ Button.raised |> Options.when model.isButtonRaised
            , Button.colored
            , Button.ripple
            , Options.onClick (lift Btn1Clicked)
            ]
            [ text "btn1" ]
        ]
