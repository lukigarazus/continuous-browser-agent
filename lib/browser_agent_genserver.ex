defmodule BrowserAgentGenServer do
  defmacro __using__([page_model, url]) do
    quote do
      use GenServer
      use Wallaby.DSL

      @url unquote(url)

      def init(_) do
        {:ok, session} = Wallaby.start_session(headless: false)

        session
        |> visit(@url)

        {:ok, {session, unquote(page_model).new()}}
      end

      def handle_call(:terminate, _from, {session, _}) do
        Wallaby.end_session(session)
        {:stop, :normal, :ok}
      end

      def handle_call({:execute, fun}, _from, {session, struct} = state) do
        fun.(session, struct)
        {:reply, :ok, state}
      end

      def handle_call({command, args}, _from, state) do
        IO.puts("Handle call with arguments")
        {result, state} = Kernel.apply(unquote(page_model), command, [args, state])
        {:reply, result, state}
      end

      def handle_call(command, _from, state) do
        {result, state} = Kernel.apply(unquote(page_model), command, [state])
        {:reply, result, state}
      end
    end
  end
end
