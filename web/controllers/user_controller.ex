defmodule Vg.UserController do
  use Vg.Web, :controller
  #use Guardian.Phoenix.Controller

  alias Vg.User
  alias Vg.VkApp

  plug Guardian.Plug.EnsureAuthenticated, handler: Vg.SessionController
  plug Guardian.Plug.VerifySession

  def index(conn, _params) do
    users = Repo.all(from u in User, order_by: :id, preload: [:groups])
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.set_changeset(%User{})
    vk_apps = Repo.all(from vk in VkApp)
    render(conn, "new.html", changeset: changeset, page_title: "New user", vk_apps: vk_apps)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = User |> Repo.get!(id) |> Repo.preload(:groups) |> Repo.preload(:vk_apps)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.set_changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset, page_title: "Edit user")
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.update_changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
