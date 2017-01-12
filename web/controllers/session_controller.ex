defmodule Vg.SessionController do
  use Vg.Web, :controller
  import Vg.ViewHelpers


  #alias Ppush.User
  alias Vg.Session

  def new(conn, _params) do
    if current_user(conn) do
      conn
      |> put_flash(:info, gettext("You are already loggedin"))
      |> redirect(to: "/")
    else
      render conn
    end
  end

  def create(conn, %{"session" => session_params}) do
    case Session.create(session_params["email"], session_params["password"]) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "You are logged in")
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: "/")
      # {:ok, user, :admin} ->
        #   conn
        #   |> put_flash(:info, "You are logged in as admin")
        #   |> Guardian.Plug.sign_in(user, :access)
        #   |> Guardian.Plug.sign_in(user, :access, key: :admin) #TODO: added perms to db and set it by Guardian perms perms: %{default: Guardian.Permissions.max})
       #   |> redirect(to: "/")
      {:error, _} ->
        conn
        |> put_flash(:info, gettext("User or password is invalid"))
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    Guardian.Plug.sign_out(conn)
    |> put_flash(:info, gettext("Logged out successfully."))
    |> redirect(to: "/")
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "Authentication required")
    |> redirect(to: session_path(conn, :new))
  end
end
