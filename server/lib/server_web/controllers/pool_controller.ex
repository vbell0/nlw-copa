defmodule ServerWeb.PoolController do
  use ServerWeb, :controller

  alias Server.Pools

  action_fallback ServerWeb.FallbackController

  def count(conn, _params) do
    count_pool = Pools.count_pools()
    render(conn, "count.json", pools: count_pool)
  end
end
