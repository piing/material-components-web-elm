module Material.IconButton exposing
    ( IconButtonConfig, iconButtonConfig
    , iconButton
    , iconToggleConfig
    , iconToggle
    , customIconButton
    )

{-|

@docs IconButtonConfig, iconButtonConfig

@docs iconButton

@docs iconToggleConfig
@docs iconToggle

@docs customIconButton

-}

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Html.Events


{-| TODO docs
-}
type alias IconButtonConfig msg =
    { on : Bool
    , label : Maybe String
    , additionalAttributes : List (Html.Attribute msg)
    , onClick : Maybe msg
    }


{-| TODO docs
-}
iconButtonConfig : IconButtonConfig msg
iconButtonConfig =
    { on = False
    , additionalAttributes = []
    , label = Nothing
    , onClick = Nothing
    }


{-| TODO docs
-}
iconButton : IconButtonConfig msg -> String -> Html msg
iconButton config iconName =
    Html.node "mdc-icon-button"
        (List.filterMap identity
            [ rootCs
            , materialIconsCs
            , tabIndexAttr
            , clickHandler config
            ]
            ++ config.additionalAttributes
        )
        [ text iconName ]


{-| TODO docs
-}
customIconButton : IconButtonConfig msg -> List (Html msg) -> Html msg
customIconButton config nodes =
    Html.node "mdc-icon-button"
        (List.filterMap identity
            [ rootCs
            , tabIndexAttr
            , clickHandler config
            ]
            ++ config.additionalAttributes
        )
        nodes


{-| TODO docs
-}
iconToggleConfig : IconButtonConfig msg
iconToggleConfig =
    iconButtonConfig


{-| TODO docs
-}
iconToggle : IconButtonConfig msg -> { on : String, off : String } -> Html msg
iconToggle config { on, off } =
    Html.node "mdc-icon-button"
        (List.filterMap identity
            [ rootCs
            , onAttr config
            , ariaHiddenAttr
            , ariaPressedAttr config
            , ariaLabelAttr config
            , tabIndexAttr
            , clickHandler config
            ]
            ++ config.additionalAttributes
        )
        [ Html.i (List.filterMap identity [ materialIconsCs, onIconCs ]) [ text on ]
        , Html.i (List.filterMap identity [ materialIconsCs, iconCs ]) [ text off ]
        ]


rootCs : Maybe (Html.Attribute msg)
rootCs =
    Just (class "mdc-icon-button")


onAttr : IconButtonConfig msg -> Maybe (Html.Attribute msg)
onAttr { on } =
    if on then
        Just (Html.Attributes.attribute "data-on" "")

    else
        Nothing


materialIconsCs : Maybe (Html.Attribute msg)
materialIconsCs =
    Just (class "material-icons")


iconCs : Maybe (Html.Attribute msg)
iconCs =
    Just (class "mdc-icon-button__icon")


onIconCs : Maybe (Html.Attribute msg)
onIconCs =
    Just (class "mdc-icon-button__icon mdc-icon-button__icon--on")


tabIndexAttr : Maybe (Html.Attribute msg)
tabIndexAttr =
    Just (Html.Attributes.tabindex 0)


ariaHiddenAttr : Maybe (Html.Attribute msg)
ariaHiddenAttr =
    Just (Html.Attributes.attribute "aria-hidden" "true")


ariaPressedAttr : IconButtonConfig msg -> Maybe (Html.Attribute msg)
ariaPressedAttr { on } =
    Just
        (Html.Attributes.attribute "aria-pressed"
            (if on then
                "true"

             else
                "false"
            )
        )


ariaLabelAttr : IconButtonConfig msg -> Maybe (Html.Attribute msg)
ariaLabelAttr { label } =
    Maybe.map (Html.Attributes.attribute "aria-label") label


clickHandler : IconButtonConfig msg -> Maybe (Html.Attribute msg)
clickHandler config =
    Maybe.map Html.Events.onClick config.onClick