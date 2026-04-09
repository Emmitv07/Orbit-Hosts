defmodule OrbitHostsWeb.SettingsLive do
  use OrbitHostsWeb, :live_view

  alias OrbitHostsWeb.Layouts

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Settings")
     |> assign(:active_nav, "settings")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.Dashboard.dashboard
      flash={@flash}
      active_nav={@active_nav}
      page_subtitle="Settings"
    >
      <div class="space-y-6 max-w-3xl">
        <div>
          <h1 class="text-2xl sm:text-3xl font-bold text-white tracking-tight">Settings</h1>
          <p class="mt-1 text-sm text-slate-400">
            Manage your account, security, and preferences.
          </p>
        </div>

        <div class="rounded-2xl border border-slate-800/80 bg-slate-900/40 backdrop-blur-sm p-6">
          <h3 class="text-base font-semibold text-white">Profile</h3>
          <p class="mt-1 text-sm text-slate-400">Your display name and email.</p>
          <div class="mt-4 space-y-3">
            <div>
              <label class="block text-xs font-medium text-slate-400 uppercase tracking-wider mb-1">Display Name</label>
              <input type="text" value="Operator" class="w-full rounded-lg bg-slate-800/60 border border-slate-700/50 px-3 py-2 text-sm text-slate-200 focus:outline-none focus:border-indigo-500/60 transition-colors" />
            </div>
            <div>
              <label class="block text-xs font-medium text-slate-400 uppercase tracking-wider mb-1">Email</label>
              <input type="email" placeholder="you@example.com" class="w-full rounded-lg bg-slate-800/60 border border-slate-700/50 px-3 py-2 text-sm text-slate-200 placeholder:text-slate-500 focus:outline-none focus:border-indigo-500/60 transition-colors" />
            </div>
          </div>
        </div>

        <div class="rounded-2xl border border-slate-800/80 bg-slate-900/40 backdrop-blur-sm p-6">
          <h3 class="text-base font-semibold text-white">Security</h3>
          <p class="mt-1 text-sm text-slate-400">Password and two-factor authentication.</p>
          <button class="mt-4 inline-flex items-center gap-2 rounded-lg bg-slate-800/80 border border-slate-700/50 px-4 py-2 text-sm font-medium text-slate-200 hover:bg-slate-800 transition-colors">
            <.icon name="hero-key" class="size-4" /> Change Password
          </button>
        </div>
      </div>
    </Layouts.Dashboard.dashboard>
    """
  end
end
