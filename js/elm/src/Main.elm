module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h2, img, p, text, textarea)
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
                    ( { model | status = ParseSucceeded, catName = name, imageUrl = "" }, fetchData name )

                Err e ->
                    ( { model | status = ParseFailed, catName = "(not set)", imageUrl = "", errorMessage = JD.errorToString e }, Cmd.none )

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
            { model | status = DownloadFailed, imageUrl = "", errorMessage = "Bad URL: " ++ string }

        Http.Timeout ->
            { model | status = DownloadFailed, imageUrl = "", errorMessage = "HTTP timeout" }

        Http.NetworkError ->
            { model | status = DownloadFailed, imageUrl = "", errorMessage = "HTTP network error" }

        Http.BadStatus int ->
            { model | status = DownloadFailed, imageUrl = "", errorMessage = "HTTP response status: " ++ String.fromInt int }

        Http.BadBody string ->
            { model | status = DownloadFailed, imageUrl = "", errorMessage = "Unexpected response body: " ++ string }


view : Model -> Html Msg
view model =
    div [ style "margin" "16px" ]
        [ topRowView model
        ]


topRowView model =
    div [ style "display" "flex" ] [ inputView, resultView model ]


inputView : Html Msg
inputView =
    div [ style "margin-right" "16px" ]
        [ h2 [] [ text "Kitty Cat Parser" ]
        , textarea [ rows 8, cols 40, placeholder "JSON format: { \"name\": \"<cat name>\" }", onInput EnterText ] []
        , p [] [ button [ onClick ParseJSON ] [ text "Parse and fetch" ] ]
        ]


resultView : Model -> Html Msg
resultView model =
    let
        resultRows =
            case model.status of
                ParseFailed ->
                    [ p [] [ text <| "Could not parse given input." ]
                    , p [] [ text model.errorMessage ]
                    , p [] [ text "Expected format: { \"name\": \"<cat name>\" }" ]
                    ]

                ParseSucceeded ->
                    [ successfulParseView model.catName ]

                DownloadFailed ->
                    [ successfulParseView model.catName
                    , p [] [ text <| "Data fetch failed." ]
                    , p [] [ text model.errorMessage ]
                    ]

                DownloadSucceeded ->
                    [ successfulParseView model.catName
                    , p [] [ text <| "Data fetch succeeded." ]
                    , catPicView model
                    ]

                Waiting ->
                    [ text "" ]
    in
    div [] <| [ h2 [] [ text "Results" ] ] ++ resultRows


successfulParseView : String -> Html Msg
successfulParseView name =
    p [] [ text <| "Parse succeeded: Cat name: " ++ name ]


catPicView : Model -> Html Msg
catPicView model =
    img [ src model.imageUrl, height 300 ] []
