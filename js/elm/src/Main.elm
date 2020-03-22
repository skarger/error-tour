module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h2, img, p, pre, span, text, textarea)
import Html.Attributes exposing (cols, height, placeholder, rows, src, style)
import Html.Events exposing (onClick, onInput)
import Http
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
    , catName : String
    , imageUrl : String
    }


type Status
    = Waiting
    | ParseSucceeded
    | ParseFailed
    | DownloadSucceeded
    | DownloadFailed


type Msg
    = EnterJSON String
    | ParseJSON
    | FetchData (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EnterJSON str ->
            ( { model | status = model.status, input = str }, Cmd.none )

        ParseJSON ->
            let
                parseResult =
                    JD.decodeString (JD.field "name" JD.string) model.input
            in
            case parseResult of
                Ok name ->
                    ( { model | catName = name, status = ParseSucceeded }, fetchData name )

                Err e ->
                    ( { model | catName = notSet, status = ParseFailed, errorMessage = JD.errorToString e }, Cmd.none )

        FetchData httpResult ->
            case httpResult of
                Ok imageUrl ->
                    ( { model | imageUrl = imageUrl, status = DownloadSucceeded }, Cmd.none )

                Err e ->
                    case e of
                        Http.BadUrl string ->
                            ( { model | errorMessage = "Bad URL: " ++ string, status = DownloadFailed }, Cmd.none )

                        Http.Timeout ->
                            ( { model | errorMessage = "HTTP timeout", status = DownloadFailed }, Cmd.none )

                        Http.NetworkError ->
                            ( { model | errorMessage = "HTTP network error", status = DownloadFailed }, Cmd.none )

                        Http.BadStatus int ->
                            ( { model | errorMessage = "HTTP response status: " ++ String.fromInt int, status = DownloadFailed }, Cmd.none )

                        Http.BadBody string ->
                            ( { model | errorMessage = "Unexpected response body: " ++ string, status = DownloadFailed }, Cmd.none )


fetchData : String -> Cmd Msg
fetchData name =
    Http.get
        { url = "https://s3.amazonaws.com/stephen.karger-data/" ++ String.toLower name ++ ".json"
        , expect = Http.expectJson FetchData (JD.field "imageUrl" JD.string)
        }


notSet =
    "(not set)"


view : Model -> Html Msg
view model =
    div [ style "margin" "16px" ]
        [ div [] <| inputView model
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
        ParseFailed ->
            [ p [] [ text <| "Could not parse given input." ]
            , p [] [ text model.errorMessage ]
            , p [] [ text "Expected format: { \"name\": \"<cat name>\" }" ]
            ]

        ParseSucceeded ->
            [ p [] [ text <| "Parse succeeded." ]
            , catView model
            ]

        DownloadFailed ->
            [ p [] [ text <| "Parse succeeded." ]
            , catView model
            , p [] [ text <| "Data fetch failed." ]
            , p [] [ text model.errorMessage ]
            ]

        DownloadSucceeded ->
            [ p [] [ text <| "Parse succeeded." ]
            , catView model
            , p [] [ text <| "Data fetch succeeded." ]
            , p [] [ img [ src model.imageUrl, height 300 ] [] ]
            ]

        Waiting ->
            [ text "" ]


catView : Model -> Html Msg
catView model =
    p [] [ text <| "Cat name: " ++ model.catName ]


init : () -> ( Model, Cmd Msg )
init _ =
    ( { input = "", status = Waiting, errorMessage = "", catName = notSet, imageUrl = "" }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
