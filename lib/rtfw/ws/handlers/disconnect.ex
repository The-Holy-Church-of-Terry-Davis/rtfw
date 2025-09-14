defmodule Rtfw.Ws.Handlers.Disconnect do

  # TODO: Eventually add exponential backoff.

  def handle(%{reason: {:remote, 1000, _msg}}, state) do
    IO.puts "Normal disconnect, attempting reconnect..."
    {:reconnect, state}
  end

  def handle(reason, state) do
    IO.puts "Disconnected: #{inspect(reason)}"
    {:ok, state}
  end

end
