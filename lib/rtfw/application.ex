defmodule Rtfw.Application do
  use Application

  @impl true
  def start(_type, _args) do

    cond do
      Rtfw.token() == 0 ->
        IO.puts "RTFW/Application: Token not found in config.exs"
        :init.stop()
      Rtfw.prefix() == 0 ->
        IO.puts "RTFW/Application: Prefix not found in config.exs"
        :init.stop()
      true ->
        IO.puts "RTFW/Application: Loaded config.exs"
    end

    children = [
      %{
        id: Rtfw.Bot,
        start: {Rtfw.Bot, :start_link, []}
      }
    ]
    opts = [strategy: :one_for_one, name: Rtfw.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
