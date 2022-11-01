defmodule ServerWeb.PoolView do
  use ServerWeb, :view

  def render("count.json", %{pools: pools}) do
    %{
      count: pools
    }
  end
end
