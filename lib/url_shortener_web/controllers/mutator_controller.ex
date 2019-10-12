defmodule UrlShortenerWeb.MutatorController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.URL
  alias UrlShortener.URL.Mutator

  action_fallback UrlShortenerWeb.FallbackController

  def index(conn, _params) do
    mutators = URL.list_mutators()
    render(conn, "index.json", mutators: mutators)
  end

  def create(conn, %{"mutator" => mutator_params}) do
    with {:ok, %Mutator{} = mutator} <- URL.create_mutator(mutator_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.mutator_path(conn, :show, mutator))
      |> render("show.json", mutator: mutator)
    end
  end

  def show(conn, %{"id" => id}) do
    mutator = URL.get_mutator!(id)
    render(conn, "show.json", mutator: mutator)
  end

  def update(conn, %{"id" => id, "mutator" => mutator_params}) do
    mutator = URL.get_mutator!(id)

    with {:ok, %Mutator{} = mutator} <- URL.update_mutator(mutator, mutator_params) do
      render(conn, "show.json", mutator: mutator)
    end
  end

  def delete(conn, %{"id" => id}) do
    mutator = URL.get_mutator!(id)

    with {:ok, %Mutator{}} <- URL.delete_mutator(mutator) do
      send_resp(conn, :no_content, "")
    end
  end
end
