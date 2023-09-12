defmodule ElixirTry do
  @moduledoc """
  Documentation for `ElixirTry`.
  """

  use Application
  use Wallaby.DSL

  def start(site) do
    Application.ensure_all_started(:wallaby)

    {:ok, session} = Wallaby.start_session(headless: false)
    IO.inspect(session)

    session
    |> visit("http://akash.im")

    Process.sleep(5000)

    session
    |> page_title()
    |> IO.inspect()

    Wallaby.end_session(session)
  end
end
