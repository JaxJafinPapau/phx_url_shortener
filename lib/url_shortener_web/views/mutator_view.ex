defmodule UrlShortenerWeb.MutatorView do
  use UrlShortenerWeb, :view
  alias UrlShortenerWeb.MutatorView

  def render("index.json", %{mutators: mutators}) do
    %{data: render_many(mutators, MutatorView, "mutator.json")}
  end

  def render("show.json", %{mutator: mutator}) do
    %{data: render_one(mutator, MutatorView, "mutator.json")}
  end

  def render("mutator.json", %{mutator: mutator}) do
    %{id: mutator.id,
      long_url: mutator.long_url,
      short_url: mutator.short_url}
  end
end
