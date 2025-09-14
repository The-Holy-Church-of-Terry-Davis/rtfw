defmodule Rtfw.Bot do
  use GenServer
  alias Rtfw.Discord.Gateway

  def start_link() do
    GenServer.start_link(__MODULE__, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    Gateway.try_connect()
    {:ok, %{}}
  end

end
