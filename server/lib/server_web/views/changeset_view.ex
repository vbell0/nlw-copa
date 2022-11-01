defmodule ServerWeb.ChangesetView do
  use ServerWeb, :view

  def render("error.json", %{changeset: changeset}) do
    %{errors: changeset}
  end
end
