defmodule SageBunnyElixirTest do
  use ExUnit.Case
  doctest SageBunnyElixir

  test "greets the world" do
    assert SageBunnyElixir.hello() == :world
  end
end
