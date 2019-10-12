defmodule UrlShortener.URLTest do
  use UrlShortener.DataCase

  alias UrlShortener.URL

  describe "mutators" do
    alias UrlShortener.URL.Mutator

    @valid_attrs %{long_url: "some long_url", short_url: "some short_url"}
    @update_attrs %{long_url: "some updated long_url", short_url: "some updated short_url"}
    @invalid_attrs %{long_url: nil, short_url: nil}

    def mutator_fixture(attrs \\ %{}) do
      {:ok, mutator} =
        attrs
        |> Enum.into(@valid_attrs)
        |> URL.create_mutator()

      mutator
    end

    test "list_mutators/0 returns all mutators" do
      mutator = mutator_fixture()
      assert URL.list_mutators() == [mutator]
    end

    test "get_mutator!/1 returns the mutator with given id" do
      mutator = mutator_fixture()
      assert URL.get_mutator!(mutator.id) == mutator
    end

    test "create_mutator/1 with valid data creates a mutator" do
      assert {:ok, %Mutator{} = mutator} = URL.create_mutator(@valid_attrs)
      assert mutator.long_url == "some long_url"
      assert mutator.short_url == "some short_url"
    end

    test "create_mutator/1 should not create duplicate urls" do
      assert {:ok, %Mutator{} = mutator} = URL.create_mutator(@valid_attrs)
      assert {:error, _} = URL.create_mutator(@valid_attrs)
    end

    test "create_mutator/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = URL.create_mutator(@invalid_attrs)
    end

    test "update_mutator/2 with valid data updates the mutator" do
      mutator = mutator_fixture()
      assert {:ok, %Mutator{} = mutator} = URL.update_mutator(mutator, @update_attrs)
      assert mutator.long_url == "some updated long_url"
      assert mutator.short_url == "some updated short_url"
    end

    test "update_mutator/2 with invalid data returns error changeset" do
      mutator = mutator_fixture()
      assert {:error, %Ecto.Changeset{}} = URL.update_mutator(mutator, @invalid_attrs)
      assert mutator == URL.get_mutator!(mutator.id)
    end

    test "delete_mutator/1 deletes the mutator" do
      mutator = mutator_fixture()
      assert {:ok, %Mutator{}} = URL.delete_mutator(mutator)
      assert_raise Ecto.NoResultsError, fn -> URL.get_mutator!(mutator.id) end
    end

    test "change_mutator/1 returns a mutator changeset" do
      mutator = mutator_fixture()
      assert %Ecto.Changeset{} = URL.change_mutator(mutator)
    end
  end
end
