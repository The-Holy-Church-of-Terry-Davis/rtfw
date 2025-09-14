defmodule Rtfw.Discord.Gateway do
  use WebSockex
  alias Rtfw.Discord.Constants

  def try_connect() do
    {:ok, _pid} = WebSockex.start_link(Constants.gateway_wss_url(), Rtfw.Ws.Client, %{}) 
    :ok
  end
 
end
