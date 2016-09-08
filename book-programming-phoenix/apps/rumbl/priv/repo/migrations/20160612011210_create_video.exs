defmodule Rumbl.Repo.Migrations.CreateVideo do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :url, :string
      add :title, :string
      add :description, :text
      add :view_count, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps
    end

    create index(:videos, [:user_id])
  end
end
