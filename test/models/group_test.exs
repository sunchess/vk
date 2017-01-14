defmodule Vg.GroupTest do
  use Vg.ModelCase

  alias Vg.Group

  @valid_attrs %{name: "some content", user_id: 42, vk_id: 42, vk_link: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Group.changeset(%Group{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Group.changeset(%Group{}, @invalid_attrs)
    refute changeset.valid?
  end
end
