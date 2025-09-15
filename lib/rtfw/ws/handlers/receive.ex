defmodule Rtfw.Ws.Handlers.Receive do

  def handle({:text, msg}, state) do
    
    case Jason.decode(msg) do
      {:ok, data} -> match_op(data, state)
      {:error, reason} ->
        IO.puts "Rtfw.Ws.Handlers.Receive: ERROR: #{inspect(reason)}"
        {:ok, state}

    end
    {:ok, state}
  end

  defp match_op(data, state) do
    op = Map.get(data, "op")

    cond do
      op == 10 ->
        heartbeat_interval = data |> Map.get("d") |> Map.get("heartbeat_interval")
        manage_heartbeat(heartbeat_interval, state)
      
      op == 11 ->
        IO.puts "Heartbeat ACK from Discord."

      true ->
        IO.puts "Rtfw.WS.Handlers.Receive: Unhandled OP code: #{op}"

    end

    {:ok, state}
  end

  defp manage_heartbeat(interval, state) do 
    # https://discord.com/developers/docs/events/gateway#heartbeat-interval
    jitter = :rand.uniform()
    Task.async(fn ->
      :timer.sleep(interval * jitter)
    end)
    {:ok, state}
  end
end
