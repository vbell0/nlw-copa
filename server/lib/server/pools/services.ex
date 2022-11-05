defmodule Server.Pools.Services do
  alias Server.{User, Helper, Pool, Repo}

  def create(title) do
    Pool.changeset(
      %Pool{},
      %{title: title, code: Helper.gen_code() |> String.upcase()},
      %User{}
    )
    |> Repo.insert()
  end

  def count(), do: Repo.all(Pool) |> length()
end
