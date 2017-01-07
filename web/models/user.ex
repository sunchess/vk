defmodule Vg.User do
  use Vg.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :crypted_password, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :crypted_password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_required([:name])
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
