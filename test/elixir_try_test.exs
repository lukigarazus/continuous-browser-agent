defmodule ElixirTryTest do
  use ExUnit.Case
  doctest ElixirTry

  test "greets the world" do
    assert ElixirTry.hello() == :world
  end
end
