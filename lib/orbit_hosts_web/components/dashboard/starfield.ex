defmodule OrbitHostsWeb.Components.Starfield do
  @moduledoc """
  A decorative animated starfield background.

  Stars are generated client-side by a colocated JS hook, which also drives
  a subtle mouse-based parallax effect. Twinkle animations use the Web
  Animations API — no CSS keyframes required. Use as a background inside a
  `relative` positioned container.

      <div class="relative">
        <Starfield.starfield />
        <div class="relative z-10">...your content...</div>
      </div>
  """
  use Phoenix.Component

  attr :id, :string, default: "starfield"
  attr :count, :integer, default: 80, doc: "number of stars to generate"
  attr :class, :string, default: ""

  def starfield(assigns) do
    ~H"""
    <div
      id={@id}
      phx-hook=".StarfieldHook"
      phx-update="ignore"
      data-count={@count}
      class={[
        "absolute inset-0 overflow-hidden bg-gradient-to-br from-slate-950 via-indigo-950/40 to-slate-950",
        @class
      ]}
    >
      <%!-- Nebula glows for depth --%>
      <div class="absolute top-1/4 left-1/3 h-96 w-96 rounded-full bg-indigo-600/10 blur-3xl pointer-events-none">
      </div>
      <div class="absolute bottom-1/4 right-1/4 h-96 w-96 rounded-full bg-fuchsia-600/10 blur-3xl pointer-events-none">
      </div>
      <%!-- Stars get injected here by the hook --%>
      <div data-star-layer class="absolute inset-0 pointer-events-none"></div>
      <script :type={Phoenix.LiveView.ColocatedHook} name=".StarfieldHook">
        const COLORS = [
          "#7dd3fc", // sky-300
          "#a5b4fc", // indigo-300
          "#f0abfc", // fuchsia-300
          "#fde68a", // amber-200
          "#6ee7b7", // emerald-300
          "#fda4af", // rose-300
          "#c4b5fd", // violet-300
          "#a5f3fc", // cyan-200
        ];

        const rand = (min, max) => min + Math.random() * (max - min);

        export default {
          mounted() {
            this.layer = this.el.querySelector("[data-star-layer]");
            this.count = parseInt(this.el.dataset.count, 10) || 80;
            this.stars = new Set();
            this.mouseX = 0;
            this.mouseY = 0;
            this.rafId = null;
            this.alive = true;

            // seed the field — stagger initial delays so they don't all bloom at once
            for (let i = 0; i < this.count; i++) {
              this.spawnStar(Math.random() * 8000);
            }

            this.onMouseMove = this.handleMouseMove.bind(this);
            window.addEventListener("mousemove", this.onMouseMove, { passive: true });
            this.tick();
          },

          destroyed() {
            this.alive = false;
            window.removeEventListener("mousemove", this.onMouseMove);
            if (this.rafId) cancelAnimationFrame(this.rafId);
            for (const wrapper of this.stars) {
              if (wrapper._animation) wrapper._animation.cancel();
              wrapper.remove();
            }
            this.stars.clear();
          },

          spawnStar(initialDelay = 0) {
            if (!this.alive) return;

            const sizeRoll = Math.random() ** 2;
            const size = 0.5 + sizeRoll * 4.5;
            const depth = sizeRoll;
            const color = COLORS[Math.floor(Math.random() * COLORS.length)];
            const duration = rand(2, 9) * 1000;
            const peakOpacity = rand(0.4, 1);
            const peakScale = rand(1.0, 1.4);

            const star = document.createElement("div");
            star.className = "absolute rounded-full will-change-transform";
            star.style.cssText = `
              top: ${rand(0, 100)}%;
              left: ${rand(0, 100)}%;
              width: ${size}px;
              height: ${size}px;
              background: ${color};
              box-shadow: 0 0 ${size * 3}px ${color};
              opacity: 0;
            `;

            const animation = star.animate(
              [
                { opacity: 0, transform: "scale(0.6)" },
                { opacity: peakOpacity, transform: `scale(${peakScale})` },
                { opacity: 0, transform: "scale(0.6)" },
              ],
              {
                duration,
                delay: initialDelay,
                iterations: 1,
                easing: "ease-in-out",
              }
            );

            const wrapper = document.createElement("div");
            wrapper.className = "absolute inset-0 will-change-transform";
            wrapper.dataset.depth = depth.toFixed(3);
            wrapper._animation = animation;
            wrapper.appendChild(star);

            this.stars.add(wrapper);
            this.layer.appendChild(wrapper);

            animation.finished
              .then(() => {
                this.stars.delete(wrapper);
                wrapper.remove();
                this.spawnStar();
              })
              .catch(() => {
                // animation was cancelled (component destroyed) — do nothing
              });
          },

          handleMouseMove(e) {
            this.mouseX = (e.clientX / window.innerWidth - 0.5) * 2;
            this.mouseY = (e.clientY / window.innerHeight - 0.5) * 2;
          },

          tick() {
            if (!this.alive) return;
            const maxShift = 12;
            for (const wrapper of this.stars) {
              const depth = parseFloat(wrapper.dataset.depth);
              const x = -this.mouseX * maxShift * depth;
              const y = -this.mouseY * maxShift * depth;
              wrapper.style.transform = `translate3d(${x}px, ${y}px, 0)`;
            }
            this.rafId = requestAnimationFrame(() => this.tick());
          },
        };
      </script>
    </div>
    """
  end
end
