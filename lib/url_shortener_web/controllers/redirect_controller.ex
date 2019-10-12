defmodule UrlShortenerWeb.RedirectController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.URL
  alias UrlShortener.URL.Mutator

  action_fallback UrlShortenerWeb.FallbackController

  def show(conn, %{"path" => path_params}) do
    mutator = URL.get_by(short_url: path_params)
    redirect(conn, external: mutator.long_url)
  end
end