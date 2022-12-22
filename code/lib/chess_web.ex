defmodule ChessWeb do
  @moduledoc """
  Un module qui continue d'utiliser des définitions pour les contrôleurs,
   vues et ainsi de suite.

   Cela peut être utilisé dans votre application comme :

       utiliser Chess.Web, :contrôleur
       utiliser Chess.Web, :view

   Les définitions ci-dessous seront exécutées pour chaque vue,
   contrôleur, etc., alors gardez-les courts et clairs, concentrés
   sur les importations, les utilisations et les pseudonymes.

   Ne définissez PAS de fonctions à l'intérieur des expressions entre guillemets dessous.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: ChessWeb

      alias Chess.Repo
      import Ecto
      import Ecto.Query

      import ChessWeb.Router.Helpers
      import ChessWeb.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/chess_web/templates",
        namespace: ChessWeb

      # Importer des fonctions pratiques à partir de contrôleurs
      import Phoenix.Controller,
        only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Utiliser toutes les fonctionnalités HTML (forms, tags, etc)
      use Phoenix.HTML

      import Formulator

      import ChessWeb.Router.Helpers
      import ChessWeb.ErrorHelpers
      import ChessWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Chess.Repo
      import Ecto
      import Ecto.Query
      import ChessWeb.Gettext
    end
  end

  @doc """
  Lorsqu'il est utilisé, envoyez-le au controller/view/etc. approprié.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
