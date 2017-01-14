defmodule Vg.Group do
  use Vg.Web, :model

  schema "groups" do
    belongs_to :user, Vg.User
    field :name, :string
    field :vk_id, :integer
    field :vk_link, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :name, :vk_id, :vk_link])
    |> validate_required([:user_id, :name, :vk_id, :vk_link])
  end
end
