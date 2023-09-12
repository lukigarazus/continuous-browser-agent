defmodule Escort do
  defstruct [:pid]

  def init() do
    {:ok, pid} = GenServer.start_link(Escort.BrowserAgentGenServer, nil)

    %__MODULE__{pid: pid}
  end

  def confirm_age(escort) do
    GenServer.call(
      escort.pid,
      :confirm_age
    )
  end

  def set_filters(escort, filters) do
    GenServer.call(
      escort.pid,
      {:set_filters, filters}
    )
  end

  def execute(escort, action) do
    GenServer.call(
      escort.pid,
      {:execute, action}
    )
  end

  def terminate(escort) do
    GenServer.call(
      escort.pid,
      :terminate
    )
  end
end
