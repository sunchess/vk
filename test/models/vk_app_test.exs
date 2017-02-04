defmodule Vg.VkAppTest do
  use Vg.ModelCase

  alias Vg.VkApp

  @valid_attrs %{app_id: 42, app_key: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = VkApp.changeset(%VkApp{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = VkApp.changeset(%VkApp{}, @invalid_attrs)
    refute changeset.valid?
  end
end
