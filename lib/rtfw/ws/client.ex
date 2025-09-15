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

  def handle_info(:send_identify, state) do 
    # https://discord.com/developers/docs/events/gateway#identifying
    IO.puts "Sending Identify (opcode 2) event..."
    payload = Jason.encode!(%{
      op: 2,
      d: %{
        token: Rtfw.token(),
        intents: 33280, # all: https://discord.com/developers/docs/events/gateway#list-of-intents
        properties: %{
          os: "agnostic",
          browser: "RTFW",
          device: "RTFW"
        }
      }
    })
    {:reply, {:text, payload}, state}
  end
end
