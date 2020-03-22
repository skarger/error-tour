module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h2, img, p, pre, span, text, textarea)
import Html.Attributes exposing (cols, height, placeholder, rows, src, style)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as JD


type alias Model =
    { userInput : String
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
    = EnterText String
    | ParseJSON
    | FetchData (Result Http.Error String)


main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { userInput = ""
      , status = Waiting
      , errorMessage = ""
      , catName = "(not set)"
      , imageUrl = ""
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EnterText text ->
            ( { model | userInput = text }, Cmd.none )

        ParseJSON ->
            case model.userInput |> JD.decodeString (JD.field "name" JD.string) of
                Ok name ->
                    ( { model | status = ParseSucceeded, catName = name }, fetchData name )

                Err e ->
                    ( { model | status = ParseFailed, catName = "(not set)", errorMessage = JD.errorToString e }, Cmd.none )

        FetchData httpResult ->
            case httpResult of
                Ok imageUrl ->
                    ( { model | status = DownloadSucceeded, imageUrl = imageUrl }, Cmd.none )

                Err e ->
                    ( handleHttpError model e, Cmd.none )


fetchData : String -> Cmd Msg
fetchData name =
    Http.get
        { url = "https://s3.amazonaws.com/stephen.karger-data/" ++ String.toLower name ++ ".json"
        , expect = Http.expectJson FetchData (JD.field "imageUrl" JD.string)
        }


handleHttpError : Model -> Http.Error -> Model
handleHttpError model error =
    case error of
        Http.BadUrl string ->
            { model | status = DownloadFailed, errorMessage = "Bad URL: " ++ string }

        Http.Timeout ->
            { model | status = DownloadFailed, errorMessage = "HTTP timeout" }

        Http.NetworkError ->
            { model | status = DownloadFailed, errorMessage = "HTTP network error" }

        Http.BadStatus int ->
            { model | status = DownloadFailed, errorMessage = "HTTP response status: " ++ String.fromInt int }

        Http.BadBody string ->
            { model | status = DownloadFailed, errorMessage = "Unexpected response body: " ++ string }


view : Model -> Html Msg
view model =
    div [ style "margin" "16px" ]
        [ div [] <| inputView model
        , div [] <| resultView model
        ]


inputView : Model -> List (Html Msg)
inputView model =
    [ h2 [] [ text "Kitty Cat Parser" ]
    , textarea [ rows 20, cols 40, placeholder "JSON format: { \"name\": \"<cat name>\" }", onInput EnterText ] []
    , div []
        [ span [] [ text "Input:" ]
        , pre [] [ text model.userInput ]
        ]
    , button [ onClick ParseJSON ] [ text "Parse and fetch" ]
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
