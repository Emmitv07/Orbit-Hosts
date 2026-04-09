defmodule OrbitHostsWeb.ServersLive do
  use OrbitHostsWeb, :live_view

  alias OrbitHostsWeb.Layouts

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "My Servers")
     |> assign(:active_nav, "servers")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.Dashboard.dashboard
      flash={@flash}
      active_nav={@active_nav}
      page_subtitle="My Servers"
    >
      <div class="space-y-6">
        <div class="flex items-start justify-between flex-wrap gap-4">
          <div>
            <h1 class="text-2xl sm:text-3xl font-bold text-white tracking-tight">My Servers</h1>
            <p class="mt-1 text-sm text-slate-400">
              Manage all your Minecraft servers from one place.
            </p>
          </div>
          <button class="inline-flex items-center gap-2 rounded-lg bg-gradient-to-r from-indigo-500 to-fuchsia-500 px-4 py-2 text-sm font-semibold text-white shadow-lg shadow-indigo-500/20 hover:shadow-indigo-500/40 hover:scale-[1.02] active:scale-[0.98] transition-all">
            <.icon name="hero-plus" class="size-4" /> Deploy New Server
          </button>
        </div>

        <div class="rounded-2xl border border-slate-800/80 bg-slate-900/40 backdrop-blur-sm p-12 text-center">
          <div class="mx-auto h-14 w-14 rounded-2xl bg-gradient-to-br from-indigo-500/20 to-fuchsia-500/20 border border-indigo-500/30 flex items-center justify-center">
            <.icon name="hero-server-stack" class="size-7 text-indigo-300" />
          </div>
          <h3 class="mt-4 text-lg font-semibold text-white">No servers yet</h3>
          <p class="mt-1 text-sm text-slate-400 max-w-md mx-auto">
            You haven't deployed any servers. Click "Deploy New Server" to get started.
          </p>
        </div>
      </div>
    </Layouts.Dashboard.dashboard>
    """
  end
end
