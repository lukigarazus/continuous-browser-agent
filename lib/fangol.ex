defmodule Fangol do
  defstruct [:pid]

  def init() do
    {:ok, pid} = GenServer.start_link(Fangol.BrowserAgentGenServer, nil)

    %__MODULE__{pid: pid}
  end

  def get_posts(fangol) do
    GenServer.call(
      fangol.pid,
      :get_posts
    )
  end

  def execute(fangol, action) do
    GenServer.call(
      fangol.pid,
      {:execute, action}
    )
  end

  def terminate(fangol) do
    GenServer.call(
      fangol.pid,
      :terminate
    )
  end
end
