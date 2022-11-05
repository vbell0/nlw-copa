defmodule Server.Guess.Services do
  alias Server.{Repo, Guess}

  def count(), do: Repo.all(Guess) |> length()
end
