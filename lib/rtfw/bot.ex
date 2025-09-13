defmodule Rtfw.Bot do
  use Nostrum.Consumer

  alias Rtfw.CommandRouter

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    CommandRouter.dispatch(msg.content, msg)
  end

  def handle_event(_event), do: :noop
end
