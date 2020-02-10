defmodule Client do

  @portefolio ["ethereum-classic", "golem", "litecoin"]

  def request_portefolio(server_pid) do
    send(server_pid, {:fetch_portefolio, @portefolio, self()})

    receive do
      {:portefolio, portefolio} ->
        IO.puts("--- Cryptfolio ----")
        portefolio |> IO.inspect()
    after 5000 ->
      {:error, :timeout}
    end
  end
end