defmodule Rtfw.CommandRouter do
  @moduledoc """
  Very simple command router.
  """

  # alias Nostrum.Api
  alias Rtfw.Commands

  @commands %{
    "info" => &Commands.Info.info/2
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

end
