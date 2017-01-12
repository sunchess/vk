defmodule Vg.Session do
  import Ecto.Query
  alias Vg.User
  alias Vg.Repo

  def create(email, password) do
    q =
      from User,
      where: [email: ^email]

    user = Repo.one(q)

    if user != nil do
      case check_password(password, user) do
        true ->
          {:ok, user}
        _ ->
          {:error, "Password is invalid"}
      end
    else
      {:error, "User is not found"}
    end
  end

  defp check_password(password, user) do
    Comeonin.Bcrypt.checkpw(password, user.crypted_password)
  end
end
