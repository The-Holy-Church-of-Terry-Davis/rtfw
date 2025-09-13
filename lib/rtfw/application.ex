defmodule Rtfw.Application do
  use Application

  @impl true
  def start(_type, _args) do
    # token = Application.get_env(:nostrum, :token)

    # bot_options = %{
    #   name: Rtfw,
    #   consumer: Rtfw.Consumer,
    #   intents: [:direct_messages, :guild_messages, :message_content],
    #   wrapped_token: token
    # }

    children = [Rtfw.Bot]
    Supervisor.start_link(children, strategy: :one_for_one, name: Rtfw.Supervisor)
  end
end
