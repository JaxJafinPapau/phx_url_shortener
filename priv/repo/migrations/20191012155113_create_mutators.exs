defmodule UrlShortener.Repo.Migrations.CreateMutators do
  use Ecto.Migration

  def change do
    create table(:mutators) do
      add :long_url, :string
      add :short_url, :string

      timestamps()
    end

  end
end
