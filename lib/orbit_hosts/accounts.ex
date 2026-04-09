defmodule OrbitHosts.Accounts do
  use Ash.Domain,
    otp_app: :orbit_hosts

  resources do
    resource OrbitHosts.Accounts.Token
    resource OrbitHosts.Accounts.User
  end
end
