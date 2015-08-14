import Html exposing (..)
import Html.Attributes exposing (..)
import StartApp

type alias Model =
    { todos : List Todo }

type alias Todo =
    { description : String
    , complete : Bool
    , uid : Int
    }            

main =
  StartApp.start { model = model, view = view, update = update }

model =
  { todos = [
     { uid = 1, description = "Learn Elm", complete = False }
    ] }

view address model =
  section
    [ class "todoapp" ]
    [
      todoHeader
      , todoMain
      , todoFooter
    ]

todoHeader =
  header [ class "header" ] [
    h1 [] [text "Todos"]
    , input [class "new-todo", placeholder "What to do?"] []
  ]

todoMain =
  section [class "main"] [
    input [class "toggle-all", type' "checkbox"] []
    , label [for "toggle-all"] [text "Mark all as complete"]
    , ul [ class "todo-list" ] (List.map todoItem model.todos)
  ]

todoItem item =
  li
    [class "todo-item"] [
    div [class "view"] [
      input [class "toggle", type' "checkbox"] []
      , label [] [text item.description]
      , button [class "desctroy"] []
    ]
  ]

todoFooter =
  footer [class "footer"] [
    span [class "todo-count"] [
      strong [] [text "0"]
      , text " Items"
    ]
    , ul [class "filters"] [
      li [] [ a [class "selected", href "#/"] [text "All"] ]
      , li [] [ a [href "#/active"] [text "Active"] ]
      , li [] [ a [href "#/completed"] [text "Completed"] ]
    ]
  ]

update: String -> Model -> Model
update action model =
  model
    
