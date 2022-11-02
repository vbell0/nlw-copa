defmodule Server.TestsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Server.Tests` context.
  """

  @doc """
  Generate a test.
  """
  def test_fixture(attrs \\ %{}) do
    {:ok, test} =
      attrs
      |> Enum.into(%{
        test: "some test"
      })
      |> Server.Tests.create_test()

    test
  end
end
