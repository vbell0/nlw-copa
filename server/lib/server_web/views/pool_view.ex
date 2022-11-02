defmodule ServerWeb.PoolView do
  use ServerWeb, :view

  def render("create.json", %{data: params}) do
    %{
      code: params.code
    }
  end

  def render("count.json", %{data: params}) do
    %{
      count: params
    }
  end

  def render("error.json", %{errors: params}) do
    %{errors: params}
  end
end
