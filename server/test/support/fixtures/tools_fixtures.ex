defmodule Server.ToolsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Server.Tools` context.
  """

  @doc """
  Generate a tool.
  """
  def tool_fixture(attrs \\ %{}) do
    {:ok, tool} =
      attrs
      |> Enum.into(%{
        code: "some code",
        title: "some title"
      })
      |> Server.Tools.create_tool()

    tool
  end
end
