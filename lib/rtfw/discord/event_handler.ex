defmodule Rtfw.Discord.EventHandler do
  
  def handle("READY", data, state) do
    session_id = data |> Map.get("d") |> Map.get("session_id")
    client_user = data |> Map.get("d") |> Map.get("user")
    client_id = Map.get(client_user, "id")
    client_name = Map.get(client_user, "username")

    IO.puts "Received READY event! Session ID: #{session_id}"
    IO.puts "Logged in as #{client_name} (#{client_id})!"

    new_state = Map.put(state, :session_id, session_id)
    {:ok, new_state}
  end

  def handle("MESSAGE_CREATE", data, state) do
    Rtfw.Discord.Events.MessageCreate.handle(data, state)
  end

  def handle(event_type, _data, state) do
    IO.puts "Unhandled event type #{event_type}"
    {:ok, state}
  end

end
