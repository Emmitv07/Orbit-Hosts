defmodule OrbitHostsWeb.Layouts.Dashboard do
  @moduledoc """
  Layout for authenticated dashboard pages.

  Wraps page content with a sidebar, top navbar, and animated starfield
  background. Use via the `:layout` option on a LiveView:

      use OrbitHostsWeb, :live_view

      on_mount {OrbitHostsWeb.DashboardNav, :default}

      @impl true
      def render(assigns) do
        ~H\"\"\"
        <Layouts.Dashboard.dashboard flash={@flash} active_nav={@active_nav}>
          <h1>Page content goes here</h1>
        </Layouts.Dashboard.dashboard>
        \"\"\"
      end
  """
  use Phoenix.Component

  alias OrbitHostsWeb.Components.Starfield
  import OrbitHostsWeb.CoreComponents, only: [icon: 1]
  import OrbitHostsWeb.Layouts, only: [flash_group: 1]

  attr :flash, :map, required: true
  attr :active_nav, :string, default: "dashboard"
  attr :page_title, :string, default: "Dashboard"
  attr :page_subtitle, :string, default: "Mission Control"
  slot :inner_block, required: true

  def dashboard(assigns) do
    ~H"""
    <.flash_group flash={@flash} />
    <div class="flex min-h-screen bg-slate-950 text-slate-100">
      <%!-- Sidebar --%>
      <aside class="hidden md:flex md:w-64 flex-col border-r border-slate-800/80 bg-slate-900/60 backdrop-blur">
        <div class="flex items-center gap-3 px-6 py-6 border-b border-slate-800/80">
          <div class="flex h-9 w-9 items-center justify-center rounded-lg bg-gradient-to-br from-indigo-500 to-fuchsia-500 shadow-lg shadow-indigo-500/30">
            <.icon name="hero-rocket-launch" class="size-5 text-white" />
          </div>
          <div>
            <p class="text-sm font-semibold tracking-tight text-white">Orbit Hosts</p>
            <p class="text-xs text-slate-400">Game Servers</p>
          </div>
        </div>

        <nav class="flex-1 px-3 py-4 space-y-1">
          <.nav_item id="dashboard" label="Dashboard" icon="hero-squares-2x2" href="/dashboard" active={@active_nav} />
          <.nav_item id="servers" label="My Servers" icon="hero-server-stack" href="/dashboard/servers" active={@active_nav} />
          <.nav_item id="console" label="Console" icon="hero-command-line" href="/dashboard/console" active={@active_nav} />
          <.nav_item id="backups" label="Backups" icon="hero-archive-box" href="/dashboard/backups" active={@active_nav} />
          <.nav_item id="players" label="Players" icon="hero-user-group" href="/dashboard/players" active={@active_nav} />
          <.nav_item id="billing" label="Billing" icon="hero-credit-card" href="/dashboard/billing" active={@active_nav} />

          <div class="pt-4 mt-4 border-t border-slate-800/80">
            <.nav_item id="settings" label="Settings" icon="hero-cog-6-tooth" href="/dashboard/settings" active={@active_nav} />
            <.nav_item id="support" label="Support" icon="hero-lifebuoy" href="/dashboard/support" active={@active_nav} />
          </div>
        </nav>

        <div class="px-4 py-4 border-t border-slate-800/80">
          <div class="flex items-center gap-3 rounded-lg bg-slate-800/60 p-3">
            <div class="h-8 w-8 rounded-full bg-gradient-to-br from-emerald-400 to-cyan-500 flex items-center justify-center text-xs font-bold text-slate-900">
              OH
            </div>
            <div class="flex-1 min-w-0">
              <p class="text-xs font-medium text-white truncate">Operator</p>
              <p class="text-[10px] text-slate-400 truncate">Free Plan</p>
            </div>
          </div>
        </div>
      </aside>

      <%!-- Main column --%>
      <div class="flex-1 flex flex-col min-w-0">
        <%!-- Navbar --%>
        <header class="flex items-center justify-between gap-4 px-4 sm:px-8 py-4 border-b border-slate-800/80 bg-slate-900/40 backdrop-blur-sm">
          <div class="flex items-center gap-3 min-w-0">
            <button
              class="md:hidden p-2 rounded-lg text-slate-400 hover:bg-slate-800 hover:text-white transition-colors"
              aria-label="Open menu"
            >
              <.icon name="hero-bars-3" class="size-5" />
            </button>
            <div class="min-w-0">
              <p class="text-xs text-slate-400">Welcome back</p>
              <h2 class="text-base sm:text-lg font-semibold text-white truncate">
                {@page_subtitle}
              </h2>
            </div>
          </div>

          <div class="flex items-center gap-2 sm:gap-3">
            <div class="hidden sm:flex items-center gap-2 rounded-lg bg-slate-800/60 px-3 py-2 border border-slate-700/50 focus-within:border-indigo-500/60 transition-colors">
              <.icon name="hero-magnifying-glass" class="size-4 text-slate-400" />
              <input
                type="text"
                placeholder="Search servers..."
                class="bg-transparent text-sm text-slate-200 placeholder:text-slate-500 focus:outline-none w-48"
              />
            </div>

            <button
              class="relative p-2 rounded-lg text-slate-400 hover:bg-slate-800 hover:text-white transition-colors"
              aria-label="Notifications"
            >
              <.icon name="hero-bell" class="size-5" />
              <span class="absolute top-1.5 right-1.5 h-2 w-2 rounded-full bg-fuchsia-500 ring-2 ring-slate-900"></span>
            </button>

            <button class="inline-flex items-center gap-2 rounded-lg bg-gradient-to-r from-indigo-500 to-fuchsia-500 px-3 sm:px-4 py-2 text-sm font-semibold text-white shadow-lg shadow-indigo-500/20 hover:shadow-indigo-500/40 hover:scale-[1.02] active:scale-[0.98] transition-all">
              <.icon name="hero-plus" class="size-4" />
              <span class="hidden sm:inline">New Server</span>
            </button>
          </div>
        </header>

        <%!-- Main content with starfield --%>
        <main class="relative flex-1 overflow-hidden">
          <Starfield.starfield id="dashboard-stars" count={80} />
          <div class="relative z-10 p-4 sm:p-8">
            {render_slot(@inner_block)}
          </div>
        </main>
      </div>
    </div>
    """
  end

  attr :id, :string, required: true
  attr :label, :string, required: true
  attr :icon, :string, required: true
  attr :href, :string, required: true
  attr :active, :string, required: true

  defp nav_item(assigns) do
    assigns = assign(assigns, :is_active, assigns.active == assigns.id)

    ~H"""
    <.link
      navigate={@href}
      class={[
        "group flex w-full items-center gap-3 rounded-lg px-3 py-2 text-sm font-medium transition-all",
        @is_active && "bg-gradient-to-r from-indigo-500/20 to-fuchsia-500/10 text-white border border-indigo-500/30 shadow-sm",
        !@is_active && "text-slate-400 hover:bg-slate-800/60 hover:text-white border border-transparent"
      ]}
    >
      <.icon
        name={@icon}
        class={[
          "size-4 transition-colors",
          @is_active && "text-indigo-300",
          !@is_active && "text-slate-500 group-hover:text-slate-300"
        ]}
      />
      <span>{@label}</span>
    </.link>
    """
  end
end
