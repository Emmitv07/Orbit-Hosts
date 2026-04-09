defmodule OrbitHostsWeb.PlayersLive do
  use OrbitHostsWeb, :live_view

  alias OrbitHostsWeb.Layouts

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Players")
     |> assign(:active_nav, "players")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.Dashboard.dashboard
      flash={@flash}
      active_nav={@active_nav}
      page_subtitle="Players"
    >
      <div class="space-y-6">
        <div>
          <h1 class="text-2xl sm:text-3xl font-bold text-white tracking-tight">Players</h1>
          <p class="mt-1 text-sm text-slate-400">
            Manage whitelists, ops, and bans across your servers.
          </p>
        </div>

        <div class="rounded-2xl border border-slate-800/80 bg-slate-900/40 backdrop-blur-sm p-12 text-center">
          <div class="mx-auto h-14 w-14 rounded-2xl bg-gradient-to-br from-indigo-500/20 to-fuchsia-500/20 border border-indigo-500/30 flex items-center justify-center">
            <.icon name="hero-user-group" class="size-7 text-indigo-300" />
          </div>
          <h3 class="mt-4 text-lg font-semibold text-white">No players to manage</h3>
          <p class="mt-1 text-sm text-slate-400 max-w-md mx-auto">
            Once players join your servers they'll show up here, where you can op, ban, or whitelist them.
          </p>
        </div>
      </div>
    </Layouts.Dashboard.dashboard>
    """
  end
end
