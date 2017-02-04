defmodule Vg.VkAppController do
  use Vg.Web, :controller
  use Guardian.Phoenix.Controller

  alias Vg.VkApp

  plug Guardian.Plug.EnsureAuthenticated, handler: Vg.SessionController
  plug Guardian.Plug.VerifySession

  def index(conn, _params, _user, _claims) do
    vk_apps = Repo.all(from g in VkApp, preload: [:user])
    render(conn, "index.html", vk_apps: vk_apps)
  end

  def new(conn, _params, _user, _claims) do
    changeset = VkApp.changeset(%VkApp{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"vk_app" => vk_app_params}, current_user, _claims) do
    #add current user as creator
    params = Map.merge(%{"user_id" => current_user.id}, vk_app_params)

    changeset = VkApp.changeset(%VkApp{}, params)

    case Repo.insert(changeset) do
      {:ok, _vk_app} ->
        conn
        |> put_flash(:info, "Vk app created successfully.")
        |> redirect(to: vk_app_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _user, _claims) do
    vk_app = VkApp |> Repo.get!(id) |> Repo.preload(:user)
    render(conn, "show.html", vk_app: vk_app)
  end

  def edit(conn, %{"id" => id}, _user, _claims) do
    vk_app = Repo.get!(VkApp, id)
    changeset = VkApp.changeset(vk_app)
    render(conn, "edit.html", vk_app: vk_app, changeset: changeset)
  end

  def update(conn, %{"id" => id, "vk_app" => vk_app_params}, _user, _claims) do
    vk_app = Repo.get!(VkApp, id)
    changeset = VkApp.changeset(vk_app, vk_app_params)

    case Repo.update(changeset) do
      {:ok, vk_app} ->
        conn
        |> put_flash(:info, "Vk app updated successfully.")
        |> redirect(to: vk_app_path(conn, :show, vk_app))
      {:error, changeset} ->
        render(conn, "edit.html", vk_app: vk_app, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, _user, _claims) do
    vk_app = Repo.get!(VkApp, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(vk_app)

    conn
    |> put_flash(:info, "Vk app deleted successfully.")
    |> redirect(to: vk_app_path(conn, :index))
  end
end
