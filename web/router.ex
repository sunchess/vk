defmodule Vg.Router do
  use Vg.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Vg do
    pipe_through [:browser, :browser_auth] # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/session", SessionController, only: [:new, :create]
    get "/session/delete", SessionController, :delete, as: :delete_session
  end

  # Other scopes may use custom stacks.
  # scope "/api", Vg do
  #   pipe_through :api
  # end
end
