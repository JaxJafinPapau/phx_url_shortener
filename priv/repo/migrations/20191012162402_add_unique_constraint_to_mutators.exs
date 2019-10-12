defmodule UrlShortener.Repo.Migrations.AddUniqueConstraintToMutators do
  use Ecto.Migration

  def change do
    create unique_index(:mutators, [:long_url])
    create unique_index(:mutators, [:short_url])
  end
end
