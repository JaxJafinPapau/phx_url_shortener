defmodule UrlShortener.RedirectTest do
  use UrlShortenerWeb.ConnCase

  alias UrlShortener.Links
  alias UrlShortener.Links.Url

  @short_address %{short_address: "asdfghjkll"}
  @long_address %{long_address: "www.testinghere.com"}
  @valid_attrs %{long_address: "some long_address", short_address: "short_address"}

  describe "url redirect" do
    def url_fixture(attrs \\ %{}) do
      {:ok, url} =
        attrs
        |> Enum.into(@short_address)
        |> Enum.into(@long_address)
        |> Links.create_url()
      url
    end
  end

  test "shit redirects", %{conn: conn} do
    url_fixture()
    conn = get(conn, Routes.redirect_path(conn, :redirect_to, @short_address[:short_address]))
    assert redirected_to(conn) == @long_address[:long_address]
  end

  test "testing unique constraint on long url" do
    assert {:ok, %Url{} = url} = Links.create_url(@valid_attrs)
    assert {:error, changeset} = Links.create_url(@valid_attrs)
  end
end