defmodule Client do

  @portefolio ["ethereum-classic", "bitcoin", "litecoin"]

  def request_portefolio(server_pid) do
    send(server_pid, {self(), :fetch_portefolio, @portefolio})

    receive do
      {:portefolio, portefolio} ->
        portefolio
    after 5000 ->
      {:error, :timeout}
    end
  end
end