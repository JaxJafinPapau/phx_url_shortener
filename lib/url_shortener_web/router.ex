defmodule UrlShortenerWeb.Router do
  use UrlShortenerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", UrlShortenerWeb do
    pipe_through :api
    resources "/mutators", MutatorController
  end

  scope "/", UrlShortenerWeb do
    get ":path", RedirectController, :show
  end
end
