defmodule Rtfw do
  @moduledoc """
  Documentation for `Rtfw`.
  """

  def token do
    Application.get_env(:rtfw, :token, 0)
  end

  def prefix do
    Application.get_env(:rtfw, :prefix, 0)
  end

end
