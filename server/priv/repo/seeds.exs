# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Server.Repo.insert!(%Server.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Server.{Repo, User, Pool, Participant, Guess, Gamer}

{:ok, user} = User.changeset(%User{}, %{name: "Victor", email: "victor@test.com", avatar_url: "htttps://github.com/vbell0.png"}) |> Repo.insert()

{:ok, pool} = Pool.changeset(%Pool{}, %{code: "BAL123", title: "Exemple Pool", owner_id: user.id}, user) |> Repo.insert()

{:ok, participant} = Participant.changeset(%Participant{}, %{user_id: user.id, pool_id: pool.id}, user, pool) |> Repo.insert()

{:ok, gamer} = Gamer.changeset(%Gamer{}, %{date: ~U[2022-12-01 22:27:47.608590Z], fist_team_country_code: "BR", secound_team_country_code: "EU"}) |> Repo.insert()

{:ok, gamer2} = Gamer.changeset(%Gamer{}, %{date: ~U[2022-12-01 22:27:47.608590Z], fist_team_country_code: "BR", secound_team_country_code: "AR"}) |> Repo.insert()

{:ok, guess} = Guess.changeset(%Guess{}, %{fist_team_points: 5, second_team_points: 1, gamer_id: gamer2.id, participant_id: participant.id}) |> Repo.insert()

