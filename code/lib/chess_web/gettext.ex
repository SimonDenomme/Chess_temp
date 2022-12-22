defmodule ChessWeb.Gettext do
  @moduledoc """
  Un module fournissant l'internationalisation avec une API basée sur gettext.

   En utilisant [Gettext](https://hexdocs.pm/gettext),
   le module gagne un ensemble de macros pour les traductions, par exemple :

       import Chess.Gettext

       # Traduction simple
       gettext "Voici la chaîne à traduire"

       # Traduction multiple
       ngettext "Voici la chaîne à traduire",
                "Voici les chaînes à traduire",
                3

       # Traduction basée sur le domaine
       dgettext "errors", "Voici le message d'erreur à traduire"

   Voir [Gettext Docs](https://hexdocs.pm/gettext) pour une utilisation détaillée.
  """
  use Gettext, otp_app: :chess
end
