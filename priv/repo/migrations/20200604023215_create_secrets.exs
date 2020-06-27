defmodule Demo.Repo.Migrations.CreateSecrets do
  use Ecto.Migration

  def change do
    create table(:secrets) do
      add :key, :string
      add :value, :string
      add :accound_id, references(:accounts, on_delete: :nothing)

      timestamps()
    end

    create index(:secrets, [:accound_id])
  end
end
