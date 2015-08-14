import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Signal exposing (Signal, Address)
import StartApp

type alias Model =
    { todos : List Todo
    , field : String
    }

type alias Todo =
    { description : String
    , complete : Bool
    , uid : Int
    }

type Action
     = AddTodo
     | UpdateField String


main =
  StartApp.start { model = {field = "", todos = []}, view = view, update = update }


view: Address Action -> Model -> Html
view address model =
  section [ class "todoapp" ]
    [ todoHeader address model
    , todoMain address model
    , todoFooter
    ]

onEnter : Address a -> a -> Attribute
onEnter address value =
    on "keydown"
      (Json.customDecoder keyCode is13)
      (\_ -> Signal.message address value)


is13 : Int -> Result String ()
is13 code =
  if code == 13 then Ok () else Err "not the right key code"

todoHeader address model =
  header [ class "header" ]
    [ h1 [] [text "Todos"]
      , input
        [ class "new-todo"
        , placeholder "What to do?"
        , value model.field
        , on "input" targetValue (Signal.message address << UpdateField)
        , onEnter address AddTodo
        ]
        []
    ]

todoMain address model =
  section [class "main"]
    [ input [class "toggle-all", type' "checkbox"] []
    , label [for "toggle-all"] [text "Mark all as complete"]
    , ul [ class "todo-list" ] (List.map todoItem model.todos)
    ]

todoItem item =
  li
    [class "todo-item"]
    [ div [class "view"]
      [ input [class "toggle", type' "checkbox"] []
      , label [] [text item.description]
      , button [class "desctroy"] []
      ]
    ]

todoFooter =
  footer [class "footer"]
    [ span [class "todo-count"]
      [ strong [] [text "0"]
      , text " Items"
      ]
    , ul [class "filters"]
      [ li [] [ a [class "selected", href "#/"] [text "All"] ]
      , li [] [ a [href "#/active"] [text "Active"] ]
      , li [] [ a [href "#/completed"] [text "Completed"] ]
      ]
    ]

update: Action -> Model -> Model
update action model =
  case action of
    AddTodo ->
      { model |
          field <- "",
          todos <- model.todos ++ [ { uid = 2, description = model.field, complete = False } ]
      }
    UpdateField value ->
      { model | field <- value }
    
