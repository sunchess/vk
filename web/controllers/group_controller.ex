defmodule Vg.GroupController do
  use Vg.Web, :controller
  use Guardian.Phoenix.Controller

  alias Vg.Group
  alias Vg.User

  plug Guardian.Plug.EnsureAuthenticated, handler: Vg.SessionController
  plug Guardian.Plug.VerifySession

  def index(conn, _params, _user, _claims) do
    groups = Repo.all(from g in Group, preload: [:user] )
    render(conn, "index.html", groups: groups)
  end

  def new(conn, _params,  current_user, _claims) do
    changeset = Group.changeset(%Group{}, %{user_id: current_user.id})
    render(conn, "new.html", changeset: changeset, users: get_users )
  end

  def create(conn, %{"group" => group_params}, _user, _claims) do
    changeset = Group.changeset(%Group{}, group_params)

    case Repo.insert(changeset) do
      {:ok, _group} ->
        conn
        |> put_flash(:info, "Group created successfully.")
        |> redirect(to: group_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, users: get_users)
    end
  end

  def show(conn, %{"id" => id}, _user, _claims) do
    group = Repo.get!(Group, id)
    render(conn, "show.html", group: group)
  end

  def edit(conn, %{"id" => id}, _user, _claims) do
    group = Repo.get!(Group, id)
    changeset = Group.changeset(group)
    render(conn, "edit.html", group: group, changeset: changeset, users: get_users())
  end

  def update(conn, %{"id" => id, "group" => group_params}, _user, _claims) do
    group = Repo.get!(Group, id)
    changeset = Group.changeset(group, group_params)

    case Repo.update(changeset) do
      {:ok, group} ->
        conn
        |> put_flash(:info, "Group updated successfully.")
        |> redirect(to: group_path(conn, :show, group))
      {:error, changeset} ->
        render(conn, "edit.html", group: group, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, _user, _claims) do
    group = Repo.get!(Group, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(group)

    conn
    |> put_flash(:info, "Group deleted successfully.")
    |> redirect(to: group_path(conn, :index))
  end

  defp get_users() do
    Repo.all(from u in User, order_by: :name)
  end
end
