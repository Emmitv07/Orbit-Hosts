defmodule OrbitHosts.Repo do
  use Ecto.Repo,
    otp_app: :orbit_hosts,
    adapter: Ecto.Adapters.Postgres
end
