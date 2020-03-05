# Crypto Fetcher

Track your favorite crypto currencies. 

Designed to showcase Elixir basic concurrency concepts (`spawn`, `mailboxes`, `receive`) and the Actor Concurrency Model.
 
 ## Start
 
 Open a iex instance and start a Server pid connection: `Server.start`
 Store that pid and spawn Clients at will: `server_pid |> Client.request_portefolio`
