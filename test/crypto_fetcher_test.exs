defmodule CryptoFetcherTest do
  use ExUnit.Case
  doctest CryptoFetcher

  test "greets the world" do
    assert CryptoFetcher.hello() == :world
  end
end
