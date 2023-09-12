defmodule ContinuousBrowserAgentTest do
  use ExUnit.Case
  doctest ContinuousBrowserAgent

  test "greets the world" do
    assert ContinuousBrowserAgent.hello() == :world
  end
end
