defmodule OrbitHostsWeb.ConsoleLive do
  use OrbitHostsWeb, :live_view

  alias OrbitHostsWeb.Layouts

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Console")
     |> assign(:active_nav, "console")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.Dashboard.dashboard
      flash={@flash}
      active_nav={@active_nav}
      page_subtitle="Console"
    >
      <div class="space-y-6">
        <div>
          <h1 class="text-2xl sm:text-3xl font-bold text-white tracking-tight">Console</h1>
          <p class="mt-1 text-sm text-slate-400">
            Run commands and view live output from your servers.
          </p>
        </div>

        <div class="rounded-2xl border border-slate-800/80 bg-slate-950/80 backdrop-blur-sm overflow-hidden">
          <div class="flex items-center gap-2 border-b border-slate-800/80 px-4 py-3">
            <div class="flex gap-1.5">
              <span class="h-3 w-3 rounded-full bg-rose-500/80"></span>
              <span class="h-3 w-3 rounded-full bg-amber-500/80"></span>
              <span class="h-3 w-3 rounded-full bg-emerald-500/80"></span>
            </div>
            <span class="ml-2 text-xs text-slate-500 font-mono">no server selected</span>
          </div>
          <div class="p-4 font-mono text-xs text-slate-500 min-h-[300px]">
            <p>$ Select a server to begin a console session...</p>
          </div>
        </div>
      </div>
    </Layouts.Dashboard.dashboard>
    """
  end
end
