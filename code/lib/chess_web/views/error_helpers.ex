defmodule ChessWeb.ErrorHelpers do
  @moduledoc """
  Commodités pour traduire et créer des messages d'erreur.
  """

  use Phoenix.HTML

  @doc """
  Génère une balise pour les erreurs de saisie de formulaire en ligne.
  """
  def error_tag(form, field) do
    if error = form.errors[field] do
      content_tag(:span, translate_error(error), class: "help-block")
    end
  end

  @doc """
  Traduit un message d'erreur à l'aide de gettext.
  """
  def translate_error({msg, opts}) do
    # Parce que les messages d'erreur ont été définis dans Ecto, nous devons
    # appelez le module Gettext en passant notre backend Gettext. Nous
    # utilise également le domaine "errors" au fur et à mesure que les traductions sont placées
    # dans le fichier errors.po.
    # Ecto passera le mot clé :count si le message d'erreur est
    # destiné à être pluralisé.
    # Sur votre propre code et templates, selon que vous
    # besoin que le message soit pluralisé ou non, cela pourrait être
    # écrit simplement comme :
    #
    #     dngettext "errors", "1 file", "%{count} files", count
    #     dgettext "errors", "is invalid"
    #
    if count = opts[:count] do
      Gettext.dngettext(ChessWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(ChessWeb.Gettext, "errors", msg, opts)
    end
  end
end
