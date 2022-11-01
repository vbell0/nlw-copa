defmodule Server.Pools do

  import Ecto.Query, warn: false
  alias Server.Repo

  alias Server.Pools.Pool

  def count_pools do
    Repo.all(Pool)
    |> Enum.count()
  end
end
