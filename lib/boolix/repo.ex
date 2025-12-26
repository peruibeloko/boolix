defmodule Boolix.Repo do
  use Ecto.Repo,
    otp_app: :boolix,
    adapter:
      if(Application.compile_env(:boolix, :env) == :prod,
        do: Ecto.Adapters.Postgres,
        else: Ecto.Adapters.SQLite3
      )
end
