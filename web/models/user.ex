defmodule Vg.User do
  use Vg.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :crypted_password, :string
    field :password, :string, virtual: true
    field :vk_token, :string
    has_many :groups, Vg.Group
    has_many :vk_apps, Vg.VkApp

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def set_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password])
  end

  def update_changeset(struct, params \\ %{}) do
    #if we need to change the password
    if String.length(params["password"]) > 0 do
      struct
      |>cast(params, [:name, :email, :password, :vk_token])
      |>validate_length( :password, min: 5)
      |>put_change(:crypted_password, hashed_password(params["password"]))
    end

    struct
    |> cast(params, [:name, :email, :password, :vk_token])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_required([:name, :email])
    |> put_change(:email, String.downcase(params["email"]))
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_required([:name, :email, :password])
    |> put_change(:crypted_password, hashed_password(params["password"]))
    |> put_change(:email, String.downcase(params["email"]))
  end

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end
end
