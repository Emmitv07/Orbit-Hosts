defmodule OrbitHostsWeb.DashboardLive do
  use OrbitHostsWeb, :live_view

  alias OrbitHostsWeb.Layouts

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Dashboard")
     |> assign(:active_nav, "dashboard")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.Dashboard.dashboard
      flash={@flash}
      active_nav={@active_nav}
      page_subtitle="Mission Control"
    >
      <div class="space-y-6">
        <div>
          <h1 class="text-2xl sm:text-3xl font-bold text-white tracking-tight">
            Your fleet, at a glance
          </h1>
          <p class="mt-1 text-sm text-slate-400">
            Monitor and manage your Minecraft servers from orbit.
          </p>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          <.stat_card label="Active Servers" value="0" icon="hero-server" trend="Ready to launch" />
          <.stat_card label="Players Online" value="0" icon="hero-users" trend="—" />
          <.stat_card label="CPU Usage" value="0%" icon="hero-cpu-chip" trend="Idle" />
          <.stat_card label="Uptime" value="100%" icon="hero-bolt" trend="All systems go" />
        </div>

        <div class="rounded-2xl border border-slate-800/80 bg-slate-900/40 backdrop-blur-sm p-8 sm:p-12 text-center">
          <div class="mx-auto h-14 w-14 rounded-2xl bg-gradient-to-br from-indigo-500/20 to-fuchsia-500/20 border border-indigo-500/30 flex items-center justify-center">
            <.icon name="hero-rocket-launch" class="size-7 text-indigo-300" />
          </div>
          <h3 class="mt-4 text-lg font-semibold text-white">Launch your first server</h3>
          <p class="mt-1 text-sm text-slate-400 max-w-md mx-auto">
            Spin up a Minecraft server in under a minute. Choose a plan, pick a region, and you're live.
          </p>
          <button class="mt-6 inline-flex items-center gap-2 rounded-lg bg-gradient-to-r from-indigo-500 to-fuchsia-500 px-5 py-2.5 text-sm font-semibold text-white shadow-lg shadow-indigo-500/20 hover:shadow-indigo-500/40 hover:scale-[1.02] active:scale-[0.98] transition-all">
            <.icon name="hero-plus" class="size-4" /> Create Server
          </button>
        </div>
      </div>
    </Layouts.Dashboard.dashboard>
    """
  end

  attr :label, :string, required: true
  attr :value, :string, required: true
  attr :icon, :string, required: true
  attr :trend, :string, required: true

  defp stat_card(assigns) do
    ~H"""
    <div class="group rounded-xl border border-slate-800/80 bg-slate-900/50 backdrop-blur-sm p-5 hover:border-indigo-500/40 hover:bg-slate-900/70 transition-all">
      <div class="flex items-start justify-between">
        <div>
          <p class="text-xs font-medium text-slate-400 uppercase tracking-wider">{@label}</p>
          <p class="mt-2 text-2xl font-bold text-white tabular-nums">{@value}</p>
        </div>
        <div class="h-9 w-9 rounded-lg bg-slate-800/80 border border-slate-700/50 flex items-center justify-center group-hover:bg-indigo-500/10 group-hover:border-indigo-500/30 transition-colors">
          <.icon name={@icon} class="size-4 text-slate-400 group-hover:text-indigo-300 transition-colors" />
        </div>
      </div>
      <p class="mt-3 text-xs text-slate-500">{@trend}</p>
    </div>
    """
  end
end
