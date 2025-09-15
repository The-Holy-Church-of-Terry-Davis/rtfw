defmodule Rtfw.Ws.Client do
  use WebSockex
  alias Rtfw.Ws.Handlers.Receive
  alias Rtfw.Ws.Handlers.Disconnect

  def handle_connect(_conn, state) do
    IO.puts "Connected."
    {:ok, state}
  end

  def handle_frame(frame, state) do
    case Receive.handle(frame, state) do
      {:ok, new_state} -> {:ok, new_state}
    end
  end

  def handle_disconnect(reason, state) do
    Disconnect.handle(reason, state)
  end

  def handle_info(:send_heartbeat, state) do
    IO.puts "Sending heartbeat"
    {:reply, {:text, Jason.encode!(%{op: 1, d: nil})}, state}
  end
end
