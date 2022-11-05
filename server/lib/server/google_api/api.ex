defmodule Server.GoogleApi do
  alias Tesla.Middleware.{BaseUrl, JSON, Headers}

  def get_user_info(token) do
    case Tesla.get(client(token), "/userinfo") do
      {:ok, params} -> {:ok, params.body}
      {:error, _} -> {:error, "invalid google token"}
    end
  end

  defp client(token) do
    adapter = {Tesla.Adapter.Hackney, [recv_timeout: 30_000]}

    [
      {BaseUrl, "https://www.googleapis.com/oauth2/v2"},
      JSON,
      {Headers, [{"authorization", "Bearer " <> token}]}
    ]
    |> Tesla.client(adapter)
  end
end
