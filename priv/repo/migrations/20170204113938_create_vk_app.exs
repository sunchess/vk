defmodule Vg.Repo.Migrations.CreateVkApp do
  use Ecto.Migration

  def change do
    create table(:vk_apps) do
      add :user_id, references(:users)
      add :app_id, :integer
      add :app_key, :string

      timestamps()
    end

    create index(:vk_apps, [:user_id])
  end
end
