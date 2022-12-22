defmodule Chess.Auth do
  @moduledoc """
  Le contexte Auth est responsable de la gestion des utilisateurs et de l'authentification.
  """

  import Ecto.Query, warn: false
  alias Chess.Repo

  alias Chess.Store.User
  require Logger

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def check_pass(reference, password) do
    case reference do
      nil ->
        {:error, :not_found}
      %User{} ->
        if reference.password_hash === password do
          {:ok, reference}
        else
          {:error, :invalid_password}
        end
    end
  end

  @doc false
  def authenticate_user(email, password) do
    query = from u in User,
            where: u.email == ^email

    query
    |> Repo.one
    |> check_pass(password)
  end
end
