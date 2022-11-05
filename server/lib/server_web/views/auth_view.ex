defmodule ServerWeb.AuthView do
  use ServerWeb, :view

  def render("signin.json", %{data: params}) do
    %{
      token: params
    }
  end

  def render("login.json", %{data: params}) do
    %{
      data: params
    }
  end

  def render("logout.json", %{data: params}) do
    %{
      data: params
    }
  end
end
