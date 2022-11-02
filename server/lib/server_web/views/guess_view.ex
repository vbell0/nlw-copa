defmodule ServerWeb.GuessView do
  use ServerWeb, :view

  def render("count.json", %{data: params}) do
    %{
      count: params
    }
  end

  def render("error.json", %{errors: params}) do
    %{
      errors: params
    }
  end
end
