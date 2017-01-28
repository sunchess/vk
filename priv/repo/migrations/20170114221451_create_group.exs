defmodule Vg.Repo.Migrations.CreateGroup do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :user_id, references(:users)
      add :name, :string
      add :vk_id, :integer
      add :vk_link, :string
      add :vk_token, :string

      timestamps()
    end

    create index(:groups, [:user_id])
  end
end
