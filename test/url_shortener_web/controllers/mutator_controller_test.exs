defmodule UrlShortenerWeb.MutatorControllerTest do
  use UrlShortenerWeb.ConnCase

  alias UrlShortener.URL
  alias UrlShortener.URL.Mutator

  @create_attrs %{
    long_url: "some long_url",
    short_url: "some short_url"
  }
  @update_attrs %{
    long_url: "some updated long_url",
    short_url: "some updated short_url"
  }
  @invalid_attrs %{long_url: nil, short_url: nil}

  def fixture(:mutator) do
    {:ok, mutator} = URL.create_mutator(@create_attrs)
    mutator
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all mutators", %{conn: conn} do
      conn = get(conn, Routes.mutator_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create mutator" do
    test "renders mutator when data is valid", %{conn: conn} do
      conn = post(conn, Routes.mutator_path(conn, :create), mutator: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.mutator_path(conn, :show, id))

      assert %{
               "id" => id,
               "long_url" => "some long_url",
               "short_url" => "some short_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.mutator_path(conn, :create), mutator: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update mutator" do
    setup [:create_mutator]

    test "renders mutator when data is valid", %{conn: conn, mutator: %Mutator{id: id} = mutator} do
      conn = put(conn, Routes.mutator_path(conn, :update, mutator), mutator: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.mutator_path(conn, :show, id))

      assert %{
               "id" => id,
               "long_url" => "some updated long_url",
               "short_url" => "some updated short_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, mutator: mutator} do
      conn = put(conn, Routes.mutator_path(conn, :update, mutator), mutator: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete mutator" do
    setup [:create_mutator]

    test "deletes chosen mutator", %{conn: conn, mutator: mutator} do
      conn = delete(conn, Routes.mutator_path(conn, :delete, mutator))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.mutator_path(conn, :show, mutator))
      end
    end
  end

  defp create_mutator(_) do
    mutator = fixture(:mutator)
    {:ok, mutator: mutator}
  end
end
