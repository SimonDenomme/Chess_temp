defmodule Chess.DataCase do
  @moduledoc """
  Ce module définit le cas de test à utiliser par le modèle de test.

  Vous pouvez définir ici des fonctions à utiliser comme aides dans
  vos essais sur le modèle. Voir la définition de `errors_on/2` pour référence.

  Enfin, si le cas de test interagit avec la base de données,
  il ne peut pas être asynchrone. Pour cette raison, chaque test s'exécute
  à l'intérieur d'une transaction qui est réinitialisée au début
  du test à moins que le cas de test ne soit marqué comme asynchrone.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias Chess.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Chess.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Chess.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Chess.Repo, {:shared, self()})
    end

    :ok
  end

  @doc """
  Aide pour renvoyer la liste des erreurs dans une structure lorsqu'on lui donne certaines données.

  ## Exemples

  Étant donné un schéma utilisateur qui répertorie `: name` comme champ obligatoire et valide
   `:password` pour être sûr, il renverrait :

      iex> errors_on(%User{}, %{password: "password"})
      [password: "is unsafe", name: "is blank"]

  Vous pourriez alors écrire votre affirmation comme suit :

      assert {:password, "is unsafe"} in errors_on(%User{}, %{password: "password"})

  Vous pouvez également créer le changeset manuellement et récupérer les erreurs
   champ directement :

      iex> changeset = User.changeset(%User{}, password: "password")
      iex> {:password, "is unsafe"} in changeset.errors
      true
  """
  def errors_on(struct, data) do
    struct.__struct__.changeset(struct, data)
    |> Ecto.Changeset.traverse_errors(&ChessWeb.ErrorHelpers.translate_error/1)
    |> Enum.flat_map(fn {key, errors} -> for msg <- errors, do: {key, msg} end)
  end
end
