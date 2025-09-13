defmodule Rtfw.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [Rtfw.Bot]
    Supervisor.start_link(children, strategy: :one_for_one, name: Rtfw.Supervisor)
  end
end
