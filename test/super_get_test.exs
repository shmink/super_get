defmodule SuperGetTest do
  use ExUnit.Case
  doctest SuperGet

  test "greets the world" do
    assert SuperGet.hello() == :world
  end
end
