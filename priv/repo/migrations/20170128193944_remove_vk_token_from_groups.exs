defmodule Vg.Repo.Migrations.RemoveVkTokenFromGroups do
  use Ecto.Migration

  def change do
    alter table(:groups) do
      remove :vk_token
    end
  end
end
