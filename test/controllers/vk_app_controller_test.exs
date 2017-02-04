defmodule Vg.VkAppControllerTest do
  use Vg.ConnCase

  alias Vg.VkApp
  @valid_attrs %{app_id: 42, app_key: "some content", user_id: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, vk_app_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing vk apps"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, vk_app_path(conn, :new)
    assert html_response(conn, 200) =~ "New vk app"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, vk_app_path(conn, :create), vk_app: @valid_attrs
    assert redirected_to(conn) == vk_app_path(conn, :index)
    assert Repo.get_by(VkApp, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, vk_app_path(conn, :create), vk_app: @invalid_attrs
    assert html_response(conn, 200) =~ "New vk app"
  end

  test "shows chosen resource", %{conn: conn} do
    vk_app = Repo.insert! %VkApp{}
    conn = get conn, vk_app_path(conn, :show, vk_app)
    assert html_response(conn, 200) =~ "Show vk app"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, vk_app_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    vk_app = Repo.insert! %VkApp{}
    conn = get conn, vk_app_path(conn, :edit, vk_app)
    assert html_response(conn, 200) =~ "Edit vk app"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    vk_app = Repo.insert! %VkApp{}
    conn = put conn, vk_app_path(conn, :update, vk_app), vk_app: @valid_attrs
    assert redirected_to(conn) == vk_app_path(conn, :show, vk_app)
    assert Repo.get_by(VkApp, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    vk_app = Repo.insert! %VkApp{}
    conn = put conn, vk_app_path(conn, :update, vk_app), vk_app: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit vk app"
  end

  test "deletes chosen resource", %{conn: conn} do
    vk_app = Repo.insert! %VkApp{}
    conn = delete conn, vk_app_path(conn, :delete, vk_app)
    assert redirected_to(conn) == vk_app_path(conn, :index)
    refute Repo.get(VkApp, vk_app.id)
  end
end
