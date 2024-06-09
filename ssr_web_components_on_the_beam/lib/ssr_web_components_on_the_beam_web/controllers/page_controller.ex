defmodule SsrWebComponentsOnTheBeamWeb.PageController do
  use SsrWebComponentsOnTheBeamWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
