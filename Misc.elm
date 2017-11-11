module Misc exposing (makeLifter)

import Material


{-| Create a lifter for `update` function

    type Msg
        = MsgMaterial (Material.Msg Msg)
        | MsgComponent1 Component1.Msg
        | MsgComponent2 Component2.Msg

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

-}
makeLifter :
    { parentModel | mdl : Material.Model }
    -> msgMaterialType
    -> (subMsg -> msgType -> msgMaterialType -> Material.Model -> subModelAccessor -> ( g, msgs ))
    -> ({ parentModel | mdl : Material.Model } -> g -> subModel)
    -> subMsg
    -> msgType
    -> ({ parentModel | mdl : Material.Model } -> subModelAccessor)
    -> ( subModel, msgs )
makeLifter model msgMaterialType updateFn subUpdateFn subMsg msgType modelAccessor =
    case updateFn subMsg msgType msgMaterialType model.mdl (modelAccessor model) of
        ( subModel, msgs ) ->
            ( subUpdateFn model subModel, msgs )
