defmodule Rtfw.CommandRouter do
  @moduledoc """
  Very simple command router.
  """

  alias Nostrum.Api

  @commands %{
    "info" => &__MODULE__.info/2
  }

  @prefix "rtfw "
  def dispatch(@prefix <> rest, msg) do
    [cmd | args] = String.split(rest, " ")

    case Map.get(@commands, cmd) do
      nil -> :ignore
      fun -> fun.(msg, args)
    end
  end

  def dispatch(_content, _msg), do: :ignore

  def info(msg, _args) do
    Api.Message.create(msg.channel_id, "Built using [nostrum](https://github.com/Kraigie/nostrum).")
  end
end
