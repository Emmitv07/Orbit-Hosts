defmodule OrbitHostsWeb.PageController do
  use OrbitHostsWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
