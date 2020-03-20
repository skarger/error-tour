module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h2, p, pre, span, text, textarea)
import Html.Attributes exposing (cols, placeholder, rows, style)
import Html.Events exposing (onClick, onInput)
import Json.Decode as JD


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    { input : String
    , status : Status
    , errorMessage : String
    , cat : Maybe KittyCat
    }


type Status
    = Waiting
    | Failure
    | Success


type alias KittyCat =
    { name : String
    }


type Msg
    = EnterJSON String
    | ParseJSON


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EnterJSON str ->
            ( { model | cat = model.cat, status = Waiting, input = str }, Cmd.none )

        ParseJSON ->
            let
                parseResult =
                    JD.decodeString catDecoder model.input
            in
            case parseResult of
                Ok cat ->
                    ( { model | cat = Just cat, status = Success }, Cmd.none )

                Err e ->
                    ( { model | cat = Nothing, status = Failure, errorMessage = JD.errorToString e }, Cmd.none )


catDecoder : JD.Decoder KittyCat
catDecoder =
    JD.map KittyCat
        (JD.field "name" JD.string)


view : Model -> Html Msg
view model =
    div [ style "margin" "16px" ]
        [ div [] <| inputView model
        , div [] <| catView model
        , div [] <| resultView model
        ]


inputView : Model -> List (Html Msg)
inputView model =
    [ h2 [] [ text "Kitty Cat Parser" ]
    , textarea [ rows 20, cols 40, placeholder "JSON format: { \"name\": \"<cat name>\" }", onInput EnterJSON ] []
    , div []
        [ span [] [ text "Input:" ]
        , pre [] [ text model.input ]
        ]
    , button [ onClick ParseJSON ] [ text "Parse JSON" ]
    ]


resultView : Model -> List (Html Msg)
resultView model =
    case model.status of
        Failure ->
            [ p [] [ text <| "Could not parse given input: " ]
            , p [] [ text model.errorMessage ]
            , p [] [ text "Expected format: { \"name\": \"<cat name>\" }" ]
            ]

        Success ->
            [ text <| "Parse succeeded." ]

        Waiting ->
            [ text "" ]


catView : Model -> List (Html Msg)
catView model =
    [ p [] [ text <| "Cat name: " ++ getCatName model.cat ] ]


getCatName : Maybe KittyCat -> String
getCatName mcat =
    case mcat of
        Just cat ->
            cat.name

        Nothing ->
            "(not set)"


init : () -> ( Model, Cmd Msg )
init _ =
    ( { input = "", status = Waiting, errorMessage = "", cat = Nothing }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
