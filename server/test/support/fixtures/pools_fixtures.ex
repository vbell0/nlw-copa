defmodule Server.PoolsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Server.Pools` context.
  """

  @doc """
  Generate a pool.
  """
  def pool_fixture(attrs \\ %{}) do
    {:ok, pool} =
      attrs
      |> Enum.into(%{
        code: "some code",
        title: "some title"
      })
      |> Server.Pools.create_pool()

    pool
  end
end
