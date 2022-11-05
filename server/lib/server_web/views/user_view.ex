defmodule ServerWeb.UserView do
  use ServerWeb, :view

  def render("count.json", %{data: params}) do
    %{
      count: params
    }
  end

  def render("user.json", %{data: params}) do
    IO.inspect(params)

    %{
      user: %{
        name: params.name,
        email: params.email,
        id: params.id,
        create_at: params.inserted_at,
        avatar_url: params.avatar_url
      }
    }
  end

  def render("error.json", %{errors: params}) do
    %{
      errors: params
    }
  end
end
