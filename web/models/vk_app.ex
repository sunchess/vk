defmodule Vg.VkApp do
  use Vg.Web, :model

  schema "vk_apps" do
    belongs_to :user, Vg.User
    field :app_id, :integer
    field :app_key, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :app_id, :app_key])
    |> validate_required([:user_id, :app_id, :app_key])
  end
end
