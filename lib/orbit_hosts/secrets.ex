defmodule OrbitHosts.Secrets do
  use AshAuthentication.Secret

  def secret_for(
        [:authentication, :tokens, :signing_secret],
        OrbitHosts.Accounts.User,
        _opts,
        _context
      ) do
    Application.fetch_env(:orbit_hosts, :token_signing_secret)
  end
end
