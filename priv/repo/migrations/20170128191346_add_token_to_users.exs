defmodule Vg.Repo.Migrations.AddTokenToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :vk_token, :string
    end
  end
end
