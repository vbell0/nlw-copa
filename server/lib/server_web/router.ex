defmodule ServerWeb.Router do
  use ServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ServerWeb.JwtPlug
  end

  # Not Required login
  scope "/api/v1/auth", ServerWeb do
    pipe_through :api

    post "/", AuthController, :signin
  end

  # Required Login
  scope "/api/v1", ServerWeb do
    pipe_through [:api, :auth]

    post "/pools", PoolController, :create
    get "/pools/count", PoolController, :count

    get "/users/count", UserController, :count
    get "/auth", UserController, :get

    get "/guesses/count", GuessController, :count

    delete "/auth", AuthController, :logout
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ServerWeb.Telemetry
    end
  end
end
