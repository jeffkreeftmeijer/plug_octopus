defmodule Plug.OctopusTest do
  use ExUnit.Case
  doctest Plug.Octopus

  test "greets the world" do
    assert Plug.Octopus.hello() == :world
  end
end
