defmodule Rtfw.Commands.Info do
  @moduledoc """
  Info command.
  """
  alias Nostrum.Api

  def info(msg, _args) do
    Api.Message.create(msg.channel_id, "Built using [nostrum](https://github.com/Kraigie/nostrum).")
  end

end
