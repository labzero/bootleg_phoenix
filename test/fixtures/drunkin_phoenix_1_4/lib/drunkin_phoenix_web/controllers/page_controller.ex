defmodule DrunkinPhoenixWeb.PageController do
  use DrunkinPhoenixWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
