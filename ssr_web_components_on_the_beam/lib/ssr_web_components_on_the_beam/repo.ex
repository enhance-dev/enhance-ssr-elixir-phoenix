defmodule SsrWebComponentsOnTheBeam.Repo do
  use Ecto.Repo,
    otp_app: :ssr_web_components_on_the_beam,
    adapter: Ecto.Adapters.Postgres
end
