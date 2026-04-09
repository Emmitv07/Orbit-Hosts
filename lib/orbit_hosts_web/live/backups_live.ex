defmodule OrbitHostsWeb.BackupsLive do
  use OrbitHostsWeb, :live_view

  alias OrbitHostsWeb.Layouts

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Backups")
     |> assign(:active_nav, "backups")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.Dashboard.dashboard
      flash={@flash}
      active_nav={@active_nav}
      page_subtitle="Backups"
    >
      <div class="space-y-6">
        <div>
          <h1 class="text-2xl sm:text-3xl font-bold text-white tracking-tight">Backups</h1>
          <p class="mt-1 text-sm text-slate-400">
            Automatic and manual snapshots of your worlds.
          </p>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
          <div class="rounded-xl border border-slate-800/80 bg-slate-900/50 backdrop-blur-sm p-5">
            <p class="text-xs font-medium text-slate-400 uppercase tracking-wider">Total Backups</p>
            <p class="mt-2 text-2xl font-bold text-white tabular-nums">0</p>
          </div>
          <div class="rounded-xl border border-slate-800/80 bg-slate-900/50 backdrop-blur-sm p-5">
            <p class="text-xs font-medium text-slate-400 uppercase tracking-wider">Storage Used</p>
            <p class="mt-2 text-2xl font-bold text-white tabular-nums">0 MB</p>
          </div>
          <div class="rounded-xl border border-slate-800/80 bg-slate-900/50 backdrop-blur-sm p-5">
            <p class="text-xs font-medium text-slate-400 uppercase tracking-wider">Last Backup</p>
            <p class="mt-2 text-2xl font-bold text-white tabular-nums">—</p>
          </div>
        </div>

        <div class="rounded-2xl border border-slate-800/80 bg-slate-900/40 backdrop-blur-sm p-12 text-center">
          <div class="mx-auto h-14 w-14 rounded-2xl bg-gradient-to-br from-indigo-500/20 to-fuchsia-500/20 border border-indigo-500/30 flex items-center justify-center">
            <.icon name="hero-archive-box" class="size-7 text-indigo-300" />
          </div>
          <h3 class="mt-4 text-lg font-semibold text-white">No backups yet</h3>
          <p class="mt-1 text-sm text-slate-400 max-w-md mx-auto">
            Backups will appear here once you've deployed a server and enabled snapshots.
          </p>
        </div>
      </div>
    </Layouts.Dashboard.dashboard>
    """
  end
end
