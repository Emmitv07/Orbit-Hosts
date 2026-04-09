defmodule OrbitHostsWeb.BillingLive do
  use OrbitHostsWeb, :live_view

  alias OrbitHostsWeb.Layouts

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Billing")
     |> assign(:active_nav, "billing")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.Dashboard.dashboard
      flash={@flash}
      active_nav={@active_nav}
      page_subtitle="Billing"
    >
      <div class="space-y-6">
        <div>
          <h1 class="text-2xl sm:text-3xl font-bold text-white tracking-tight">Billing</h1>
          <p class="mt-1 text-sm text-slate-400">
            View invoices, manage your plan, and update payment methods.
          </p>
        </div>

        <div class="rounded-2xl border border-slate-800/80 bg-gradient-to-br from-indigo-500/10 to-fuchsia-500/10 backdrop-blur-sm p-6">
          <div class="flex items-start justify-between flex-wrap gap-4">
            <div>
              <p class="text-xs font-medium text-indigo-300 uppercase tracking-wider">Current Plan</p>
              <p class="mt-1 text-2xl font-bold text-white">Free</p>
              <p class="mt-1 text-sm text-slate-400">1 server, 1 GB RAM, community support</p>
            </div>
            <button class="inline-flex items-center gap-2 rounded-lg bg-gradient-to-r from-indigo-500 to-fuchsia-500 px-4 py-2 text-sm font-semibold text-white shadow-lg shadow-indigo-500/20 hover:shadow-indigo-500/40 hover:scale-[1.02] active:scale-[0.98] transition-all">
              <.icon name="hero-arrow-up-circle" class="size-4" /> Upgrade Plan
            </button>
          </div>
        </div>

        <div class="rounded-2xl border border-slate-800/80 bg-slate-900/40 backdrop-blur-sm p-6">
          <h3 class="text-base font-semibold text-white">Invoice History</h3>
          <p class="mt-1 text-sm text-slate-400">No invoices yet.</p>
        </div>
      </div>
    </Layouts.Dashboard.dashboard>
    """
  end
end
