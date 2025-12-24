defmodule Boolix.Repo do
  use Ecto.Repo,
    otp_app: :boolix,
    adapter: Ecto.Adapters.Postgres
end
