defmodule DemoWeb.PrivatePageController do
  use DemoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
