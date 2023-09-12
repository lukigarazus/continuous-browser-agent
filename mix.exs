defmodule ContinuousBrowserAgent.MixProject do
  use Mix.Project

  def project do
    [
      app: :continuous_browser_agent,
      version: "0.1.0",
      elixir: "~> 1.15-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # mod: {ContinuousBrowserAgent, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:wallaby, "~> 0.30"}
    ]
  end
end
