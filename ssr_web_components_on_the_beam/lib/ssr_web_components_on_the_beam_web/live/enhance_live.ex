defmodule SsrWebComponentsOnTheBeamWeb.EnhanceLive do
  use SsrWebComponentsOnTheBeamWeb, :live_view

  alias SsrWebComponentsOnTheBeamWeb.ConvertComponents

  def mount(_, _, socket) do
    socket =
      socket
      |> assign(:color, "text-red-500")

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
      <.enhance_header id="enhance" color={@color} />
      <button phx-click="change-color">Change Color</button>
    """
  end

  def enhance_header(assigns) do
    data = %{
      markup: "<my-header id=#{assigns.id} color=#{assigns.color}>Hello World</my-header>",
        elements: %{
          "my-header":
            "function MyHeader({ html, state }) {
              const { attrs, store } = state
              const attrs_color = attrs['color']
              const id = attrs['id']
              const store_works = store['readFromStore']
              return html`<h1 class='${attrs_color}'><slot></slot></h1><p>store works: ${store_works} </p><p>attrs id: ${id} </p><p>attrs color: ${attrs_color} </p>`
            }",
        },
        initialState: %{ readFromStore: "true" },
    }

    {:ok, plugin} = ConvertComponents.create_plugin()

    {:ok, output} = ConvertComponents.call_enhance_plugin(plugin, data)

    html = Jason.decode!(output)

    ~H"""
      <%= raw(html["document"]) %>
    """
  end

  def handle_event("change-color", _, socket) do
    {:noreply, assign(socket, :color, "text-blue-500")}
  end
end
