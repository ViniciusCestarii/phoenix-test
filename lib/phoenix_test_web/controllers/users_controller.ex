defmodule PhoenixTestWeb.UsersController do
  use PhoenixTestWeb, :controller

  alias PhoenixTest.Accounts
  alias PhoenixTest.Accounts.Users

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users_collection: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_users(%Users{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"users" => users_params}) do
    case Accounts.create_users(users_params) do
      {:ok, users} ->
        conn
        |> put_flash(:info, "Users created successfully.")
        |> redirect(to: ~p"/users/#{users}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    users = Accounts.get_users!(id)
    render(conn, :show, users: users)
  end

  def edit(conn, %{"id" => id}) do
    users = Accounts.get_users!(id)
    changeset = Accounts.change_users(users)
    render(conn, :edit, users: users, changeset: changeset)
  end

  def update(conn, %{"id" => id, "users" => users_params}) do
    users = Accounts.get_users!(id)

    case Accounts.update_users(users, users_params) do
      {:ok, users} ->
        conn
        |> put_flash(:info, "Users updated successfully.")
        |> redirect(to: ~p"/users/#{users}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, users: users, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    users = Accounts.get_users!(id)
    {:ok, _users} = Accounts.delete_users(users)

    conn
    |> put_flash(:info, "Users deleted successfully.")
    |> redirect(to: ~p"/users")
  end
end
