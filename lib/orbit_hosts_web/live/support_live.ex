defmodule OrbitHostsWeb.SupportLive do
  use OrbitHostsWeb, :live_view

  alias OrbitHostsWeb.Layouts

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Support")
     |> assign(:active_nav, "support")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.Dashboard.dashboard
      flash={@flash}
      active_nav={@active_nav}
      page_subtitle="Support"
    >
      <div class="space-y-6">
        <div>
          <h1 class="text-2xl sm:text-3xl font-bold text-white tracking-tight">Support</h1>
          <p class="mt-1 text-sm text-slate-400">
            We're here to help — pick the channel that fits you best.
          </p>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          <.support_card
            icon="hero-book-open"
            title="Documentation"
            description="Guides, tutorials, and reference docs."
            cta="Browse docs"
          />
          <.support_card
            icon="hero-chat-bubble-left-right"
            title="Community Discord"
            description="Chat with other operators and our team."
            cta="Join Discord"
          />
          <.support_card
            icon="hero-lifebuoy"
            title="Open a Ticket"
            description="Get direct help from the Orbit Hosts team."
            cta="Contact support"
          />
        </div>
      </div>
    </Layouts.Dashboard.dashboard>
    """
  end

  attr :icon, :string, required: true
  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :cta, :string, required: true

  defp support_card(assigns) do
    ~H"""
    <div class="group rounded-xl border border-slate-800/80 bg-slate-900/50 backdrop-blur-sm p-5 hover:border-indigo-500/40 hover:bg-slate-900/70 transition-all">
      <div class="h-9 w-9 rounded-lg bg-slate-800/80 border border-slate-700/50 flex items-center justify-center group-hover:bg-indigo-500/10 group-hover:border-indigo-500/30 transition-colors">
        <.icon name={@icon} class="size-4 text-slate-400 group-hover:text-indigo-300 transition-colors" />
      </div>
      <h3 class="mt-4 text-sm font-semibold text-white">{@title}</h3>
      <p class="mt-1 text-xs text-slate-400">{@description}</p>
      <p class="mt-3 text-xs font-medium text-indigo-300 group-hover:text-indigo-200">{@cta} →</p>
    </div>
    """
  end
end
