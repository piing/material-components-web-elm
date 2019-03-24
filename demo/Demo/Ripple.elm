module Demo.Ripple exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Helper.Hero as Hero
import Demo.Helper.ResourceLink as ResourceLink
import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes
import Material.Elevation as Elevation
import Material.Ripple as Ripple exposing (ripple, rippleConfig)
import Material.Typography as Typography


type alias Model =
    {}


defaultModel : Model
defaultModel =
    {}


type Msg
    = NoOp


update : (Msg -> m) -> Msg -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


demoBox : (Msg -> m) -> String -> Model -> String -> Html m
demoBox lift index model label =
    Html.div
        [ Ripple.rippleSurface
        , Html.Attributes.style "display" "flex"
        , Html.Attributes.style "align-items" "center"
        , Html.Attributes.style "justify-content" "center"
        , Html.Attributes.style "width" "200px"
        , Html.Attributes.style "height" "100px"
        , Html.Attributes.style "padding" "1rem"
        , Html.Attributes.style "cursor" "pointer"
        , Html.Attributes.style "user-select" "none"
        , Html.Attributes.style "background-color" "#fff"
        , Html.Attributes.style "overflow" "hidden"
        , Elevation.z2
        , Html.Attributes.tabindex 0
        ]
        [ text label
        , ripple rippleConfig
        ]


demoIcon : (Msg -> m) -> String -> Model -> String -> Html m
demoIcon lift index model icon =
    Html.div
        [ Ripple.rippleSurface
        , Html.Attributes.class "material-icons"
        , Html.Attributes.style "width" "24px"
        , Html.Attributes.style "height" "24px"
        , Html.Attributes.style "padding" "12px"
        , Html.Attributes.style "border-radius" "50%"
        ]
        [ text icon
        , ripple { rippleConfig | unbounded = True }
        ]


view : (Msg -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Ripple"
        "Ripples are visual representations used to communicate the status of a component or interactive element."
        [ Hero.view [] [ demoBox lift "ripple-hero-ripple" model "Click here!" ]
        , Html.h2
            [ Typography.headline6
            , Html.Attributes.style "border-bottom" "1px solid rgba(0,0,0,.87)"
            ]
            [ text "Resources"
            ]
        , ResourceLink.view
            { link = "https://material.io/go/design-states"
            , title = "Material Design Guidelines"
            , icon = "images/material.svg"
            , altText = "Material Design Guidelines icon"
            }
        , ResourceLink.view
            { link = "https://material.io/components/web/catalog/ripples/"
            , title = "Documentation"
            , icon = "images/ic_drive_document_24px.svg"
            , altText = "Documentation icon"
            }
        , ResourceLink.view
            { link = "https://github.com/material-components/material-components-web/tree/master/packages/mdc-ripple"
            , title = "Source Code (Material Components Web)"
            , icon = "images/ic_code_24px.svg"
            , altText = "Source Code"
            }
        , Page.demos
            [ Html.h3 [ Typography.subtitle1 ] [ text "Bounded Ripple" ]
            , demoBox lift "ripple-bounded-ripple" model "Interact with me!"
            , Html.h3 [ Typography.subtitle1 ] [ text "Unbounded Ripple" ]
            , demoIcon lift "ripple-unbounded-ripple" model "favorite"
            ]
        ]