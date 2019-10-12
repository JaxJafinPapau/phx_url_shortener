defmodule UrlShortener.URL do
  @moduledoc """
  The URL context.
  """

  import Ecto.Query, warn: false
  alias UrlShortener.Repo

  alias UrlShortener.URL.Mutator

  
  @doc """
  Returns the list of mutators.
  
  ## Examples
  
  iex> list_mutators()
  [%Mutator{}, ...]
  
  """
  def list_mutators do
    Repo.all(Mutator)
  end
  
  @doc """
  Gets a single mutator.
  
  Raises `Ecto.NoResultsError` if the Mutator does not exist.
  
  ## Examples
  
  iex> get_mutator!(123)
  %Mutator{}
  
  iex> get_mutator!(456)
  ** (Ecto.NoResultsError)
  
  """
  def get_mutator!(id), do: Repo.get!(Mutator, id)
  def get_by(conditions), do: Repo.get_by!(Mutator, conditions)

  @doc """
  Creates a mutator.

  ## Examples

      iex> create_mutator(%{field: value})
      {:ok, %Mutator{}}

      iex> create_mutator(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mutator(attrs \\ %{}) do
    %Mutator{}
    |> Mutator.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mutator.

  ## Examples

      iex> update_mutator(mutator, %{field: new_value})
      {:ok, %Mutator{}}

      iex> update_mutator(mutator, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mutator(%Mutator{} = mutator, attrs) do
    mutator
    |> Mutator.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Mutator.

  ## Examples

      iex> delete_mutator(mutator)
      {:ok, %Mutator{}}

      iex> delete_mutator(mutator)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mutator(%Mutator{} = mutator) do
    Repo.delete(mutator)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mutator changes.

  ## Examples

      iex> change_mutator(mutator)
      %Ecto.Changeset{source: %Mutator{}}

  """
  def change_mutator(%Mutator{} = mutator) do
    Mutator.changeset(mutator, %{})
  end
end
