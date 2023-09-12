defmodule Filmweb do
  defstruct [:pid]

  def init() do
    {:ok, pid} = GenServer.start_link(Filmweb.BrowserAgentGenServer, nil)

    filmweb = %__MODULE__{pid: pid}

    filmweb |> accept_cookies()
    filmweb |> bypass_ads()

    filmweb
  end

  defp accept_cookies(filmweb) do
    GenServer.call(filmweb.pid, :accept_cookies)
  end

  defp bypass_ads(filmweb) do
    GenServer.call(filmweb.pid, :bypass_ads, 10000)
  end

  def get_wanted_list(filmweb, username) do
    GenServer.call(filmweb.pid, {:get_wanted_list, username})
  end

  def execute(fangol, action) do
    GenServer.call(
      fangol.pid,
      {:execute, action}
    )
  end
end
