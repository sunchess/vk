defmodule Vg.PageController do
  use Vg.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
