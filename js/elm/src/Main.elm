module Main exposing (..)

import Browser
import Html exposing (Html, button, div, pre, span, text, textarea)
import Html.Attributes exposing (cols, placeholder, rows)
import Html.Events exposing (onClick, onInput)
import Json.Decode exposing (Decoder, decodeString, field, map, string)


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
    , cat : Maybe Cat
    }


type Status
    = Waiting
    | Failure
    | Success


type alias Cat =
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
                    decodeString catDecoder model.input
            in
            case parseResult of
                Ok cat ->
                    ( { model | cat = Just cat, status = Success }, Cmd.none )

                Err _ ->
                    ( { model | status = Failure }, Cmd.none )


catDecoder : Decoder Cat
catDecoder =
    map Cat
        (field "name" string)


view : Model -> Html Msg
view model =
    div []
        [ div [] <| inputView model
        , div [] <| resultView model
        ]


inputView : Model -> List (Html Msg)
inputView model =
    [ textarea [ rows 20, cols 40, placeholder "Enter JSON...", onInput EnterJSON ] []
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
            [ text "Could not parse cat from given input." ]

        Success ->
            [ text <| "Parse succeeded. Cat name: " ++ getCatName model.cat ]

        Waiting ->
            [ text "" ]


getCatName : Maybe Cat -> String
getCatName mcat =
    case mcat of
        Just cat ->
            cat.name

        Nothing ->
            ""


init : () -> ( Model, Cmd Msg )
init _ =
    ( { input = "", status = Waiting, cat = Nothing }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
