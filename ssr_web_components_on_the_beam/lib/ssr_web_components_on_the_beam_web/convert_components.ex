defmodule SsrWebComponentsOnTheBeamWeb.ConvertComponents do
  @wasm_plugin_path Path.expand("../../wasm/enhance-ssr.wasm", __DIR__)

    def create_plugin do

        manifest = %{wasm: [%{path: @wasm_plugin_path}]}

        # Create the plugin with Extism.Plugin.new
        case Extism.Plugin.new(manifest, true) do
          {:ok, plugin} ->
            {:ok, plugin}

          {:error, reason} ->
            {:error, reason}
        end
      end

    def call_enhance_plugin(plugin, data) do
      Extism.Plugin.call(plugin, "ssr", Jason.encode!(data))
    end
end
