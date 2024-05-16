defmodule PhoenixTestWeb.HelloHTML do
  use PhoenixTestWeb, :html

  def index(assigns) do
    ~H"""
    Hello World!
    """
  end
end
