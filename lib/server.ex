defmodule Server do
  import IEx

  def start do
    # & creates the necessary anonymous function the BEAM process creation
    spawn(&loop/0)
  end

  defp loop do
    receive do
      {:fetch_portefolio, portefolio, caller} ->
        portefolio |> Enum.map(&fetch_crypto/1) |> send_response_to_client(caller)
    end

    loop()
  end

  defp fetch_crypto(crypto) do
    crypto
    |> assets_endpoint()
    |> HTTPoison.get!()
    |> Map.fetch!(:body)
    |> Jason.decode!
    |> parse
  end

  defp parse(%{"data" => data} = portefolio) do
    %{
      symbol: data["symbol"],
      priceEur: String.to_float(data["priceUsd"]) |> usd_to_eur,
      volumeEur24Hr: String.to_float(data["volumeUsd24Hr"]) |> usd_to_eur
    }
  end

  defp parse(%{"error" => error} = portefolio) do
    cond do
      String.contains?(error, "not found") -> %{"error": "Unknown asset"}
    end
  end

  defp usd_to_eur(amount), do: amount * 0.91

  defp send_response_to_client(portefolio, caller), do: send(caller, {:portefolio, portefolio})

  defp assets_endpoint(crypto), do: "https://api.coincap.io/v2/assets/" <> crypto
end
